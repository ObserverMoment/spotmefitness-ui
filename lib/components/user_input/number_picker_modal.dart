import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// This widget uses scroll and step input to select an integer value within a min and max range.
/// For standard number input modals see [NumberInputModalInt] and [NumberInputModalDouble]
class NumberPickerModal extends StatefulWidget {
  final String title;
  final int? initialValue;
  final int min;
  final int max;
  final void Function(int value) saveValue;
  NumberPickerModal(
      {required this.initialValue,
      required this.saveValue,
      this.title = 'Enter...',
      required this.min,
      required this.max});
  @override
  _NumberPickerModalState createState() => _NumberPickerModalState();
}

class _NumberPickerModalState<T> extends State<NumberPickerModal> {
  late int _activeValue;
  late FixedExtentScrollController _scrollController;
  final double _itemExtent = 40;

  @override
  void initState() {
    super.initState();
    _activeValue = widget.initialValue ?? widget.min;
    _scrollController =
        FixedExtentScrollController(initialItem: _activeValue - widget.min);
  }

  void _handleScrollValueChange(int index) =>
      setState(() => _activeValue = widget.min + index);

  void _handleStepIncrement() {
    final newIndex = _scrollController.selectedItem + 1;
    setState(() => _activeValue = newIndex + widget.min);
    _animateToItem(newIndex);
  }

  void _handleStepDecrement() {
    final newIndex = _scrollController.selectedItem - 1;
    setState(() => _activeValue = newIndex + widget.min);
    _animateToItem(newIndex);
  }

  void _animateToItem(int index) => _scrollController.animateToItem(index,
      duration: Duration(milliseconds: 100), curve: Curves.easeInCubic);

  void _saveValue() {
    widget.saveValue(_activeValue);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return ModalCupertinoPageScaffold(
      resizeToAvoidBottomInset: true,
      cancel: context.pop,
      save: _saveValue,
      validToSave: _activeValue != widget.initialValue,
      title: widget.title,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 260,
            width: 150,
            child: CupertinoPicker(
                scrollController: _scrollController,
                itemExtent: _itemExtent,
                useMagnifier: true,
                magnification: 1.5,
                selectionOverlay: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: context.theme.primary,
                      ),
                      borderRadius: BorderRadius.circular(30)),
                ),
                onSelectedItemChanged: _handleScrollValueChange,
                children: List<Widget>.generate(
                    widget.max - widget.min + 1,
                    (i) => Center(
                            child: MyText(
                          (i + widget.min).toString(),
                          lineHeight: 1.2,
                          weight: FontWeight.bold,
                          size: FONTSIZE.HUGE,
                        )))),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoButton(
                  onPressed:
                      _activeValue != widget.min ? _handleStepDecrement : null,
                  child: Icon(
                    CupertinoIcons.minus_rectangle_fill,
                    size: 50,
                  )),
              CupertinoButton(
                  onPressed:
                      _activeValue != widget.max ? _handleStepIncrement : null,
                  child: Icon(
                    CupertinoIcons.plus_rectangle_fill,
                    size: 50,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
