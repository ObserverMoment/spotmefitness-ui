import 'package:flutter/cupertino.dart';
import 'package:sofie_ui/blocs/theme_bloc.dart';
import 'package:sofie_ui/components/animated/mounting.dart';
import 'package:sofie_ui/components/buttons.dart';
import 'package:sofie_ui/components/layout.dart';
import 'package:sofie_ui/components/media/video/uploadcare_video_player.dart';
import 'package:sofie_ui/components/media/video/video_uploader.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/components/user_input/click_to_edit/text_row_click_to_edit.dart';
import 'package:sofie_ui/extensions/context_extensions.dart';
import 'package:sofie_ui/extensions/enum_extensions.dart';
import 'package:sofie_ui/extensions/type_extensions.dart';
import 'package:sofie_ui/generated/api/graphql_api.dart';

class CustomMoveCreatorMeta extends StatelessWidget {
  final Move move;
  final void Function(Map<String, dynamic> data) updateMove;
  const CustomMoveCreatorMeta(
      {Key? key, required this.move, required this.updateMove})
      : super(key: key);

  Widget _buildValidrepTypeButton(
      BuildContext context, WorkoutMoveRepType repType) {
    final bool isSelected = move.validRepTypes.contains(repType);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: CupertinoButton(
          padding: EdgeInsets.zero,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 250),
            opacity: isSelected ? 1 : 0.6,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              decoration: BoxDecoration(
                  color: isSelected ? Styles.colorOne : null,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                      color: isSelected
                          ? Styles.colorOne
                          : context.theme.primary.withOpacity(0.65))),
              child: MyText(
                repType.display,
                color: isSelected ? Styles.white : null,
              ),
            ),
          ),
          onPressed: () => updateMove({
                'validRepTypes': move.validRepTypes
                    .toggleItem(repType)
                    .map((rt) => rt.apiValue)
                    .toList()
              })),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          UserInputContainer(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const MyText(
                  'Demo Video',
                ),
                VideoUploader(
                    videoUri: move.demoVideoUri,
                    videoThumbUri: move.demoVideoThumbUri,
                    displaySize: const Size(60, 60),
                    onUploadSuccess: (v, t) {
                      context.showToast(message: 'Video uploaded');
                      updateMove({
                        'demoVideoUri': v,
                        'demoVideoThumbUri': t,
                      });
                    },
                    removeVideo: () {
                      updateMove({
                        'demoVideoUri': null,
                        'demoVideoThumbUri': null,
                      });
                      context.showToast(message: 'Video removed');
                    }),
              ],
            ),
          ),
          if (move.demoVideoUri != null)
            FadeIn(
              child: UserInputContainer(
                child: SizedBox(
                    height: 200,
                    child: InlineUploadcareVideoPlayer(
                        key: Key(move.demoVideoUri!),
                        videoUri: move.demoVideoUri!)),
              ),
            ),
          UserInputContainer(
            child: EditableTextFieldRow(
              title: 'Name',
              text: move.name,
              onSave: (text) => updateMove({'name': text}),
              inputValidation: (text) => text.length >= 3,
              maxChars: 50,
            ),
          ),
          UserInputContainer(
            child: EditableTextAreaRow(
              title: 'Description',
              text: move.description ?? '',
              onSave: (text) => updateMove({'description': text}),
              maxDisplayLines: 5,
              inputValidation: (t) => true,
            ),
          ),
          UserInputContainer(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    MyText(
                      'Valid Rep Types',
                    ),
                    InfoPopupButton(
                        infoWidget: MyText('What are valid rep types'))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const MyText(
                      'TIME + ',
                      weight: FontWeight.bold,
                    ),
                    _buildValidrepTypeButton(context, WorkoutMoveRepType.reps),
                    _buildValidrepTypeButton(
                        context, WorkoutMoveRepType.calories),
                    _buildValidrepTypeButton(
                        context, WorkoutMoveRepType.distance),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 16)
        ],
      ),
    );
  }
}
