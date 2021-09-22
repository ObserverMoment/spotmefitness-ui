import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:provider/provider.dart';
import 'package:sofie_ui/components/animated/mounting.dart';
import 'package:sofie_ui/components/body_areas/body_area_selectors.dart';
import 'package:sofie_ui/components/body_areas/targeted_body_areas_lists.dart';
import 'package:sofie_ui/components/buttons.dart';
import 'package:sofie_ui/components/layout.dart';
import 'package:sofie_ui/components/navigation.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/components/user_input/filters/blocs/move_filters_bloc.dart';
import 'package:sofie_ui/components/user_input/pickers/cupertino_switch_row.dart';
import 'package:sofie_ui/components/user_input/selectors/equipment_selector.dart';
import 'package:sofie_ui/extensions/context_extensions.dart';
import 'package:sofie_ui/extensions/type_extensions.dart';
import 'package:sofie_ui/generated/api/graphql_api.dart';
import 'package:sofie_ui/services/store/graphql_store.dart';
import 'package:sofie_ui/services/store/query_observer.dart';
import 'package:sofie_ui/services/utils.dart';

/// Screen for inputting MoveFilter settings.
/// Also handles persisting the selected settings to Hive box on the device and retrieving them on initial build.
class MoveFiltersScreen extends StatefulWidget {
  const MoveFiltersScreen({Key? key}) : super(key: key);

  @override
  _MoveFiltersScreenState createState() => _MoveFiltersScreenState();
}

class _MoveFiltersScreenState extends State<MoveFiltersScreen> {
  int _activeTabIndex = 0;
  late MoveFilters _activeMoveFilters;

  @override
  void initState() {
    super.initState();
    _activeMoveFilters = context.read<MoveFiltersBloc>().filters;
  }

  Future<void> _saveAndClose() async {
    await context.read<MoveFiltersBloc>().updateFilters(_activeMoveFilters);
    context.pop();
  }

  void _changeTab(int index) {
    Utils.hideKeyboard(context);
    setState(() => _activeTabIndex = index);
  }

  void _updateMoveTypes(List<MoveType> moveTypes) =>
      setState(() => _activeMoveFilters.moveTypes = moveTypes);

  void _toggleBodyweightOnly(bool b) =>
      setState(() => _activeMoveFilters.bodyWeightOnly = b);

  void _updateEquipments(List<Equipment> equipments) =>
      setState(() => _activeMoveFilters.equipments = equipments);

  void _updateBodyAreas(List<BodyArea> bodyAreas) =>
      setState(() => _activeMoveFilters.bodyAreas = bodyAreas);

  void _clearAllFilters() {
    setState(() {
      _activeMoveFilters.moveTypes = [];
      _activeMoveFilters.bodyWeightOnly = false;
      _activeMoveFilters.equipments = [];
      _activeMoveFilters.bodyAreas = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyPageScaffold(
        navigationBar: MyNavBar(
          customLeading: NavBarCancelButton(
            _clearAllFilters,
            text: 'Clear All',
          ),
          middle: const NavBarTitle('Move Filters'),
          trailing: NavBarSaveButton(
            _saveAndClose,
          ),
        ),
        child: Column(
          children: [
            MyTabBarNav(
                titles: const ['Types', 'Equipment', 'BodyAreas'],
                handleTabChange: _changeTab,
                activeTabIndex: _activeTabIndex),
            Expanded(
              child: IndexedStack(
                index: _activeTabIndex,
                children: [
                  MoveFiltersTypes(
                    selectedMoveTypes: _activeMoveFilters.moveTypes,
                    updateSelected: _updateMoveTypes,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MoveFiltersEquipment(
                      bodyweightOnly: _activeMoveFilters.bodyWeightOnly,
                      toggleBodyweight: _toggleBodyweightOnly,
                      handleSelection: (e) => _updateEquipments(
                          _activeMoveFilters.equipments
                              .toggleItem<Equipment>(e)),
                      selectedEquipments: _activeMoveFilters.equipments,
                    ),
                  ),
                  MoveFiltersBody(
                      selectedBodyAreas: _activeMoveFilters.bodyAreas,
                      handleTapBodyArea: (ba) => _updateBodyAreas(
                          _activeMoveFilters.bodyAreas
                              .toggleItem<BodyArea>(ba))),
                ],
              ),
            ),
          ],
        ));
  }
}

class MoveFiltersTypes extends StatelessWidget {
  final List<MoveType> selectedMoveTypes;
  final void Function(List<MoveType> updated) updateSelected;

  const MoveFiltersTypes({
    Key? key,
    required this.selectedMoveTypes,
    required this.updateSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QueryObserver<MoveTypes$Query, json.JsonSerializable>(
        key: Key('MoveFiltersTypes - ${MoveTypesQuery().operationName}'),
        query: MoveTypesQuery(),
        fetchPolicy: QueryFetchPolicy.storeFirst,
        builder: (data) {
          final allMoveTypes = data.moveTypes;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
            child: ListView(children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: SelectableBox(
                    isSelected: selectedMoveTypes.isEmpty,
                    onPressed: () {
                      if (selectedMoveTypes.isEmpty) {
                        updateSelected([...allMoveTypes]);
                      } else {
                        updateSelected([]);
                      }
                    },
                    text: 'ALL'),
              ),
              ...allMoveTypes
                  .map((type) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: SelectableBox(
                          text: type.name,
                          isSelected: selectedMoveTypes.contains(type),
                          onPressed: () => updateSelected(
                              selectedMoveTypes.toggleItem<MoveType>(type)),
                        ),
                      ))
                  .toList(),
            ]),
          );
        });
  }
}

class MoveFiltersEquipment extends StatelessWidget {
  final bool bodyweightOnly;
  final void Function(bool b) toggleBodyweight;
  final List<Equipment> selectedEquipments;
  final void Function(Equipment e) handleSelection;
  const MoveFiltersEquipment(
      {Key? key,
      required this.selectedEquipments,
      required this.handleSelection,
      required this.toggleBodyweight,
      required this.bodyweightOnly})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CupertinoSwitchRow(
            title: 'Bodyweight moves only',
            updateValue: toggleBodyweight,
            value: bodyweightOnly),
        if (!bodyweightOnly)
          Expanded(
            child: FadeIn(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: QueryObserver<Equipments$Query, json.JsonSerializable>(
                    key: Key(
                        'MoveFiltersEquipment - ${EquipmentsQuery().operationName}'),
                    query: EquipmentsQuery(),
                    fetchPolicy: QueryFetchPolicy.storeFirst,
                    builder: (data) {
                      final allEquipments = data.equipments;

                      return EquipmentMultiSelectorGrid(
                          selectedEquipments: selectedEquipments,
                          equipments: allEquipments,
                          fontSize: FONTSIZE.two,
                          showIcon: true,
                          handleSelection: handleSelection);
                    }),
              ),
            ),
          ),
      ],
    );
  }
}

class MoveFiltersBody extends StatefulWidget {
  final List<BodyArea> selectedBodyAreas;
  final void Function(BodyArea bodyArea) handleTapBodyArea;
  const MoveFiltersBody({
    Key? key,
    required this.selectedBodyAreas,
    required this.handleTapBodyArea,
  }) : super(key: key);

  @override
  _MoveFiltersBodyState createState() => _MoveFiltersBodyState();
}

class _MoveFiltersBodyState extends State<MoveFiltersBody> {
  final PageController _pageController = PageController();
  final Duration _animDuration = const Duration(milliseconds: 250);
  final Curve _animCurve = Curves.fastOutSlowIn;
  final double kBodyGraphicHeight = 550;

  void _animateToPage(int page) => _pageController.animateToPage(page,
      duration: _animDuration, curve: _animCurve);

  @override
  Widget build(BuildContext context) {
    return QueryObserver<BodyAreas$Query, json.JsonSerializable>(
        key: Key('MoveFiltersBody - ${BodyAreasQuery().operationName}'),
        query: BodyAreasQuery(),
        fetchPolicy: QueryFetchPolicy.storeFirst,
        builder: (data) {
          final allBodyAreas = data.bodyAreas;

          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TargetedBodyAreasList(
                    selectedBodyAreas: widget.selectedBodyAreas,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: kBodyGraphicHeight,
                    child: PageView(
                      controller: _pageController,
                      children: [
                        Stack(alignment: Alignment.topCenter, children: [
                          const Positioned(child: H3('Front')),
                          Positioned(
                              right: 0,
                              child: CupertinoButton(
                                  child: const MyText('Back >'),
                                  onPressed: () => _animateToPage(1))),
                          Padding(
                            padding: const EdgeInsets.all(40.0),
                            child: BodyAreaSelectorIndicator(
                                selectedBodyAreas: widget.selectedBodyAreas,
                                frontBack: BodyAreaFrontBack.front,
                                allBodyAreas: allBodyAreas,
                                handleTapBodyArea: widget.handleTapBodyArea,
                                height: kBodyGraphicHeight),
                          ),
                        ]),
                        Stack(alignment: Alignment.topCenter, children: [
                          const Positioned(child: H3('Back')),
                          Positioned(
                              left: 0,
                              child: CupertinoButton(
                                  child: const MyText('< Front'),
                                  onPressed: () => _animateToPage(0))),
                          Padding(
                            padding: const EdgeInsets.all(40.0),
                            child: BodyAreaSelectorIndicator(
                                selectedBodyAreas: widget.selectedBodyAreas,
                                frontBack: BodyAreaFrontBack.back,
                                allBodyAreas: allBodyAreas,
                                handleTapBodyArea: widget.handleTapBodyArea,
                                height: kBodyGraphicHeight),
                          ),
                        ]),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
