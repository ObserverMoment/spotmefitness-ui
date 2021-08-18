import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/media/images/sized_uploadcare_image.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class UserAvatar extends StatelessWidget {
  final String? avatarUri; // Uploadcare file ID. aka user.avatarUrl
  final double size;
  final bool border;
  final double borderWidth;
  final bool withBoxShadow;

  const UserAvatar({
    this.size = 100,
    this.avatarUri,
    this.border = false,
    this.borderWidth = 3,
    this.withBoxShadow = true,
  });

  Widget _buildAvatar(BuildContext context) => Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: Styles.black.withOpacity(0.7)),
      width: border ? size - (borderWidth * 2) : size,
      height: border ? size - (borderWidth * 2) : size,
      child: avatarUri == null
          ? Center(
              child: Icon(
                CupertinoIcons.person_alt,
                size: size / 1.5,
              ),
            )
          : SizedUploadcareImage(
              avatarUri!,
              displaySize: Size.square(size * 2),
            ));

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: withBoxShadow ? [Styles.avatarBoxShadow] : null,
          shape: BoxShape.circle),
      child: border
          ? Container(
              padding: EdgeInsets.all(borderWidth),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: context.theme.cardBackground),
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
  final double size;
  final bool border;
  final double borderWidth;

  PlusOthersIcon(
      {required this.overflow,
      this.size = 100,
      this.border = false,
      this.borderWidth = 3});

  Widget _buildAvatar(BuildContext context) => Container(
      clipBehavior: Clip.antiAlias,
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: context.theme.primary),
      width: border ? size - 10 : size,
      height: border ? size - 10 : size,
      child: Center(
          child: MyText(
        '+$overflow',
        color: context.theme.background,
        weight: FontWeight.bold,
        size: FONTSIZE.SMALL,
        lineHeight: 1,
      )));

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [Styles.avatarBoxShadow], shape: BoxShape.circle),
      child: border
          ? Container(
              padding: EdgeInsets.all(borderWidth / 2),
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
