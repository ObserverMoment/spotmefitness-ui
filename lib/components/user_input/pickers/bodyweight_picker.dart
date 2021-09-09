import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/pickers/sliding_select.dart';
import 'package:spotmefitness_ui/components/user_input/number_input.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class BodyweightPickerDisplay extends StatelessWidget {
  final double? bodyweight;
  final void Function(double bodyweight, BodyweightUnit unit) updateBodyweight;
  final BodyweightUnit unit;
  final bool expandPopup;
  BodyweightPickerDisplay(
      {required this.bodyweight,
      required this.updateBodyweight,
      required this.unit,
      this.expandPopup = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.showBottomSheet(
          expand: expandPopup,
          child: BodyweightPickerModal(
            bodyweight: bodyweight,
            updateBodyweight: updateBodyweight,
            unit: unit,
          )),
      child: ContentBox(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyText(
              bodyweight != null ? bodyweight!.stringMyDouble() : ' - ',
              size: FONTSIZE.DISPLAY,
            ),
            SizedBox(
              width: 4,
            ),
            MyText(
              unit.display,
              size: FONTSIZE.LARGE,
            )
          ],
        ),
      ),
    );
  }
}

class BodyweightPickerModal extends StatefulWidget {
  final double? bodyweight;
  final void Function(double bodyweight, BodyweightUnit unit) updateBodyweight;
  final BodyweightUnit unit;
  BodyweightPickerModal(
      {required this.bodyweight,
      required this.unit,
      required this.updateBodyweight});

  @override
  _BodyweightPickerModalState createState() => _BodyweightPickerModalState();
}

class _BodyweightPickerModalState extends State<BodyweightPickerModal> {
  late TextEditingController _bodyweightController;
  late double? _activeBodyweight;
  late BodyweightUnit _activeUnit;

  @override
  void initState() {
    super.initState();

    /// Using zero as a 'null' / initial value for this input - the user shouldn't ever need to save their bodyweight as zero.
    _activeBodyweight = widget.bodyweight;
    _activeUnit = widget.unit;
    _bodyweightController = TextEditingController(
        text: widget.bodyweight != null
            ? widget.bodyweight!.stringMyDouble()
            : '0');

    // Select text on open.
    _bodyweightController.selection = TextSelection(
        baseOffset: 0, extentOffset: _bodyweightController.value.text.length);

    _bodyweightController.addListener(() {
      if (Utils.textNotNull(_bodyweightController.text)) {
        setState(
            () => _activeBodyweight = double.parse(_bodyweightController.text));
      }
    });
  }

  void _saveChanges() {
    if (_activeBodyweight != 0 &&
        _activeBodyweight != null &&
        (_activeBodyweight != widget.bodyweight ||
            _activeUnit != widget.unit)) {
      widget.updateBodyweight(_activeBodyweight!, _activeUnit);
    }
    context.pop();
  }

  @override
  void dispose() {
    _bodyweightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalCupertinoPageScaffold(
      cancel: context.pop,
      save: _saveChanges,
      validToSave: Utils.textNotNull(_bodyweightController.text),
      title: 'Bodyweight',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: MyNumberInput(
              _bodyweightController,
              allowDouble: true,
              autoFocus: true,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SlidingSelect<BodyweightUnit>(
                  value: _activeUnit,
                  children: {
                    for (final v in BodyweightUnit.values
                        .where((v) => v != BodyweightUnit.artemisUnknown))
                      v: MyText(v.display)
                  },
                  updateValue: (unit) => setState(() => _activeUnit = unit)),
            ],
          ),
        ],
      ),
    );
  }
}
