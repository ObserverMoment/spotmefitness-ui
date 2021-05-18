import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/media/audio/audio_players.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// Displays an icon which can be clicked to open the audio player.
/// Cannot display a placeholder...unlike the similar video player, as there is not image associated with these audio uploads.
class AudioThumbnailPlayer extends StatelessWidget {
  final String audioUri;
  final String playerTitle;
  final Size displaySize;
  final String? tag;
  final IconData iconData;

  AudioThumbnailPlayer(
      {required this.audioUri,
      this.playerTitle = 'Preview Audio',
      this.tag,
      this.iconData = CupertinoIcons.waveform,
      this.displaySize = const Size(120, 120)});

  Future<void> _listenToAudio(BuildContext context) async {
    await context.showBottomSheet(
        expand: true,
        child: FullAudioPlayer(
          audioUri: audioUri,
          title: playerTitle,
          autoPlay: true,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _listenToAudio(context);
      },
      child: Stack(
        children: [
          Container(
            width: displaySize.width,
            height: displaySize.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Styles.colorOne,
              boxShadow: [Styles.avatarBoxShadow],
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(iconData,
                    color: Styles.white.withOpacity(0.3),
                    size: displaySize.width / 1.2),
                Icon(
                  CupertinoIcons.play_circle,
                  size: displaySize.width / 2.5,
                  color: Styles.white.withOpacity(0.6),
                ),
              ],
            ),
          ),
          if (tag != null)
            Positioned(
                top: 0,
                left: 0,
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.5, horizontal: 3),
                    decoration: BoxDecoration(
                        color: Styles.black,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8))),
                    child: MyText(
                      tag!,
                      size: FONTSIZE.TINY,
                      weight: FontWeight.bold,
                      color: Styles.white,
                    ))),
        ],
      ),
    );
  }
}
