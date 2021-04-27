import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:spotmefitness_ui/components/body_areas/body_area_score_adjuster.dart';
import 'package:spotmefitness_ui/components/body_areas/body_area_selectors.dart';
import 'package:spotmefitness_ui/components/body_areas/targeted_body_areas_lists.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/wrappers.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class CustomMoveCreatorBody extends StatefulWidget {
  final Move move;
  final void Function(Map<String, dynamic> data) updateMove;
  CustomMoveCreatorBody({required this.move, required this.updateMove});

  @override
  _CustomMoveCreatorBodyState createState() => _CustomMoveCreatorBodyState();
}

class _CustomMoveCreatorBodyState extends State<CustomMoveCreatorBody> {
  PageController _pageController = PageController();
  Duration _animDuration = Duration(milliseconds: 250);
  Curve _animCurve = Curves.fastOutSlowIn;

  void _animateToPage(int page) => _pageController.animateToPage(page,
      duration: _animDuration, curve: _animCurve);

  Future<void> _handleTapBodyArea(BodyArea bodyArea) async {
    await context.showBottomSheet(
        child: BodyAreaScoreAdjuster(
      bodyArea: bodyArea,
      bodyAreaMoveScores: widget.move.bodyAreaMoveScores,
      updateBodyAreaMoveScores: (updatedScores) {
        widget.updateMove({
          'BodyAreaMoveScores': updatedScores.map((s) => s.toJson()).toList()
        });
        context.pop();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return QueryResponseBuilder(
        options: QueryOptions(
            fetchPolicy: FetchPolicy.cacheFirst,
            document: BodyAreasQuery().document),
        builder: (result, {fetchMore, refetch}) {
          final allBodyAreas =
              BodyAreas$Query.fromJson(result.data ?? {}).bodyAreas;

          return Column(
            children: [
              if (widget.move.bodyAreaMoveScores.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      MyText(
                        'Targeted areas not yet specified',
                        subtext: true,
                      ),
                      MyText(
                        '(Click body area to add / edit scores)',
                        subtext: true,
                        size: FONTSIZE.SMALL,
                      ),
                    ],
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 4.0),
                  child: TargetedBodyAreasScoreList(
                    widget.move.bodyAreaMoveScores,
                    showNumericalScore: true,
                  ),
                ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(12.0),
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
                      BodyAreaSelectorAndMoveScoreIndicator(
                        bodyAreaMoveScores: widget.move.bodyAreaMoveScores,
                        frontBack: BodyAreaFrontBack.front,
                        allBodyAreas: allBodyAreas,
                        indicatePercentWithColor: true,
                        handleTapBodyArea: _handleTapBodyArea,
                      ),
                    ]),
                    Stack(alignment: Alignment.topCenter, children: [
                      Positioned(child: H3('Back')),
                      Positioned(
                          left: 0,
                          child: CupertinoButton(
                              child: MyText('< Front'),
                              onPressed: () => _animateToPage(0))),
                      BodyAreaSelectorAndMoveScoreIndicator(
                        bodyAreaMoveScores: widget.move.bodyAreaMoveScores,
                        frontBack: BodyAreaFrontBack.back,
                        allBodyAreas: allBodyAreas,
                        indicatePercentWithColor: true,
                        handleTapBodyArea: _handleTapBodyArea,
                      ),
                    ]),
                  ],
                ),
              ))
            ],
          );
        });
  }
}
