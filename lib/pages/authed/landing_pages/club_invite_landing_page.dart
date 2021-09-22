import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:sofie_ui/blocs/auth_bloc.dart';
import 'package:sofie_ui/blocs/theme_bloc.dart';
import 'package:sofie_ui/components/animated/loading_shimmers.dart';
import 'package:sofie_ui/components/buttons.dart';
import 'package:sofie_ui/components/future_builder_handler.dart';
import 'package:sofie_ui/components/layout.dart';
import 'package:sofie_ui/components/media/images/sized_uploadcare_image.dart';
import 'package:sofie_ui/components/media/images/user_avatar.dart';
import 'package:sofie_ui/components/tags.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/extensions/context_extensions.dart';
import 'package:sofie_ui/generated/api/graphql_api.dart';
import 'package:sofie_ui/model/enum.dart';
import 'package:sofie_ui/router.gr.dart';
import 'package:sofie_ui/services/utils.dart';

class ClubInviteLandingPage extends StatefulWidget {
  final String id;
  const ClubInviteLandingPage({Key? key, @PathParam('id') required this.id})
      : super(key: key);

  @override
  _ClubInviteLandingPageState createState() => _ClubInviteLandingPageState();
}

class _ClubInviteLandingPageState extends State<ClubInviteLandingPage> {
  /// https://stackoverflow.com/questions/57793479/flutter-futurebuilder-gets-constantly-called
  late Future<CheckClubInviteTokenResult> _checkClubInviteTokenFuture;

  @override
  void initState() {
    super.initState();
    _checkClubInviteTokenFuture = _checkClubInviteToken();
  }

  Future<CheckClubInviteTokenResult> _checkClubInviteToken() async {
    final variables = CheckClubInviteTokenArguments(id: widget.id);
    final result = await context.graphQLStore.networkOnlyOperation<
            CheckClubInviteToken$Query, CheckClubInviteTokenArguments>(
        operation: CheckClubInviteTokenQuery(variables: variables));

    if (result.hasErrors || result.data == null) {
      throw Exception(
          'There was a network error while trying to get details of this invite.');
    } else {
      return result.data!.checkClubInviteToken;
    }
  }

  Future<void> _addUserToClub(BuildContext context, Club club) async {
    final authedUserId = GetIt.I<AuthBloc>().authedUser!.id;
    context.showLoadingAlert('Joining Club...',
        icon: const Icon(CupertinoIcons.star_fill));

    final variables = AddUserToClubViaInviteTokenArguments(
        userId: authedUserId, clubInviteTokenId: widget.id);

    final result = await context.graphQLStore.networkOnlyOperation<
            AddUserToClubViaInviteToken$Mutation,
            AddUserToClubViaInviteTokenArguments>(
        operation: AddUserToClubViaInviteTokenMutation(variables: variables));

    context.pop(); // Loading dialog.

    if (result.hasErrors || result.data == null) {
      result.errors?.forEach((e) {
        printLog(e.toString());
      });
      context.showToast(
          message: 'Sorry, there was a problem joining the club.',
          toastType: ToastType.destructive);
    } else {
      // Successfully joined - pop this screen and push to the Club details page.
      context.router.popAndPush(ClubDetailsRoute(id: club.id));
    }
  }

  Widget _buildOwnerAvatar(Club club) => Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              UserAvatar(
                avatarUri: club.owner.avatarUri,
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: MyText(
                  club.owner.displayName,
                  size: FONTSIZE.one,
                ),
              ),
            ],
          ),
          const Positioned(
              top: 0,
              child: Tag(
                tag: 'Owner',
                color: Styles.infoBlue,
                textColor: Styles.white,
              )),
        ],
      );

  Widget _buildContentText(String text) => MyText(
        text,
        weight: FontWeight.bold,
        size: FONTSIZE.four,
      );

  @override
  Widget build(BuildContext context) {
    return FutureBuilderHandler<CheckClubInviteTokenResult>(
        future: _checkClubInviteTokenFuture,
        loadingWidget: const ShimmerDetailsPage(
          title: 'Getting invite info...',
        ),
        builder: (data) {
          if (data is InviteTokenError) {
            return _TokenErrorMessageScreen(
              error: data,
            );
          } else {
            /// data must be type [ClubInviteTokenData]
            final club = (data as ClubInviteTokenData).club;

            /// 1 is the owner.
            final totalMembers = 1 + club.admins.length + club.members.length;

            final authedUserId = GetIt.I<AuthBloc>().authedUser?.id;
            final userIsOwner = authedUserId == club.owner.id;
            final userIsAdmin = club.admins.any((a) => a.id == authedUserId);

            final userIsMember = userIsOwner ||
                userIsAdmin ||
                club.members.any((m) => m.id == authedUserId);

            return CupertinoPageScaffold(
                child: Column(
              children: [
                SizedBox(
                    height: 200,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        SizedBox.expand(
                          child: Utils.textNotNull(club.coverImageUri)
                              ? SizedUploadcareImage(club.coverImageUri!)
                              : Image.asset(
                                  'assets/social_images/group_placeholder.jpg',
                                  fit: BoxFit.cover,
                                ),
                        ),
                        if (!userIsMember)
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                PrimaryButton(
                                    withMinWidth: false,
                                    prefixIconData:
                                        CupertinoIcons.checkmark_alt,
                                    text: 'Yes, join the Club!',
                                    onPressed: () =>
                                        _addUserToClub(context, club)),
                                SecondaryButton(
                                    withMinWidth: false,
                                    prefixIconData: CupertinoIcons.xmark,
                                    text: 'No, thanks',
                                    onPressed: context.pop)
                              ],
                            ),
                          )
                      ],
                    )),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 12),
                    shrinkWrap: true,
                    children: [
                      const MyText(
                        'You have been invited to join a club!',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      MyHeaderText(
                        club.name,
                        size: FONTSIZE.six,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      _buildOwnerAvatar(club),
                      if (userIsMember)
                        Column(
                          children: [
                            const SizedBox(height: 16),
                            const MyText(
                                'Looks like you already joined this Club!'),
                            const SizedBox(height: 24),
                            SecondaryButton(
                                text: 'View Club Details',
                                onPressed: () => context.router
                                    .popAndPush(ClubDetailsRoute(id: club.id))),
                            const SizedBox(height: 24),
                            SecondaryButton(
                                text: 'Go Back', onPressed: context.pop)
                          ],
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    if (Utils.textNotNull(club.location))
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(CupertinoIcons.location,
                                              size: 18, color: Styles.infoBlue),
                                          const SizedBox(width: 2),
                                          MyText(club.location!,
                                              color: Styles.infoBlue)
                                        ],
                                      ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(CupertinoIcons.person_2,
                                            size: 20),
                                        const SizedBox(width: 8),
                                        MyText('$totalMembers')
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              if (Utils.textNotNull(club.description))
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ViewMoreFullScreenTextBlock(
                                    text: club.description!,
                                    title: 'Description',
                                    maxLines: 6,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    /// TODO: Get the data from the club once it is being returned.
                                    _buildContentText('x workouts'),
                                    _buildContentText('x plans'),
                                    _buildContentText('x challenges'),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                    ],
                  ),
                ),
              ],
            ));
          }
        });
  }
}

class _TokenErrorMessageScreen extends StatelessWidget {
  final InviteTokenError error;
  const _TokenErrorMessageScreen({Key? key, required this.error})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyPageScaffold(
        child: SafeArea(
            child: Column(
      children: [
        MyText(error.message),
        TextButton(
            prefix: const Icon(CupertinoIcons.arrow_left),
            text: 'Close',
            onPressed: context.pop)
      ],
    )));
  }
}
