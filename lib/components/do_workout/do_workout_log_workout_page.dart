import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/logged_wokout_section_summary_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:spotmefitness_ui/services/graphql_operation_names.dart';
import 'package:supercharged/supercharged.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

class DoWorkoutLogWorkoutPage extends StatefulWidget {
  const DoWorkoutLogWorkoutPage({Key? key}) : super(key: key);

  @override
  _DoWorkoutLogWorkoutPageState createState() =>
      _DoWorkoutLogWorkoutPageState();
}

class _DoWorkoutLogWorkoutPageState extends State<DoWorkoutLogWorkoutPage> {
  final kNavbarIconSize = 34.0;
  bool _logSavedToDB = false;
  bool _savingToDB = false;

  Future<void> _createLoggedWorkout(LoggedWorkout loggedWorkout) async {
    setState(() => _savingToDB = true);
    final variables = CreateLoggedWorkoutArguments(
        data: CreateLoggedWorkoutInput.fromJson(loggedWorkout.toJson()));

    final result = await context.graphQLStore.create(
        mutation: CreateLoggedWorkoutMutation(variables: variables),
        addRefToQueries: [GQLNullVarsKeys.userLoggedWorkoutsQuery]);

    setState(() => _savingToDB = false);

    if (result.hasErrors || result.data == null) {
      context.showToast(
          message: 'There was a problem, the log was not saved...',
          toastType: ToastType.destructive);
    } else {
      setState(() => _logSavedToDB = true);
    }
  }

  void _handleExitRequest() {
    if (_logSavedToDB) {
      context.popRoute();
    } else {
      context.showDialog(
          title: 'Leave without logging?',
          barrierDismissible: true,
          actions: [
            CupertinoDialogAction(
                child: MyText('Confirm'),
                onPressed: () {
                  context.pop();
                  context.popRoute();
                }),
            CupertinoDialogAction(
              child: MyText('Cancel'),
              onPressed: context.pop,
            ),
          ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loggedWorkout =
        context.select<DoWorkoutBloc, LoggedWorkout>((b) => b.loggedWorkout);

    final sortedSections = loggedWorkout.loggedWorkoutSections
        .sortedBy<num>((ls) => ls.sortPosition);

    /// When doing a workout 'live' the timeTakenMs should always be non null as it gets added by the [DoWorkoutBloc] in section complete.
    /// Being null here is an error.
    final totalTimeMs =
        loggedWorkout.loggedWorkoutSections.sumBy((s) => s.timeTakenMs!);

    return CupertinoPageScaffold(
        child: SafeArea(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              H2("All done, great work!"),
              TextButton(
                padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                underline: false,
                text: 'Done',
                onPressed: _handleExitRequest,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              H3('Time spent working:'),
              SizedBox(width: 8),
              H3(
                (totalTimeMs ~/ 1000).secondsToTimeDisplay(),
                color: Styles.colorTwo,
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AnimatedSwitcher(
              duration: kStandardAnimationDuration,
              child: _logSavedToDB
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        H3('Log Saved'),
                        SizedBox(width: 6),
                        Icon(
                          CupertinoIcons.checkmark_alt,
                          color: Styles.peachRed,
                        )
                      ],
                    )
                  : PrimaryButton(
                      prefix: Icon(
                        CupertinoIcons.doc_chart,
                        color: context.theme.background,
                      ),
                      withMinWidth: false,
                      loading: _savingToDB,
                      text: 'Save Log',
                      onPressed: () => _createLoggedWorkout(loggedWorkout)),
            ),
            PrimaryButton(
                prefix: Icon(
                  CupertinoIcons.share,
                  color: context.theme.background,
                ),
                withMinWidth: false,
                loading: _savingToDB,
                text: 'Share Summary',
                onPressed: () => print('share')),
          ],
        ),
        SizedBox(height: 12),
        Expanded(
          child: ListView(
              shrinkWrap: true,
              children: sortedSections
                  .mapIndexed(
                      (i, _) => _LoggedWorkoutSectionWrapper(sectionIndex: i))
                  .toList()),
        ),
      ]),
    ));
  }
}

/// Hooks into the bloc to pull out the correct logged workout section based on the section index and provides it to the pure UI widget [LoggedWorkoutSectionSummarycard].
class _LoggedWorkoutSectionWrapper extends StatelessWidget {
  final int sectionIndex;
  const _LoggedWorkoutSectionWrapper({Key? key, required this.sectionIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loggedWorkoutSection =
        context.select<DoWorkoutBloc, LoggedWorkoutSection>((b) => b
            .loggedWorkout.loggedWorkoutSections
            .firstWhere((lws) => lws.sortPosition == sectionIndex));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10),
      child: ContentBox(
        child: LoggedWorkoutSectionSummaryCard(
            loggedWorkoutSection: loggedWorkoutSection,
            addNoteToLoggedSection: (note) => context
                .read<DoWorkoutBloc>()
                .addNoteToLoggedWorkoutSection(sectionIndex, note)),
      ),
    );
  }
}
