import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:spotmefitness_ui/blocs/logged_workout_creator_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/logged_wokout_section_summary_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/navigation.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:spotmefitness_ui/services/graphql_operation_names.dart';
import 'package:spotmefitness_ui/services/sharing_and_linking.dart';
import 'package:spotmefitness_ui/services/store/store_utils.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:supercharged/supercharged.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

class DoWorkoutLogWorkoutPage extends StatefulWidget {
  final ScheduledWorkout? scheduledWorkout;
  const DoWorkoutLogWorkoutPage({Key? key, this.scheduledWorkout})
      : super(key: key);

  @override
  _DoWorkoutLogWorkoutPageState createState() =>
      _DoWorkoutLogWorkoutPageState();
}

class _DoWorkoutLogWorkoutPageState extends State<DoWorkoutLogWorkoutPage> {
  /// Each section displays a list style summary on a single page ()
  PageController _pageController = PageController();
  int _activeTabIndex = 0;

  final kNavbarIconSize = 34.0;
  bool _logSavedToDB = false;
  bool _savingToDB = false;

  Future<void> _createLoggedWorkout(LoggedWorkout loggedWorkout) async {
    setState(() => _savingToDB = true);

    final input = CreateLoggedWorkoutInput.fromJson(loggedWorkout.toJson());

    /// Add the data associated with the schedule workout if it exists.
    if (widget.scheduledWorkout != null) {
      input.note = widget.scheduledWorkout!.note;
      input.scheduledWorkout =
          ConnectRelationInput(id: widget.scheduledWorkout!.id);
      if (widget.scheduledWorkout!.gymProfile != null)
        input.gymProfile =
            ConnectRelationInput(id: widget.scheduledWorkout!.gymProfile!.id);
    }

    final variables = CreateLoggedWorkoutArguments(data: input);

    final result = await context.graphQLStore
        .mutate<CreateLoggedWorkout$Mutation, CreateLoggedWorkoutArguments>(
      mutation: CreateLoggedWorkoutMutation(variables: variables),
      addRefToQueries: [GQLNullVarsKeys.userLoggedWorkoutsQuery],
    );

    setState(() => _savingToDB = false);

    await checkOperationResult(context, result);

    if (widget.scheduledWorkout != null) {
      LoggedWorkoutCreatorBloc.updateScheduleWithLoggedWorkout(
          context, widget.scheduledWorkout!, result.data!.createLoggedWorkout);
    }

    setState(() => _logSavedToDB = true);

    if (result.hasErrors || result.data == null) {
      context.showToast(
          message: 'There was a problem, the log was not saved...',
          toastType: ToastType.destructive);
    } else {}
  }

  void _handleExitRequest() {
    if (_logSavedToDB) {
      context.popRoute();
    } else {
      context.showDialog(
          title: 'Leave without logging?',
          barrierDismissible: true,
          actions: [
            CupertinoDialogAction(
                child: MyText('Confirm'),
                onPressed: () {
                  context.pop();
                  context.popRoute();
                }),
            CupertinoDialogAction(
              child: MyText('Cancel'),
              onPressed: context.pop,
            ),
          ]);
    }
  }

  Widget _buildLoggedWorkoutSummaryForSharing(
      List<LoggedWorkoutSection> sortedSections) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: sortedSections
          .map((s) => Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MyText('these are titles'),
                    ),
                    Flexible(
                      child: LoggedWorkoutSectionSummaryCard(
                        loggedWorkoutSection: s,
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loggedWorkout =
        context.select<DoWorkoutBloc, LoggedWorkout>((b) => b.loggedWorkout);

    final sortedSections = loggedWorkout.loggedWorkoutSections
        .sortedBy<num>((ls) => ls.sortPosition);

    /// When doing a workout 'live' the timeTakenMs should always be non null as it gets added by the [DoWorkoutBloc] in section complete.
    /// Being null here is an error.
    final totalTimeMs =
        loggedWorkout.loggedWorkoutSections.sumBy((s) => s.timeTakenMs!);

    return CupertinoPageScaffold(
        child: SafeArea(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              H3("All done, great work!"),
              TextButton(
                padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                underline: false,
                text: 'Done',
                onPressed: _handleExitRequest,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyText('Time spent working:'),
              SizedBox(width: 8),
              H3(
                Duration(milliseconds: totalTimeMs).compactDisplay(),
                color: Styles.colorTwo,
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AnimatedSwitcher(
              duration: kStandardAnimationDuration,
              child: _logSavedToDB
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        H3('Log Saved'),
                        SizedBox(width: 6),
                        Icon(
                          CupertinoIcons.checkmark_alt,
                          color: Styles.peachRed,
                        )
                      ],
                    )
                  : PrimaryButton(
                      prefixIconData: CupertinoIcons.doc_chart,
                      withMinWidth: false,
                      loading: _savingToDB,
                      text: 'Save Log',
                      onPressed: () => _createLoggedWorkout(loggedWorkout)),
            ),
            PrimaryButton(
                prefixIconData: CupertinoIcons.paperplane,
                withMinWidth: false,
                loading: _savingToDB,
                text: 'Share Summary',
                onPressed: () => SharingAndLinking.shareImageRenderOfWidget(
                    padding: const EdgeInsets.all(16),
                    context: context,
                    text: 'Just nailed this workout!',
                    subject: 'Just nailed this workout!',
                    widgetForImageCapture:
                        _buildLoggedWorkoutSummaryForSharing(sortedSections))),
          ],
        ),
        SizedBox(height: 20),
        Expanded(
          child: ContentBox(
              padding: const EdgeInsets.only(top: 16),
              child: Column(
                children: [
                  MyTabBarNav(
                      titles: sortedSections
                          .map<String>((section) =>
                              Utils.textNotNull(section.name)
                                  ? section.name!
                                  : 'Section ${section.sortPosition + 1}')
                          .toList(),
                      handleTabChange: (i) {
                        _pageController.toPage(i);
                        setState(() => _activeTabIndex = i);
                      },
                      activeTabIndex: _activeTabIndex),
                  Expanded(
                    child: PageView(
                        controller: _pageController,
                        onPageChanged: (i) =>
                            setState(() => _activeTabIndex = i),
                        children: sortedSections
                            .mapIndexed((i, _) => _LoggedWorkoutSectionWrapper(
                                sectionIndex: i,
                                logAlreadySavedToDB: _logSavedToDB))
                            .toList()),
                  ),
                ],
              )),
        ),
      ]),
    ));
  }
}

/// Hooks into the bloc to pull out the correct logged workout section based on the section index and provides it to the pure UI widget [LoggedWorkoutSectionSummarycard].
class _LoggedWorkoutSectionWrapper extends StatelessWidget {
  final int sectionIndex;

  /// So disable note editing functionality.
  final bool logAlreadySavedToDB;
  const _LoggedWorkoutSectionWrapper(
      {Key? key, required this.sectionIndex, required this.logAlreadySavedToDB})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loggedWorkoutSection =
        context.select<DoWorkoutBloc, LoggedWorkoutSection>((b) => b
            .loggedWorkout.loggedWorkoutSections
            .firstWhere((lws) => lws.sortPosition == sectionIndex));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
      child: LoggedWorkoutSectionSummaryCard(
          loggedWorkoutSection: loggedWorkoutSection,
          showSectionName: false,
          addNoteToLoggedSection: logAlreadySavedToDB
              ? null
              : (note) => context
                  .read<DoWorkoutBloc>()
                  .addNoteToLoggedWorkoutSection(sectionIndex, note)),
    );
  }
}
