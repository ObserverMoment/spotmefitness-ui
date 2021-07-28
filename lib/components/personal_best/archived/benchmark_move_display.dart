// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
// import 'package:spotmefitness_ui/components/buttons.dart';
// import 'package:spotmefitness_ui/components/text.dart';
// import 'package:spotmefitness_ui/generated/api/graphql_api.graphql.dart';
// import 'package:spotmefitness_ui/extensions/type_extensions.dart';
// import 'package:spotmefitness_ui/extensions/enum_extensions.dart';
// import 'package:spotmefitness_ui/services/utils.dart';

// class BenchmarkMoveDisplay extends StatelessWidget {
//   final UserBenchmark userBenchmark;
//   BenchmarkMoveDisplay(this.userBenchmark);

//   Widget _buildRepDisplay() {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         MyText(
//           userBenchmark.reps!.stringMyDouble(),
//           lineHeight: 1.2,
//           size: FONTSIZE.BIG,
//         ),
//         SizedBox(
//           width: 6,
//         ),
//         MyText(
//           [WorkoutMoveRepType.distance, WorkoutMoveRepType.time]
//                   .contains(userBenchmark.repType)
//               ? userBenchmark.distanceUnit.shortDisplay
//               : userBenchmark.reps != 1
//                   ? describeEnum(userBenchmark.repType)
//                   : userBenchmark.repType.displaySingular,
//         ),
//       ],
//     );
//   }

//   Widget _buildLoadDisplay() {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         MyText(
//           userBenchmark.load!.stringMyDouble(),
//           lineHeight: 1.2,
//           size: FONTSIZE.BIG,
//         ),
//         MyText(
//           userBenchmark.loadUnit.display,
//         ),
//       ],
//     );
//   }

//   List<Widget> _buildItems() {
//     return [
//       MyText(userBenchmark.move.name),
//       if (userBenchmark.equipment != null)
//         MyText(
//           userBenchmark.equipment!.name,
//           color: Styles.colorTwo,
//         ),
//       if (Utils.hasReps(userBenchmark.reps)) _buildRepDisplay(),
//       if (Utils.hasLoad(userBenchmark.load)) _buildLoadDisplay(),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     final items = _buildItems();
//     return Container(
//       height: 30,
//       child: ListView.separated(
//           scrollDirection: Axis.horizontal,
//           physics: NeverScrollableScrollPhysics(),
//           shrinkWrap: true,
//           itemBuilder: (c, i) => Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 child: Align(alignment: Alignment.center, child: items[i]),
//               ),
//           separatorBuilder: (c, i) => ButtonSeparator(),
//           itemCount: items.length),
//     );
//   }
// }
