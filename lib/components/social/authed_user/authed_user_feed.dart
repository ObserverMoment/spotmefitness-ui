import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:stream_feed/stream_feed.dart';
import 'package:stream_feed/src/client/flat_feed.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// Feed for the currently logged in User.
/// GetStream fees slug is [user_feed].
/// User posts go into this feed - other [user_timelines] can follow it.
class AuthedUserFeed extends StatefulWidget {
  const AuthedUserFeed({Key? key}) : super(key: key);

  @override
  _AuthedUserFeedState createState() => _AuthedUserFeedState();
}

class _AuthedUserFeedState extends State<AuthedUserFeed> {
  late AuthedUser _authedUser;
  late StreamFeedClient _streamFeedClient;
  late FlatFeed _feed;
  bool _isLoading = true;
  List<Activity> _activities = <Activity>[];

  @override
  void initState() {
    _authedUser = GetIt.I<AuthBloc>().authedUser!;
    _streamFeedClient = context.streamFeedClient;
    _feed = _streamFeedClient.flatFeed('user_feed', _authedUser.id);

    _load_Activities();

    super.initState();
  }

  Future<void> _load_Activities() async {
    final data = await _feed.getActivities();
    setState(() {
      _isLoading = false;
      _activities = data;
    });
  }

  // void _addTest() async {
  //   print('------------------------------');
  //   print('------------------------------');
  //   print('------------------------------');
  //   print('------------------------------');
  //   print('_streamFeedClient.currentUser');
  //   print(_streamFeedClient.currentUser!.profile());
  //   await _feed.addActivity(Activity(
  //       //
  //       actor: _streamFeedClient.currentUser!.ref,
  //       verb: 'post',
  //       object: 'Article:${DateTime.now().millisecondsSinceEpoch}'));
  //   await _load_Activities();
  // }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? LoadingCircle()
        : _activities.isEmpty
            ? Padding(
                padding: const EdgeInsets.all(32.0),
                child: Center(
                  child: MyText(
                    'No posts yet..',
                    size: FONTSIZE.BIG,
                    subtext: true,
                  ),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: _activities.length,
                itemBuilder: (c, i) =>
                    _UserFeedEntry(activity: _activities[i]));
  }
}

/// Displays the post and also UI for user to CRUD.
class _UserFeedEntry extends StatelessWidget {
  final Activity activity;
  const _UserFeedEntry({Key? key, required this.activity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MyText(activity.actor.toString()),
    );
  }
}
