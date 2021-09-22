import 'package:flutter/cupertino.dart';
import 'package:sofie_ui/blocs/theme_bloc.dart';
import 'package:sofie_ui/components/buttons.dart';
import 'package:sofie_ui/components/layout.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/extensions/context_extensions.dart';
import 'package:sofie_ui/extensions/enum_extensions.dart';
import 'package:sofie_ui/generated/api/graphql_api.dart';

class BenchmarkTypeSelector extends StatelessWidget {
  final BenchmarkType? benchmarkType;
  final void Function(BenchmarkType updated) updateBenchmarkType;
  const BenchmarkTypeSelector(
      {Key? key, this.benchmarkType, required this.updateBenchmarkType})
      : super(key: key);

  void _handleSelectMoveType(
      BuildContext context, BenchmarkType benchmarkType) {
    updateBenchmarkType(benchmarkType);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: MyNavBar(
          customLeading: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: context.pop,
              child: const MyText(
                'Done',
                weight: FontWeight.bold,
              )),
          middle: const NavBarTitle('Scoring Types'),
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
                                      size: FONTSIZE.four,
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
                              size: FONTSIZE.two,
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
