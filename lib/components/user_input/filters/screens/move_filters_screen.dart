import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/navigation.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/filters/models/move_filters.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/equipment_selector.dart';
import 'package:spotmefitness_ui/components/wrappers.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// Screen for inputting MoveFilter settings.
/// Also handles persisting the selected settings to Hive box on the device and retrieving them on initial build.
class MoveFiltersScreen extends StatefulWidget {
  @override
  _MoveFiltersScreenState createState() => _MoveFiltersScreenState();
}

class _MoveFiltersScreenState extends State<MoveFiltersScreen> {
  int _activeTabIndex = 0;
  late MoveFilters _moveFilters;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    // TODO: Open Hive settings box and extract any saved
    _moveFilters = MoveFilters.retrieveFiltersFromdevice();
  }

  void _saveAndClose() {
    /// Persist new filter settings to the Hive box.
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
      setState(() => _moveFilters.moveTypes = moveTypes);

  void _updateEquipments(List<Equipment> equipments) =>
      setState(() => _moveFilters.equipments = equipments);

  void _updateBodyAreas(List<BodyArea> bodyAreas) =>
      setState(() => _moveFilters.bodyAreas = bodyAreas);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: BasicNavBar(
            automaticallyImplyLeading: false,
            leading: null,
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
                        selectedMoveTypes: _moveFilters.moveTypes,
                        updateSelected: _updateMoveTypes,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: QueryResponseBuilder(
                          options: QueryOptions(
                              fetchPolicy: FetchPolicy.cacheFirst,
                              document: EquipmentsQuery().document),
                          builder: (result, {fetchMore, refetch}) {
                            final allEquipments =
                                Equipments$Query.fromJson(result.data ?? {})
                                    .equipments;

                            return EquipmentMultiSelector(
                                selectedEquipments: _moveFilters.equipments,
                                scrollDirection: Axis.vertical,
                                equipments: allEquipments,
                                handleSelection: (e) => _updateEquipments(
                                    _moveFilters.equipments
                                        .toggleItem<Equipment>(e)));
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MyText('Body Areas'),
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
  MoveFiltersTypes(
      {required this.selectedMoveTypes, required this.updateSelected});

  @override
  Widget build(BuildContext context) {
    return QueryResponseBuilder(
        options: QueryOptions(
            fetchPolicy: FetchPolicy.cacheFirst,
            document: MoveTypesQuery().document),
        builder: (result, {refetch, fetchMore}) {
          final allMoveTypes =
              MoveTypes$Query.fromJson(result.data ?? {}).moveTypes;

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
