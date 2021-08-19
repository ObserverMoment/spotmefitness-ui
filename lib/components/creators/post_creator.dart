import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/timeline_post_card.dart';
import 'package:spotmefitness_ui/components/cards/workout_card.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/social/feeds_and_follows/model.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/text_input.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:stream_feed/stream_feed.dart' as feed;
import 'package:stream_feed/src/client/flat_feed.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:auto_route/auto_route.dart';

/// Create a post and sends it to GetStream.
/// Currently: Like an internal content share function. Can only share certain objects from within the app such as [Workout], [WorkoutPlan] etc.
class PostCreatorPage extends StatefulWidget {
  final feed.Activity? activity;

  /// Used when sharing objects directly from the UI.
  /// Format should be [type:id].
  final String? object;
  const PostCreatorPage({Key? key, this.activity, this.object})
      : assert(activity == null || object == null,
            'pass activity when updating a post, pass object when "sharing" an object via a post'),
        super(key: key);

  @override
  _PostCreatorPageState createState() => _PostCreatorPageState();
}

class _PostCreatorPageState extends State<PostCreatorPage> {
  /// Users always post to their feed [user_feed]
  late FlatFeed _feed;
  final TextEditingController _captionController = TextEditingController();

  /// Tags are text input one at at time via _tagsController
  final TextEditingController _tagInputController = TextEditingController();

  /// List of strings. Added to Activity as a comma separated list.
  /// "tag1,tag2,tag3".
  List<String> _tags = <String>[];

  /// The selected object to share + vars to save the data to display object summary.
  /// [type:id]
  String? _object;

  /// Only one of these should ever be not null.
  /// When saving a new one make sure you set all others null.
  Workout? _workout;
  WorkoutPlan? _workoutPlan;

  PageController _pageController = PageController();
  int _activePageIndex = 0;

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    if (widget.activity != null) {
      _object = widget.activity!.object;
      _captionController.text =
          widget.activity!.extraData?['caption'].toString() ?? '';
    } else if (widget.object != null) {
      _object = widget.object;
    }

    _feed = context.streamFeedClient
        .flatFeed('user_feed', GetIt.I<AuthBloc>().authedUser!.id);

    _captionController.addListener(() {
      setState(() {});
    });
    _tagInputController.addListener(() {
      setState(() {});
    });
  }

  /// Doesn't setState...
  void _removeAllObjects() {
    _workout = null;
    _workoutPlan = null;
  }

  void _selectWorkout(Workout w) {
    _removeAllObjects();
    _workout = w;
    _object = 'Workout:${w.id}';
    _changePage(1);
  }

  void _selectWorkoutPlan(WorkoutPlan plan) {
    _removeAllObjects();
    _workoutPlan = plan;
    _changePage(1);
  }

  void _addTag() {
    if (_tags.contains(_tagInputController.text)) {
      context.showToast(message: 'Tag already being used.');
    } else {
      setState(() {
        _tags.add(_tagInputController.text);
        _tagInputController.text = '';
      });
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
  }

  void _createPost() async {
    if (!Utils.textNotNull(_captionController.text) || _object == null) {
      throw Exception('Must supply a caption and and object to post.');
    }
    setState(() {
      _loading = true;
    });
    try {
      await _feed.addActivity(feed.Activity(
          actor: context.streamFeedClient.currentUser!.ref,
          verb: 'post',
          object: _object,
          extraData: {
            'caption': _captionController.text,
            // Try and ensure we alwasy pass a list of strings.
            // There is no type checking on the getStream side and ints, bools, objects etc will all be allowed.
            'tags': _tags.whereType<String>().toList()
          }));

      context.pop();
    } catch (e) {
      print(e);
      context.showToast(
          message: 'There was a problem creating the post.',
          toastType: ToastType.destructive);
      setState(() {
        _loading = false;
      });
    }
  }

  void _changePage(int index) {
    _pageController.toPage(
      index,
    );
    setState(() => _activePageIndex = index);
  }

  TimelinePostData get postDataForPreview => TimelinePostData()
    ..userId = 'TODO'
    ..userDisplayName = 'Username'
    ..userAvatarUri = _workout!.coverImageUri
    ..objectId = 'TODO'
    ..objectType = TimelinePostType.workout
    ..title = _workout!.name
    ..audioUri = 'TODO'
    ..imageUri = _workout!.coverImageUri
    ..videoUri = 'TODO'
    ..videoThumbUri = 'TODO';

  Widget get _buildLeading => AnimatedSwitcher(
        duration: kStandardAnimationDuration,
        child: _activePageIndex == 0
            ? NavBarCancelButton(context.pop)
            : CupertinoButton(
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
                onPressed: () => _changePage(0),
                child: Icon(
                  CupertinoIcons.arrow_left,
                  size: 22,
                  color: context.theme.primary,
                ),
              ),
      );

  Widget? get _buildTrailingPageOne => _object != null
      ? _loading
          ? NavBarTrailingRow(
              children: [
                NavBarLoadingDots(),
              ],
            )
          : NavBarSaveButton(
              () => _changePage(1),
              text: 'Next',
            )
      : null;

  Widget? get _buildTrailingPageTwo =>
      Utils.textNotNull(_captionController.text) && _object != null
          ? _loading
              ? NavBarTrailingRow(
                  children: [
                    NavBarLoadingDots(),
                  ],
                )
              : NavBarSaveButton(
                  _createPost,
                  text: 'Save',
                )
          : null;

  @override
  Widget build(BuildContext context) {
    return MyPageScaffold(
        navigationBar: BorderlessNavBar(
            customLeading: _buildLeading,
            middle: NavBarTitle(
                widget.activity == null ? 'Create Post' : 'Edit Post'),
            trailing: _activePageIndex == 0
                ? _buildTrailingPageOne
                : _buildTrailingPageTwo),
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [
            Column(
              children: [
                if (_object != null)
                  GrowIn(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: WorkoutCard(_workout!),
                  )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: MyText('Choose something to share.'),
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      ShareObjectTypeButton(
                        title: 'Workout',
                        description:
                            'Share a workout you have created, found or are going to do!',
                        assetImageUri:
                            'assets/home_page_images/home_page_workouts.jpg',
                        onPressed: () => context.pushRoute(
                            WorkoutFinderRoute(selectWorkout: _selectWorkout)),
                      ),
                      ShareObjectTypeButton(
                        title: 'Workout Plan',
                        description:
                            'Share a plan you have created, found or are going to do!',
                        assetImageUri:
                            'assets/home_page_images/home_page_plans.jpg',
                        onPressed: () {},
                        // onPressed: () => context.pushRoute(
                        //     WorkoutPlanFinderRoute(selectPlan: _selectWorkoutPlan)),
                      )
                    ],
                  ),
                )
              ],
            ),
            ListView(
              shrinkWrap: true,
              children: [
                MyTextAreaFormFieldRow(
                    placeholder: 'Description (required)',
                    autofocus: _captionController.text.isEmpty,
                    backgroundColor: context.theme.cardBackground,
                    keyboardType: TextInputType.text,
                    controller: _captionController),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: MyTextFormFieldRow(
                          backgroundColor: context.theme.cardBackground,
                          controller: _tagInputController,
                          // Don't allow any spaces or special chracters.
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp("[a-zA-Z0-9]")),
                          ],
                          placeholder: 'Tag...',
                          keyboardType: TextInputType.text),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: IconButton(
                          disabled: _tagInputController.text.length == 0,
                          iconData: CupertinoIcons.add,
                          onPressed: _addTag),
                    )
                  ],
                ),
                GrowInOut(
                    show: _tags.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: _tags
                            .map((t) => CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () => _removeTag(t),
                                  child: MyText(
                                    '#${t}',
                                    size: FONTSIZE.SMALL,
                                  ),
                                ))
                            .toList(),
                      ),
                    )),
                SizedBox(height: 10),
                HorizontalLine(),
                // Preview of what the post will look like.

                if (_object != null)
                  SizeFadeIn(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TimelinePostCard(
                          isPreview: true,
                          activityWithObjectData: ActivityWithObjectData(
                              feed.Activity(
                                  actor: 'me',
                                  verb: 'post',
                                  object: 'text',
                                  time: DateTime.now(),
                                  extraData: {
                                    'caption': _captionController.text,
                                    'tags': _tags
                                  }),
                              postDataForPreview)),
                    ),
                  )
              ],
            )
          ],
        ));
  }
}

class ShareObjectTypeButton extends StatelessWidget {
  final String title;
  final String description;
  final String assetImageUri;
  final VoidCallback onPressed;
  const ShareObjectTypeButton(
      {Key? key,
      required this.title,
      required this.description,
      required this.assetImageUri,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      pressedOpacity: 0.9,
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
            gradient: Styles.secondaryButtonGradient,
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 100,
                width: 100,
                child: Image.asset(
                  assetImageUri,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyHeaderText(
                    title,
                    color: Styles.white,
                    size: FONTSIZE.BIG,
                    lineHeight: 1.4,
                  ),
                  MyText(
                    description,
                    lineHeight: 1.4,
                    maxLines: 3,
                    color: Styles.white,
                    size: FONTSIZE.SMALL,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Icon(
                CupertinoIcons.chevron_right,
                size: 30,
                color: Styles.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
