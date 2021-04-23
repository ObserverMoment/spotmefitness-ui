import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/navigation.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/tappable_row.dart';
import 'package:spotmefitness_ui/components/user_input/creators/custom_move_creator/custom_move_creator_body.dart';
import 'package:spotmefitness_ui/components/user_input/creators/custom_move_creator/custom_move_creator_equipment.dart';

import 'package:spotmefitness_ui/components/user_input/creators/custom_move_creator/custom_move_creator_meta.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/move_type_selector.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class CustomMoveCreator extends StatefulWidget {
  /// For use when editing.
  final Move? move;
  CustomMoveCreator({this.move});
  @override
  _CustomMoveCreatorState createState() => _CustomMoveCreatorState();
}

class _CustomMoveCreatorState extends State<CustomMoveCreator> {
  int _activeTabIndex = 0;
  late Move? _activeMove;
  final PageController _pageController = PageController();
  bool _formIsDirty = false;

  @override
  void initState() {
    super.initState();
    _activeMove =
        widget.move != null ? Move.fromJson(widget.move!.toJson()) : null;
  }

  void _updateMoveType(MoveType moveType) {
    if (_activeMove == null) {
      final newMove = Move()
        ..$$typename = 'Move'
        ..id = 'temp'
        ..name = 'Custom Move'
        ..moveType = moveType
        ..validRepTypes = WorkoutMoveRepType.values
            .where((v) => v != WorkoutMoveRepType.artemisUnknown)
            .toList()
        ..scope = MoveScope.custom
        ..bodyAreaMoveScores = []
        ..requiredEquipments = []
        ..selectableEquipments = [];
      setState(() => _activeMove = newMove);

      /// TODO: Also create the move in the DB.
      /// Get back the proper id and then overwrite.
    } else {
      setState(() => _activeMove!.moveType = moveType);

      /// TODO: Update via API.
    }
  }

  void _updateMove(Map<String, dynamic> data) {
    _formIsDirty = true;

    /// Client.
    setState(() {
      _activeMove = Move.fromJson({..._activeMove!.toJson(), ...data});
    });

    /// Api.
    /// TODO!!.
  }

  void _changeTab(int index) {
    _pageController.jumpToPage(
      index,
    );
    Utils.hideKeyboard(context);
    setState(() => _activeTabIndex = index);
  }

  Future<void> _saveAndClose() async {
    print('send updates to the api and update local cache on response');
    context.pop();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CreateEditPageNavBar(
        handleClose: context.pop,
        handleSave: _saveAndClose,
        saveText: 'Done',
        formIsDirty: _formIsDirty,
        inputValid: _activeMove != null && _activeMove!.name.length >= 3,
        title: widget.move == null ? 'New Move' : 'Edit Move',
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TappableRow(
                  onTap: () => context.push(
                      child: MoveTypeSelector(
                          moveType: _activeMove?.moveType,
                          updateMoveType: _updateMoveType)),
                  title: 'Move Type',
                  display: _activeMove?.moveType != null
                      ? MoveTypeTag(_activeMove!.moveType)
                      : null),
            ),
            if (_activeMove?.moveType != null)
              FadeIn(
                child: MyTabBarNav(
                    titles: ['Meta', 'Equipment', 'Body'],
                    handleTabChange: _changeTab,
                    activeTabIndex: _activeTabIndex),
              ),
            if (_activeMove?.moveType != null)
              Expanded(
                child: FadeIn(
                  child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: _changeTab,
                    children: [
                      CustomMoveCreatorMeta(
                        move: _activeMove!,
                        updateMove: _updateMove,
                      ),
                      CustomMoveCreatorEquipment(
                        move: _activeMove!,
                        updateMove: _updateMove,
                      ),
                      CustomMoveCreatorBody(
                        move: _activeMove!,
                        updateMove: _updateMove,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
