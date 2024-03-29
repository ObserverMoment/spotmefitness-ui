// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:auto_route/auto_route.dart';
// import 'package:sofie_ui/components/animated/loading_shimmers.dart';
// import 'package:sofie_ui/components/buttons.dart';
// import 'package:sofie_ui/components/cards/card.dart';
// import 'package:sofie_ui/components/cards/progress_journal_entry_card.dart';
// import 'package:sofie_ui/components/text.dart';
// import 'package:sofie_ui/generated/api/graphql_api.dart';
// import 'package:sofie_ui/router.gr.dart';
// import 'package:sofie_ui/services/store/query_observer.dart';
// import 'package:json_annotation/json_annotation.dart' as json;
// import 'package:collection/collection.dart';

// class RecentJournalEntries extends StatelessWidget {
//   final kJournalEntryCardHeight = 200.0;

//   @override
//   Widget build(BuildContext context) {
//     return QueryObserver<UserProgressJournals$Query, json.JsonSerializable>(
//         key: Key(
//             'RecentJournalEntries - ${UserProgressJournalsQuery().operationName}'),
//         query: UserProgressJournalsQuery(),
//         fullScreenError: false,
//         loadingIndicator: Row(
//           children: [
//             Expanded(
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
//                 child: ShimmerCard(
//                   height: kJournalEntryCardHeight - 30,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         builder: (data) {
//           /// TODO: At the moment this gets everything from the API then extracts the entries, sorts them and takes the first 10.
//           /// It may be better to have a custom resolver for getting these most recent 10 entries + their parent journal id to allow for the user to click through to the ProgressJournalDetailsPage.
//           final entries = data.userProgressJournals
//               .fold<List<ProgressJournalEntry>>(
//                   [],
//                   (entries, next) =>
//                       [...entries, ...next.progressJournalEntries])
//               .sortedBy<DateTime>((entry) => entry.createdAt)
//               .reversed
//               .take(10)
//               .toList();

//           return entries.isNotEmpty
//               ? Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           H2('Journals'),
//                           TextButton(
//                             onPressed: () =>
//                                 context.pushRoute(YourProgressJournalsRoute()),
//                             underline: false,
//                             text: 'All',
//                             suffix: Icon(CupertinoIcons.arrow_right_square),
//                           )
//                         ],
//                       ),
//                     ),
//                     CarouselSlider.builder(
//                       options: CarouselOptions(
//                         height: kJournalEntryCardHeight,
//                         viewportFraction: 0.9,
//                         enableInfiniteScroll: false,
//                       ),
//                       itemCount: entries.length + 1,
//                       itemBuilder: (c, i, _) {
//                         if (i == entries.length) {
//                           return TextButton(
//                             onPressed: () =>
//                                 context.pushRoute(YourProgressJournalsRoute()),
//                             underline: false,
//                             text: 'View all',
//                             suffix: Icon(CupertinoIcons.arrow_right_square),
//                             fontSize: FONTSIZE.four,
//                           );
//                         } else {
//                           return Padding(
//                             padding: const EdgeInsets.all(6.0),
//                             child: GestureDetector(
//                                 onTap: () => context.navigateTo(
//                                     ProgressJournalDetailsRoute(
//                                         id: data.userProgressJournals
//                                             .firstWhere((j) => j
//                                                 .progressJournalEntries
//                                                 .contains(entries[i]))
//                                             .id)),
//                                 child: ProgressJournalEntryCard(entries[i])),
//                           );
//                         }
//                       },
//                     )
//                   ],
//                 )
//               : Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Card(
//                       height: 100,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           MyText(
//                             'No recent journal entries',
//                             subtext: true,
//                           ),
//                           CreateTextIconButton(
//                               text: 'Add Journal',
//                               onPressed: () => context
//                                   .pushRoute(YourProgressJournalsRoute()))
//                         ],
//                       )),
//                 );
//         });
//   }
// }
