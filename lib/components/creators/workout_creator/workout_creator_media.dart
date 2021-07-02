import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:spotmefitness_ui/blocs/workout_creator_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/media/audio/audio_uploader.dart';
import 'package:spotmefitness_ui/components/media/images/image_uploader.dart';
import 'package:spotmefitness_ui/components/media/video/video_uploader.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class WorkoutCreatorMedia extends StatefulWidget {
  @override
  _WorkoutCreatorMediaState createState() => _WorkoutCreatorMediaState();
}

class _WorkoutCreatorMediaState extends State<WorkoutCreatorMedia> {
  late List<WorkoutSection> _workoutSections;
  late Workout _workout;
  late WorkoutCreatorBloc _bloc;

  final _thumbSize = Size(75, 75);

  void _checkForNewData() {
    if (_workout != _bloc.workout)
      setState(() {
        _workout = Workout.fromJson(_bloc.workout.toJson());
      });

    if (!listEquals(_workoutSections, _bloc.workout.workoutSections))
      setState(() {
        _workoutSections = [..._bloc.workout.workoutSections];
      });
  }

  @override
  void initState() {
    super.initState();
    _bloc = context.read<WorkoutCreatorBloc>();
    _workout = Workout.fromJson(_bloc.workout.toJson());
    _workoutSections = [..._bloc.workout.workoutSections];
    _bloc.addListener(_checkForNewData);
  }

  void _updateWorkoutData(Map<String, dynamic> data) =>
      context.read<WorkoutCreatorBloc>().updateWorkoutMeta(data);

  void _updateWorkoutSection(int sectionindex, Map<String, dynamic> data) =>
      context
          .read<WorkoutCreatorBloc>()
          .updateWorkoutSection(sectionindex, data);

  @override
  void dispose() {
    _bloc.removeListener(_checkForNewData);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    MyText(
                      'Workout',
                      weight: FontWeight.bold,
                    ),
                    InfoPopupButton(
                        infoWidget: MyText(
                            'Info about what the different workout media are used for'))
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        ImageUploader(
                          displaySize: _thumbSize,
                          imageUri: _workout.coverImageUri,
                          onUploadSuccess: (uri) =>
                              _updateWorkoutData({'coverImageUri': uri}),
                          removeImage: (_) =>
                              _updateWorkoutData({'coverImageUri': null}),
                        ),
                        MyText(
                          'Cover Image',
                          size: FONTSIZE.TINY,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        VideoUploader(
                          displaySize: _thumbSize,
                          videoUri: _workout.introVideoUri,
                          videoThumbUri: _workout.introVideoThumbUri,
                          onUploadStart: () => _bloc.setUploadingMedia(true),
                          onUploadSuccess: (video, thumb) {
                            _updateWorkoutData({
                              'introVideoUri': video,
                              'introVideoThumbUri': thumb
                            });
                            _bloc.setUploadingMedia(false);
                          },
                          removeVideo: () => _updateWorkoutData({
                            'introVideoUri': null,
                            'introVideoThumbUri': null
                          }),
                        ),
                        MyText(
                          'Intro Video',
                          size: FONTSIZE.TINY,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        AudioUploader(
                          displaySize: _thumbSize,
                          audioUri: _workout.introAudioUri,
                          onUploadStart: () => _bloc.setUploadingMedia(true),
                          onUploadSuccess: (uri) {
                            _updateWorkoutData({
                              'introAudioUri': uri,
                            });
                            _bloc.setUploadingMedia(false);
                          },
                          removeAudio: () => _updateWorkoutData({
                            'introAudioUri': null,
                          }),
                        ),
                        MyText(
                          'Intro Audio',
                          size: FONTSIZE.TINY,
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          ..._workoutSections
              .map(
                (section) => Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          MyText(
                            Utils.textNotNull(section.name)
                                ? section.name!
                                : 'Section ${section.sortPosition + 1}',
                            weight: FontWeight.bold,
                          ),
                          InfoPopupButton(
                              infoWidget: MyText(
                                  'Info about what the different workout section media are used for'))
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              VideoUploader(
                                displaySize: _thumbSize,
                                videoUri: section.introVideoUri,
                                videoThumbUri: section.introVideoThumbUri,
                                onUploadStart: () =>
                                    _bloc.setUploadingMedia(true),
                                onUploadSuccess: (video, thumb) {
                                  _updateWorkoutSection(section.sortPosition, {
                                    'introVideoUri': video,
                                    'introVideoThumbUri': thumb
                                  });
                                  _bloc.setUploadingMedia(false);
                                },
                                removeVideo: () => _updateWorkoutSection(
                                    section.sortPosition, {
                                  'introVideoUri': null,
                                  'introVideoThumbUri': null
                                }),
                              ),
                              MyText(
                                'Intro Video',
                                size: FONTSIZE.TINY,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              VideoUploader(
                                displaySize: _thumbSize,
                                videoUri: section.classVideoUri,
                                videoThumbUri: section.classVideoThumbUri,
                                onUploadStart: () =>
                                    _bloc.setUploadingMedia(true),
                                onUploadSuccess: (video, thumb) {
                                  _updateWorkoutSection(section.sortPosition, {
                                    'classVideoUri': video,
                                    'classVideoThumbUri': thumb
                                  });
                                  _bloc.setUploadingMedia(false);
                                },
                                removeVideo: () => _updateWorkoutSection(
                                    section.sortPosition, {
                                  'classVideoUri': null,
                                  'classVideoThumbUri': null
                                }),
                              ),
                              MyText(
                                'Class Video',
                                size: FONTSIZE.TINY,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              VideoUploader(
                                displaySize: _thumbSize,
                                videoUri: section.outroVideoUri,
                                videoThumbUri: section.outroVideoThumbUri,
                                onUploadStart: () =>
                                    _bloc.setUploadingMedia(true),
                                onUploadSuccess: (video, thumb) {
                                  _updateWorkoutSection(section.sortPosition, {
                                    'outroVideoUri': video,
                                    'outroVideoThumbUri': thumb
                                  });
                                  _bloc.setUploadingMedia(false);
                                },
                                removeVideo: () => _updateWorkoutSection(
                                    section.sortPosition, {
                                  'outroVideoUri': null,
                                  'outroVideoThumbUri': null
                                }),
                              ),
                              MyText(
                                'Outro Video',
                                size: FONTSIZE.TINY,
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              AudioUploader(
                                displaySize: _thumbSize,
                                audioUri: section.introAudioUri,
                                onUploadStart: () =>
                                    _bloc.setUploadingMedia(true),
                                onUploadSuccess: (uri) {
                                  _updateWorkoutSection(section.sortPosition, {
                                    'introAudioUri': uri,
                                  });
                                  _bloc.setUploadingMedia(false);
                                },
                                removeAudio: () => _updateWorkoutSection(
                                    section.sortPosition, {
                                  'introAudioUri': null,
                                }),
                              ),
                              MyText(
                                'Intro Audio',
                                size: FONTSIZE.TINY,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              AudioUploader(
                                displaySize: _thumbSize,
                                audioUri: section.classAudioUri,
                                onUploadStart: () =>
                                    _bloc.setUploadingMedia(true),
                                onUploadSuccess: (uri) {
                                  _updateWorkoutSection(section.sortPosition, {
                                    'classAudioUri': uri,
                                  });
                                  _bloc.setUploadingMedia(false);
                                },
                                removeAudio: () => _updateWorkoutSection(
                                    section.sortPosition, {
                                  'classAudioUri': null,
                                }),
                              ),
                              MyText(
                                'Class Audio',
                                size: FONTSIZE.TINY,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              AudioUploader(
                                displaySize: _thumbSize,
                                audioUri: section.outroAudioUri,
                                onUploadStart: () =>
                                    _bloc.setUploadingMedia(true),
                                onUploadSuccess: (uri) {
                                  _updateWorkoutSection(section.sortPosition, {
                                    'outroAudioUri': uri,
                                  });
                                  _bloc.setUploadingMedia(false);
                                },
                                removeAudio: () => _updateWorkoutSection(
                                    section.sortPosition, {
                                  'outroAudioUri': null,
                                }),
                              ),
                              MyText(
                                'Outro Audio',
                                size: FONTSIZE.TINY,
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
              .toList()
        ],
      ),
    );
  }
}
