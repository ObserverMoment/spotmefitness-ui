import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/pages/authed/journal/recent_benchmark_entries.dart';
import 'package:spotmefitness_ui/pages/authed/journal/recent_journal_entries.dart';
import 'package:spotmefitness_ui/pages/authed/journal/recent_logged_workouts.dart';

/// The main tab page 'Journal'.
/// Includes [Journals], [Benchmarks] and [Logs].
class JournalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      key: Key('JournalPage-CupertinoPageScaffold'),
      navigationBar: BasicNavBar(
        key: Key('JournalPage-BasicNavBar'),
        customLeading: NavBarLargeTitle('Journal'),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: ListView(
          shrinkWrap: true,
          children: [
            RecentBenchmarkEntries(),
            RecentLoggedWorkouts(),
            RecentJournalEntries(),
          ],
        ),
      ),
    );
  }
}
