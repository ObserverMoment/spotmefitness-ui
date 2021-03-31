import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:spotmefitness_ui/extensions.dart';

class EquipmentTile extends StatelessWidget {
  final Equipment equipment;
  final bool showIcon;
  final bool showText;
  final bool isSelected;
  final double iconSize;
  final FONTSIZE fontSize;
  final bool withBorder;
  EquipmentTile(
      {required this.equipment,
      this.isSelected = false,
      this.showIcon = true,
      this.showText = true,
      this.iconSize = 38,
      this.fontSize = FONTSIZE.MAIN,
      this.withBorder = true})
      : assert(showIcon || showText);

  @override
  Widget build(BuildContext context) {
    final Color primary = context.theme.primary;
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: isSelected ? Styles.colorOne : primary.withOpacity(0.03),
          borderRadius: BorderRadius.circular(4),
          border:
              withBorder ? Border.all(color: primary.withOpacity(0.5)) : null),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (showIcon)
            SizedBox(
                width: iconSize,
                height: iconSize,
                child: Utils.getEquipmentIcon(context, equipment.name,
                    isSelected: isSelected,
                    color:
                        isSelected ? Styles.white : primary.withOpacity(0.8))),
          if (showText)
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: MyText(
                  equipment.name,
                  size: fontSize,
                  color: isSelected ? Styles.white : primary.withOpacity(0.8),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  lineHeight: 1,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class EquipmentMultiSelector extends StatelessWidget {
  final List<Equipment> selectedEquipments;
  final List<Equipment> equipments;
  final Function(Equipment) handleSelection;
  final bool showIcon;
  final int crossAxisCount;
  final Axis scrollDirection;
  EquipmentMultiSelector({
    required this.selectedEquipments,
    required this.equipments,
    this.showIcon = false,
    required this.handleSelection,
    this.crossAxisCount = 1,
    this.scrollDirection = Axis.horizontal,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: GridView.builder(
          scrollDirection: scrollDirection,
          shrinkWrap: true,
          itemCount: equipments.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => handleSelection(equipments[index]),
              child: EquipmentTile(
                  showIcon: showIcon,
                  equipment: equipments[index],
                  isSelected: selectedEquipments.contains(equipments[index])),
            );
          }),
    );
  }
}
