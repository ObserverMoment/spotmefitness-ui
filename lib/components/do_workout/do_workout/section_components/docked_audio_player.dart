import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';

class DockedAudioPlayer extends StatelessWidget {
  final String? classAudioUri;
  const DockedAudioPlayer({Key? key, this.classAudioUri}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Styles.infoBlue.withOpacity(0.1),
      height: kDockedAudioPlayerHeight,
      child: MyText(
        'Spotify style audio player - auto plays in time with workout - only button is a mute button - animated playing icon when playing. If user not doing this section show message "audio will auto play when you are doing this section"',
        maxLines: 3,
        size: FONTSIZE.TINY,
      ),
    );
  }
}
