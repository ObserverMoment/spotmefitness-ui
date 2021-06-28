import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class SectionModalContainer extends StatelessWidget {
  final Widget child;
  const SectionModalContainer({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.theme.themeName == ThemeName.dark;
    return LayoutBuilder(
        builder: (context, constraints) => ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: context.theme.primary
                              .withOpacity(isDark ? 0.1 : 0.05)),
                      boxShadow: [
                        BoxShadow(
                            color: CupertinoColors.black
                                .withOpacity(isDark ? 0.8 : 0.6),
                            blurRadius: 3, // soften the shadow
                            spreadRadius: 1.5, //extend the shadow
                            offset: Offset(
                              0.4, // Move to right horizontally
                              0.4, // Move to bottom Vertically
                            ))
                      ],
                      color: context.theme.background
                          .withOpacity(isDark ? 0.45 : 0.6),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                      child: child,
                    )),
              ),
            ));
  }
}
