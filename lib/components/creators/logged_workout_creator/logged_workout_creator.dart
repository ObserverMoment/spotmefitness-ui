import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/blocs/logged_workout_creator_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/creators/logged_workout_creator/logged_workout_creator_with_sections.dart';
import 'package:spotmefitness_ui/components/creators/logged_workout_creator/required_user_inputs.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class LoggedWorkoutCreatorPage extends StatefulWidget {
  final Workout workout;
  final ScheduledWorkout? scheduledWorkout;
  LoggedWorkoutCreatorPage({required this.workout, this.scheduledWorkout});

  @override
  _LoggedWorkoutCreatorPageState createState() =>
      _LoggedWorkoutCreatorPageState();
}

class _LoggedWorkoutCreatorPageState extends State<LoggedWorkoutCreatorPage> {
  Future<void> _saveLogToDB(LoggedWorkoutCreatorBloc bloc) async {
    context.showLoadingAlert('Logging...',
        icon: Icon(
          CupertinoIcons.doc_plaintext,
          color: Styles.infoBlue,
        ));

    final result = await bloc.createAndSave(context);

    context.pop(); // Close loading alert.

    if (result.hasErrors) {
      context
          .showErrorAlert('Sorry, there was a problem logging this workout!');
    } else {
      await context.showSuccessAlert(
        'Workout Logged!',
        'You can go to Progress -> Logs to view it.',
      );
      context.pop(result: true); // Close the logged workout creator.
    }
  }

  void _handleCancel() {
    context.showConfirmDialog(
        title: 'Leave without Saving?',
        onConfirm: () => context.pop(result: false));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoggedWorkoutCreatorBloc(
          context: context,
          workout: widget.workout,
          scheduledWorkout: widget.scheduledWorkout),
      builder: (context, child) {
        final requireUserInputs =
            context.select<LoggedWorkoutCreatorBloc, bool>(
                (b) => b.loggedWorkout.loggedWorkoutSections.isEmpty);

        return MyPageScaffold(
            navigationBar: MyNavBar(
              customLeading: NavBarCancelButton(_handleCancel),
              middle: NavBarTitle('Log Workout'),
              trailing: !requireUserInputs
                  ? NavBarSaveButton(
                      () => _saveLogToDB(
                          context.read<LoggedWorkoutCreatorBloc>()),
                      text: 'Log It',
                    )
                  : null,
            ),
            child: Column(
              children: [
                UserInputContainer(
                  child: MyHeaderText(
                    widget.workout.name,
                    size: FONTSIZE.BIG,
                  ),
                ),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: kStandardAnimationDuration,
                    child: requireUserInputs
                        ? RequiredUserInputs()
                        : LoggedWorkoutCreatorWithSections(),
                  ),
                ),
              ],
            ));
      },
    );
  }
}
