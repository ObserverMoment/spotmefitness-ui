import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:stream_feed/stream_feed.dart';

/// Create / Edit a post and sends it to GetStream.
/// Currently: Like an internal content share function. Can only share certain objects from within the app such as [Workout], [WorkoutPlan] etc.
class PostCreatorPage extends StatefulWidget {
  final Activity? activity;
  const PostCreatorPage({Key? key, this.activity}) : super(key: key);

  @override
  _PostCreatorPageState createState() => _PostCreatorPageState();
}

class _PostCreatorPageState extends State<PostCreatorPage> {
  @override
  Widget build(BuildContext context) {
    return MyPageScaffold(
      navigationBar: BorderlessNavBar(),
      child: Column(
        children: [
          PrimaryButton(text: 'Session Log', onPressed: () => print('session')),
          PrimaryButton(
              text: 'User Profile', onPressed: () => print('user profile')),
          PrimaryButton(text: 'Workout', onPressed: () => print('workout')),
          PrimaryButton(
              text: 'Workout Plan', onPressed: () => print('workout plan')),
          PrimaryButton(text: 'Challenge', onPressed: () => print('challenge')),
        ],
      ),
    );
  }
}
