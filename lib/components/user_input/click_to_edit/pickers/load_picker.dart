import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/sliding_select.dart';
import 'package:spotmefitness_ui/components/user_input/number_input.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class LoadPickerDisplay extends StatelessWidget {
  final double loadAmount;
  final void Function(double loadAmount, LoadUnit loadUnit) updateLoad;
  final LoadUnit loadUnit;
  final bool expandPopup;
  LoadPickerDisplay(
      {required this.loadAmount,
      required this.updateLoad,
      required this.loadUnit,
      this.expandPopup = false});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.showBottomSheet(
          expand: expandPopup,
          child: LoadPickerModal(
            loadAmount: loadAmount,
            updateLoad: updateLoad,
            loadUnit: loadUnit,
          )),
      child: ContentBox(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyText(
              loadAmount.stringMyDouble(),
              size: FONTSIZE.DISPLAY,
            ),
            SizedBox(
              width: 4,
            ),
            MyText(
              loadUnit.display,
              size: FONTSIZE.LARGE,
            )
          ],
        ),
      ),
    );
  }
}

class LoadPickerModal extends StatefulWidget {
  final double loadAmount;
  final void Function(double loadAmount, LoadUnit loadUnit) updateLoad;
  final LoadUnit loadUnit;
  LoadPickerModal(
      {required this.loadAmount,
      required this.loadUnit,
      required this.updateLoad});

  @override
  _LoadPickerModalState createState() => _LoadPickerModalState();
}

class _LoadPickerModalState extends State<LoadPickerModal> {
  late TextEditingController _loadAmountController;
  late double _activeLoadAmount;
  late LoadUnit _activeLoadUnit;

  @override
  void initState() {
    super.initState();
    _activeLoadAmount = widget.loadAmount;
    _activeLoadUnit = widget.loadUnit;
    _loadAmountController =
        TextEditingController(text: widget.loadAmount.stringMyDouble());
    // Select text on open.
    _loadAmountController.selection = TextSelection(
        baseOffset: 0, extentOffset: _loadAmountController.value.text.length);
    _loadAmountController.addListener(() {
      if (Utils.textNotNull(_loadAmountController.text)) {
        setState(
            () => _activeLoadAmount = double.parse(_loadAmountController.text));
      }
    });
  }

  void _saveChanges() {
    if (_activeLoadAmount != widget.loadAmount ||
        _activeLoadUnit != widget.loadUnit) {
      widget.updateLoad(_activeLoadAmount, _activeLoadUnit);
    }
    context.pop();
  }

  @override
  void dispose() {
    _loadAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalCupertinoPageScaffold(
      cancel: context.pop,
      save: _saveChanges,
      validToSave: Utils.textNotNull(_loadAmountController.text),
      title: 'Load',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: MyNumberInput(
              _loadAmountController,
              allowDouble: true,
              autoFocus: true,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SlidingSelect<LoadUnit>(
                  value: _activeLoadUnit,
                  children: {
                    for (final v in LoadUnit.values
                        .where((v) => v != LoadUnit.artemisUnknown))
                      v: MyText(v.display)
                  },
                  updateValue: (loadUnit) =>
                      setState(() => _activeLoadUnit = loadUnit)),
            ],
          ),
        ],
      ),
    );
  }
}
