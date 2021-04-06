import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/media/images/sized_uploadcare_image.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class UserAvatar extends StatelessWidget {
  final String avatarUri; // Uploadcare file ID. aka user.avatarUrl
  final double radius;
  final bool border;

  UserAvatar({
    this.radius = 100,
    required this.avatarUri,
    this.border = false,
  });

  Widget _buildAvatar(BuildContext context) => Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: Styles.black.withOpacity(0.7)),
      width: border ? radius - 10 : radius,
      height: border ? radius - 10 : radius,
      child: SizedUploadcareImage(
        avatarUri,
        displaySize: Size.square(radius * 2),
      ));

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [Styles.avatarBoxShadow], shape: BoxShape.circle),
      child: border
          ? Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: SweepGradient(
                    center: FractionalOffset.center,
                    colors: <Color>[
                      Styles.colorOne.withOpacity(0.9),
                      Styles.colorFour.withOpacity(0.5),
                      Styles.colorTwo.withOpacity(0.7),
                      Styles.colorOne.withOpacity(0.9),
                    ],
                  )),
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color:
                            CupertinoTheme.of(context).scaffoldBackgroundColor,
                        width: 3)),
                child: _buildAvatar(context),
              ),
            )
          : _buildAvatar(context),
    );
  }
}

class SpotMeAvatar extends StatelessWidget {
  final double radius;
  SpotMeAvatar({this.radius = 100});

  @override
  Widget build(BuildContext context) {
    final double _padding = radius / 5.8;
    return Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: Styles.black.withOpacity(0.7)),
        width: radius,
        height: radius,
        child: Padding(
            padding: EdgeInsets.all(_padding),
            child: SvgPicture.asset('assets/logos/apotme_fitness_logo.svg',
                width: radius - _padding * 2,
                color: context.theme.background)));
  }
}
