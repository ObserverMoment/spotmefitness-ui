import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/body_areas/body_area_selectors.dart';
import 'package:spotmefitness_ui/components/body_areas/targeted_body_areas_lists.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/navigation.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/cupertino_switch_row.dart';
import 'package:spotmefitness_ui/components/user_input/filters/blocs/move_filters_bloc.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/equipment_selector.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:provider/provider.dart';
import 'package:json_annotation/json_annotation.dart' as json;

/// Screen for inputting MoveFilter settings.
/// Also handles persisting the selected settings to Hive box on the device and retrieving them on initial build.
class MoveFiltersScreen extends StatefulWidget {
  @override
  _MoveFiltersScreenState createState() => _MoveFiltersScreenState();
}

class _MoveFiltersScreenState extends State<MoveFiltersScreen> {
  int _activeTabIndex = 0;
  late MoveFilters _activeMoveFilters;
  final PageController _pageController = PageController();

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
    _pageController.jumpToPage(
      index,
    );
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

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: BasicNavBar(
            heroTag: 'MoveFiltersScreen',
            automaticallyImplyLeading: false,
            customLeading: null,
            middle: NavBarTitle('Move Filters'),
            trailing: NavBarSaveButton(
              _saveAndClose,
            )),
        child: Column(
          children: [
            SizedBox(height: 12),
            MyTabBarNav(
                titles: ['Types', 'Equipment', 'BodyAreas'],
                handleTabChange: _changeTab,
                activeTabIndex: _activeTabIndex),
            Expanded(
              child: FadeIn(
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: _changeTab,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MoveFiltersTypes(
                        selectedMoveTypes: _activeMoveFilters.moveTypes,
                        updateSelected: _updateMoveTypes,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: MoveFiltersEquipment(
                        bodyweightOnly: _activeMoveFilters.bodyWeightOnly,
                        toggleBodyweight: _toggleBodyweightOnly,
                        handleSelection: (e) => _updateEquipments(
                            _activeMoveFilters.equipments
                                .toggleItem<Equipment>(e)),
                        selectedEquipments: _activeMoveFilters.equipments,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MoveFiltersBody(
                          selectedBodyAreas: _activeMoveFilters.bodyAreas,
                          clearAllBodyAreas: () => _updateBodyAreas([]),
                          handleTapBodyArea: (ba) => _updateBodyAreas(
                              _activeMoveFilters.bodyAreas
                                  .toggleItem<BodyArea>(ba))),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

class MoveFiltersTypes extends StatelessWidget {
  final List<MoveType> selectedMoveTypes;
  final void Function(List<MoveType> updated) updateSelected;

  MoveFiltersTypes({
    required this.selectedMoveTypes,
    required this.updateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return QueryObserver<MoveTypes$Query, json.JsonSerializable>(
        key: Key('MoveFiltersTypes - ${MoveTypesQuery().operationName}'),
        query: MoveTypesQuery(),
        fetchPolicy: QueryFetchPolicy.storeFirst,
        builder: (data) {
          final allMoveTypes = data.moveTypes;

          return Container(
            padding: const EdgeInsets.only(top: 4, left: 8),
            height: 56,
            child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 10,
                runSpacing: 6,
                children: [
                  SelectableTag(
                      isSelected: selectedMoveTypes.isEmpty,
                      onPressed: () {
                        if (selectedMoveTypes.isEmpty) {
                          updateSelected([...allMoveTypes]);
                        } else {
                          updateSelected([]);
                        }
                      },
                      text: 'ALL'),
                  ...allMoveTypes
                      .map((type) => SelectableTag(
                            text: type.name,
                            isSelected: selectedMoveTypes.contains(type),
                            onPressed: () => updateSelected(
                                selectedMoveTypes.toggleItem<MoveType>(type)),
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
  MoveFiltersEquipment(
      {required this.selectedEquipments,
      required this.handleSelection,
      required this.toggleBodyweight,
      required this.bodyweightOnly});

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

                      return EquipmentMultiSelector(
                          selectedEquipments: selectedEquipments,
                          scrollDirection: Axis.vertical,
                          equipments: allEquipments,
                          crossAxisCount: 4,
                          fontSize: FONTSIZE.SMALL,
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
  final void Function() clearAllBodyAreas;
  MoveFiltersBody(
      {required this.selectedBodyAreas,
      required this.handleTapBodyArea,
      required this.clearAllBodyAreas});

  @override
  _MoveFiltersBodyState createState() => _MoveFiltersBodyState();
}

class _MoveFiltersBodyState extends State<MoveFiltersBody> {
  PageController _pageController = PageController();
  Duration _animDuration = Duration(milliseconds: 250);
  Curve _animCurve = Curves.fastOutSlowIn;
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
                if (widget.selectedBodyAreas.isNotEmpty)
                  FadeIn(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          text: 'Clear all',
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          destructive: true,
                          underline: false,
                          onPressed: widget.clearAllBodyAreas,
                        ),
                      ],
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TargetedBodyAreasList(widget.selectedBodyAreas),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: kBodyGraphicHeight,
                    child: PageView(
                      controller: _pageController,
                      children: [
                        Stack(alignment: Alignment.topCenter, children: [
                          Positioned(child: H3('Front')),
                          Positioned(
                              right: 0,
                              child: CupertinoButton(
                                  child: MyText('Back >'),
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
                          Positioned(child: H3('Back')),
                          Positioned(
                              left: 0,
                              child: CupertinoButton(
                                  child: MyText('< Front'),
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
