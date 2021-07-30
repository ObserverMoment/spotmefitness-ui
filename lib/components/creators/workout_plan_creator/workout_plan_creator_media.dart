import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/workout_plan_creator_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/media/audio/audio_uploader.dart';
import 'package:spotmefitness_ui/components/media/images/image_uploader.dart';
import 'package:spotmefitness_ui/components/media/video/video_uploader.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:provider/provider.dart';

class WorkoutPlanCreatorMedia extends StatelessWidget {
  final _thumbSize = Size(85, 85);

  @override
  Widget build(BuildContext context) {
    final coverImageUri = context.select<WorkoutPlanCreatorBloc, String?>(
        (b) => b.workoutPlan.coverImageUri);

    final introVideoUri = context.select<WorkoutPlanCreatorBloc, String?>(
        (b) => b.workoutPlan.introVideoUri);
    final introVideoThumbUri = context.select<WorkoutPlanCreatorBloc, String?>(
        (b) => b.workoutPlan.introVideoThumbUri);

    final introAudioUri = context.select<WorkoutPlanCreatorBloc, String?>(
        (b) => b.workoutPlan.introAudioUri);

    final _updateWorkoutPlanMeta =
        context.read<WorkoutPlanCreatorBloc>().updateWorkoutPlanMeta;
    final _setUploadingMedia =
        context.read<WorkoutPlanCreatorBloc>().setUploadingMedia;

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          children: [
            Row(
              children: [
                MyText(
                  'Plan Media',
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
                      imageUri: coverImageUri,
                      onUploadSuccess: (uri) =>
                          _updateWorkoutPlanMeta({'coverImageUri': uri}),
                      removeImage: (_) =>
                          _updateWorkoutPlanMeta({'coverImageUri': null}),
                    ),
                    SizedBox(height: 6),
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
                      videoUri: introVideoUri,
                      videoThumbUri: introVideoThumbUri,
                      onUploadStart: () => _setUploadingMedia(true),
                      onUploadSuccess: (video, thumb) {
                        _updateWorkoutPlanMeta({
                          'introVideoUri': video,
                          'introVideoThumbUri': thumb
                        });
                        _setUploadingMedia(false);
                      },
                      removeVideo: () => _updateWorkoutPlanMeta(
                          {'introVideoUri': null, 'introVideoThumbUri': null}),
                    ),
                    SizedBox(height: 6),
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
                      audioUri: introAudioUri,
                      onUploadStart: () => _setUploadingMedia(true),
                      onUploadSuccess: (uri) {
                        _updateWorkoutPlanMeta({
                          'introAudioUri': uri,
                        });
                        _setUploadingMedia(false);
                      },
                      removeAudio: () => _updateWorkoutPlanMeta({
                        'introAudioUri': null,
                      }),
                    ),
                    SizedBox(height: 6),
                    MyText(
                      'Intro Audio',
                      size: FONTSIZE.TINY,
                    )
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
