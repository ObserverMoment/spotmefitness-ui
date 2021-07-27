import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';

class BenchmarkTypeSelector extends StatelessWidget {
  final BenchmarkType? benchmarkType;
  final void Function(BenchmarkType updated) updateBenchmarkType;
  BenchmarkTypeSelector(
      {this.benchmarkType, required this.updateBenchmarkType});

  void _handleSelectMoveType(
      BuildContext context, BenchmarkType benchmarkType) {
    updateBenchmarkType(benchmarkType);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: BorderlessNavBar(
          customLeading: CupertinoButton(
              padding: EdgeInsets.zero,
              child: MyText(
                'Done',
                weight: FontWeight.bold,
              ),
              onPressed: context.pop),
          middle: NavBarTitle('Scoring Types'),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: BenchmarkType.values
                .where((v) => v != BenchmarkType.artemisUnknown)
                .map((type) => GestureDetector(
                      onTap: () => _handleSelectMoveType(context, type),
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                            border:
                                Border(bottom: BorderSide(color: Styles.grey))),
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 16),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    MyText(
                                      type.display,
                                      size: FONTSIZE.BIG,
                                      weight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                                InfoPopupButton(
                                    infoWidget:
                                        MyText('Info about ${type.display}'))
                              ],
                            ),
                            MyText(
                              type.description,
                              maxLines: 3,
                              size: FONTSIZE.SMALL,
                              lineHeight: 1.4,
                            )
                          ],
                        ),
                      ),
                    ))
                .toList(),
          ),
        ));
  }
}
