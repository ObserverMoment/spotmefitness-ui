import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/media/images/sized_uploadcare_image.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class UserAvatar extends StatelessWidget {
  final String? avatarUri; // Uploadcare file ID. aka user.avatarUrl
  final double radius;
  final bool border;
  final double borderWidth;

  UserAvatar({
    this.radius = 100,
    this.avatarUri,
    this.border = false,
    this.borderWidth = 3,
  });

  Widget _buildAvatar(BuildContext context) => Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: Styles.black.withOpacity(0.7)),
      width: border ? radius - 10 : radius,
      height: border ? radius - 10 : radius,
      child: avatarUri == null
          ? Center(
              child: Icon(
                CupertinoIcons.person_alt,
                size: radius / 1.5,
              ),
            )
          : SizedUploadcareImage(
              avatarUri!,
              displaySize: Size.square(radius * 2),
            ));

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [Styles.avatarBoxShadow], shape: BoxShape.circle),
      child: border
          ? Container(
              padding: EdgeInsets.all(borderWidth),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: context.theme.primary),
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: context.theme.background, width: borderWidth)),
                child: _buildAvatar(context),
              ),
            )
          : _buildAvatar(context),
    );
  }
}

/// A circle that displays [+ overflow] in the same style as a user avatar.
class PlusOthersIcon extends StatelessWidget {
  final int overflow;
  final double radius;
  final bool border;
  final double borderWidth;

  PlusOthersIcon(
      {required this.overflow,
      this.radius = 100,
      this.border = false,
      this.borderWidth = 3});

  Widget _buildAvatar(BuildContext context) => Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: Styles.black.withOpacity(0.9)),
      width: border ? radius - 10 : radius,
      height: border ? radius - 10 : radius,
      child: Center(
          child: MyText(
        '+ 3',
        weight: FontWeight.bold,
        size: FONTSIZE.BIG,
        lineHeight: 1,
      )));

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [Styles.avatarBoxShadow], shape: BoxShape.circle),
      child: border
          ? Container(
              padding: EdgeInsets.all(borderWidth),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: context.theme.primary),
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: context.theme.background, width: borderWidth)),
                child: _buildAvatar(context),
              ),
            )
          : _buildAvatar(context),
    );
  }
}
