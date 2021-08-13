import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:stream_feed/stream_feed.dart';
import 'package:stream_feed/src/client/flat_feed.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// Timeline for the currently logged in User.
/// GetStream fees slug is [user_timeline].
/// A [user_timeline] follows many [user_feeds].
class AuthedUserTimeline extends StatefulWidget {
  const AuthedUserTimeline({Key? key}) : super(key: key);

  @override
  _AuthedUserTimelineState createState() => _AuthedUserTimelineState();
}

class _AuthedUserTimelineState extends State<AuthedUserTimeline> {
  late AuthedUser _authedUser;
  late StreamFeedClient _streamFeedClient;
  late FlatFeed _timeline;
  bool _isLoading = true;
  List<Activity> _activities = <Activity>[];

  @override
  void initState() {
    _authedUser = GetIt.I<AuthBloc>().authedUser!;
    _streamFeedClient = context.streamFeedClient;
    _timeline = _streamFeedClient.flatFeed('user_timeline', _authedUser.id);

    _load_Activities();

    super.initState();
  }

  Future<void> _load_Activities() async {
    final data = await _timeline.getActivities();
    setState(() {
      _isLoading = false;
      _activities = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? LoadingCircle()
        : _activities.isEmpty
            ? Padding(
                padding: const EdgeInsets.all(32.0),
                child: Center(
                  child: MyText(
                    'No news yet..',
                    size: FONTSIZE.BIG,
                    subtext: true,
                  ),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: _activities.length,
                itemBuilder: (c, i) => _TimelinePost(activity: _activities[i]));
  }
}

class _TimelinePost extends StatelessWidget {
  final Activity activity;
  const _TimelinePost({Key? key, required this.activity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MyText(activity.actor.toString()),
    );
  }
}
