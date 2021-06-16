import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/images/sized_uploadcare_image.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class BottomSheetMenuItem {
  String text;
  Widget? icon;
  bool isDestructive;
  Function() onPressed;
  BottomSheetMenuItem(
      {required this.text,
      this.icon,
      this.isDestructive = false,
      required this.onPressed});
}

class BottomSheetMenu extends StatelessWidget {
  final List<BottomSheetMenuItem> items;
  final Widget? header;
  BottomSheetMenu({required this.items, this.header})
      : assert(items.length > 0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (header != null)
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                  child: header,
                ),
                HorizontalLine(),
              ],
            ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12.0, left: 20, right: 20, bottom: 20),
              child: ContentBox(
                child: ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => Container(
                          height: 1,
                          color: context.theme.primary.withOpacity(0.07),
                        ),
                    itemCount: items.length,
                    itemBuilder: (context, index) =>
                        BottomSheetMenuItemContainer(
                          items[index],
                        )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomSheetMenuHeader extends StatelessWidget {
  final String? imageUri;
  final String name;
  final String subtitle;
  const BottomSheetMenuHeader(
      {Key? key, this.imageUri, required this.name, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (Utils.textNotNull(imageUri))
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedUploadcareImage(
                imageUri!,
                displaySize: Size(64, 64),
              ),
            ),
          ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MyText(
                name,
                weight: FontWeight.bold,
                size: FONTSIZE.BIG,
              ),
              MyText(
                subtitle,
                subtext: true,
                weight: FontWeight.bold,
                size: FONTSIZE.BIG,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class BottomSheetMenuItemContainer extends StatelessWidget {
  final BottomSheetMenuItem bottomSheetMenuItem;
  BottomSheetMenuItemContainer(
    this.bottomSheetMenuItem,
  );

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      onPressed: () {
        context.pop();
        bottomSheetMenuItem.onPressed();
      },
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        MyText(
          bottomSheetMenuItem.text,
          color: bottomSheetMenuItem.isDestructive
              ? Styles.errorRed
              : context.theme.primary,
          weight: FontWeight.bold,
        ),
        if (bottomSheetMenuItem.icon != null) bottomSheetMenuItem.icon!,
      ]),
    );
  }
}
