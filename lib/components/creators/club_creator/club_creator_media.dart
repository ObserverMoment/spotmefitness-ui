import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/media/audio/audio_uploader.dart';
import 'package:spotmefitness_ui/components/media/images/cover_image_uploader.dart';
import 'package:spotmefitness_ui/components/media/video/video_uploader.dart';
import 'package:spotmefitness_ui/components/text.dart';

class ClubCreatorMedia extends StatelessWidget {
  final String? coverImageUri;
  final void Function(String uri) onImageUploaded;
  final void Function(String uri) removeImage;
  final String? introVideoUri;
  final String? introVideoThumbUri;
  final void Function(String videoUri, String thumbUri) onVideoUploaded;
  final void Function() removeVideo;
  final String? introAudioUri;
  final void Function(String uri) onAudioUploaded;
  final void Function() removeAudio;
  final void Function() onMediaUploadStart;

  const ClubCreatorMedia(
      {Key? key,
      required this.coverImageUri,
      required this.onImageUploaded,
      required this.removeImage,
      required this.introVideoUri,
      required this.introVideoThumbUri,
      required this.introAudioUri,
      required this.onVideoUploaded,
      required this.removeVideo,
      required this.onAudioUploaded,
      required this.removeAudio,
      required this.onMediaUploadStart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        SizedBox(height: 12),
        CoverImageUploader(
          imageUri: coverImageUri,
          onUploadSuccess: onImageUploaded,
          removeImage: removeImage,
          onUploadStart: onMediaUploadStart,
        ),
        SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                VideoUploader(
                  videoUri: introVideoUri,
                  videoThumbUri: introVideoThumbUri,
                  onUploadSuccess: onVideoUploaded,
                  removeVideo: removeVideo,
                  onUploadStart: onMediaUploadStart,
                ),
                SizedBox(height: 10),
                MyText(
                  'Intro Video',
                  size: FONTSIZE.SMALL,
                )
              ],
            ),
            Column(
              children: [
                AudioUploader(
                  audioUri: introAudioUri,
                  onUploadSuccess: onAudioUploaded,
                  removeAudio: removeAudio,
                  onUploadStart: onMediaUploadStart,
                ),
                SizedBox(height: 10),
                MyText(
                  'Intro Audio',
                  size: FONTSIZE.SMALL,
                )
              ],
            ),
          ],
        )
      ],
    );
  }
}
