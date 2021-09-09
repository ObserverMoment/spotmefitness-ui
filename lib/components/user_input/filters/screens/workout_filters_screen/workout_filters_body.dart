import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/components/body_areas/body_area_selectors.dart';
import 'package:spotmefitness_ui/components/body_areas/targeted_body_areas_lists.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/filters/blocs/workout_filters_bloc.dart';
import 'package:spotmefitness_ui/components/user_input/pickers/sliding_select.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;

class WorkoutFiltersBody extends StatefulWidget {
  @override
  _WorkoutFiltersBodyState createState() => _WorkoutFiltersBodyState();
}

class _WorkoutFiltersBodyState extends State<WorkoutFiltersBody> {
  final kBodyGraphicHeight = 420.0;
  late int _activePageIndex;

  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _activePageIndex = 0;
  }

  void _animateToPage(int page) {
    setState(() => _activePageIndex = page);
    _pageController.toPage(page);
  }

  @override
  Widget build(BuildContext context) {
    final targetedBodyAreas =
        context.select<WorkoutFiltersBloc, List<BodyArea>>(
            (b) => b.filters.targetedBodyAreas);

    return QueryObserver<BodyAreas$Query, json.JsonSerializable>(
        key: Key('MoveFiltersBody - ${BodyAreasQuery().operationName}'),
        query: BodyAreasQuery(),
        fetchPolicy: QueryFetchPolicy.storeFirst,
        builder: (data) {
          final allBodyAreas = data.bodyAreas;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: SlidingSelect<int>(
                    updateValue: _animateToPage,
                    value: _activePageIndex,
                    children: {
                      0: MyText('Front'),
                      1: MyText('Back'),
                    },
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        height: kBodyGraphicHeight,
                        child: PageView(
                          physics: NeverScrollableScrollPhysics(),
                          controller: _pageController,
                          children: [
                            BodyAreaSelectorIndicator(
                                selectedBodyAreas: targetedBodyAreas,
                                frontBack: BodyAreaFrontBack.front,
                                allBodyAreas: allBodyAreas,
                                handleTapBodyArea: (b) => context
                                        .read<WorkoutFiltersBloc>()
                                        .updateFilters({
                                      'targetedBodyAreas': targetedBodyAreas
                                          .toggleItem(b)
                                          .map((b) => b.toJson())
                                          .toList()
                                    }),
                                height: kBodyGraphicHeight),
                            BodyAreaSelectorIndicator(
                                selectedBodyAreas: targetedBodyAreas,
                                frontBack: BodyAreaFrontBack.back,
                                allBodyAreas: allBodyAreas,
                                handleTapBodyArea: (b) => context
                                        .read<WorkoutFiltersBloc>()
                                        .updateFilters({
                                      'targetedBodyAreas': targetedBodyAreas
                                          .toggleItem(b)
                                          .map((b) => b.toJson())
                                          .toList()
                                    }),
                                height: kBodyGraphicHeight),
                          ],
                        ),
                      ),
                    ),
                    if (targetedBodyAreas.isNotEmpty)
                      Positioned(
                        top: 4,
                        right: 8,
                        child: TextButton(
                          text: 'Clear all',
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          destructive: true,
                          underline: false,
                          onPressed: () => context
                              .read<WorkoutFiltersBloc>()
                              .updateFilters({'targetedBodyAreas': []}),
                        ),
                      )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BodyAreaNamesList(targetedBodyAreas),
              ),
            ],
          );
        });
  }
}
