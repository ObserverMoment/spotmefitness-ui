import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/creators/custom_move_creator/custom_move_creator_body.dart';
import 'package:spotmefitness_ui/components/creators/custom_move_creator/custom_move_creator_equipment.dart';
import 'package:spotmefitness_ui/components/creators/custom_move_creator/custom_move_creator_meta.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/navigation.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/tappable_row.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/move_type_selector.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// Updates everything to DB when user saves and closes.
class CustomMoveCreatorPage extends StatefulWidget {
  /// For use when editing.
  final Move? move;
  CustomMoveCreatorPage({this.move});
  @override
  _CustomMoveCreatorPageState createState() => _CustomMoveCreatorPageState();
}

class _CustomMoveCreatorPageState extends State<CustomMoveCreatorPage> {
  int _activeTabIndex = 0;
  late Move? _activeMove;
  final PageController _pageController = PageController();
  bool _formIsDirty = false;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _activeMove =
        widget.move != null ? Move.fromJson(widget.move!.toJson()) : null;
  }

  Future<void> _updateMoveType(MoveType moveType) async {
    _formIsDirty = true;
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
    } else {
      setState(() => _activeMove!.moveType = moveType);
    }
  }

  /// Client only. Updates are sent to the DB when user saves and closes.
  void _updateMove(Map<String, dynamic> data) {
    setState(() {
      _formIsDirty = true;
      _activeMove = Move.fromJson({..._activeMove!.toJson(), ...data});
    });
  }

  void _changeTab(int index) {
    _pageController.jumpToPage(
      index,
    );
    Utils.hideKeyboard(context);
    setState(() => _activeTabIndex = index);
  }

  Future<void> _saveAndClose() async {
    setState(() => _loading = true);
    if (widget.move != null) {
      // Update.
      final variables = UpdateMoveArguments(
          data: UpdateMoveInput.fromJson(_activeMove!.toJson()));

      final result = await context.graphQLStore.mutate(
          mutation: UpdateMoveMutation(variables: variables),
          broadcastQueryIds: [UserCustomMovesQuery().operationName]);

      if (result.hasErrors) {
        context.showToast(
            message: 'Sorry, it went wrong, changes not saved!',
            toastType: ToastType.destructive);
      } else {
        context.pop(result: true);
      }
    } else {
      // Create.
      final variables = CreateMoveArguments(
          data: CreateMoveInput.fromJson(_activeMove!.toJson()));

      final result = await context.graphQLStore.create(
          mutation: CreateMoveMutation(variables: variables),
          addRefToQueries: [UserCustomMovesQuery().operationName]);

      if (result.hasErrors) {
        context.showToast(
            message: 'Sorry, it went wrong, changes not saved!',
            toastType: ToastType.destructive);
      } else {
        context.pop(result: true);
      }
    }

    setState(() => _loading = false);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyPageScaffold(
      navigationBar: BasicNavBar(
          heroTag: 'CustomMoveCreatorPage',
          customLeading: NavBarCancelButton(context.pop),
          middle: NavBarTitle(widget.move == null ? 'New Move' : 'Edit Move'),
          trailing: _formIsDirty
              ? FadeIn(
                  child: NavBarSaveButton(
                    _saveAndClose,
                    loading: _loading,
                  ),
                )
              : null),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
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
