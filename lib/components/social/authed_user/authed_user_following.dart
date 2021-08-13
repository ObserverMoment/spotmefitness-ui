import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:stream_feed/stream_feed.dart';
import 'package:stream_feed/src/client/flat_feed.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// People that the current User is following.
/// i.e. Feeds that their [user_timeline] is following.
class AuthedUserFollowing extends StatefulWidget {
  const AuthedUserFollowing({Key? key}) : super(key: key);

  @override
  _AuthedUserFollowingState createState() => _AuthedUserFollowingState();
}

class _AuthedUserFollowingState extends State<AuthedUserFollowing> {
  late AuthedUser _authedUser;
  late StreamFeedClient _streamFeedClient;
  late FlatFeed _feed;
  bool _isLoading = true;
  List<Follow> _following = <Follow>[];

  @override
  void initState() {
    _authedUser = GetIt.I<AuthBloc>().authedUser!;
    _streamFeedClient = context.streamFeedClient;
    _feed = _streamFeedClient.flatFeed('user_timeline', _authedUser.id);

    _loadFollowing();

    super.initState();
  }

  Future<void> _loadFollowing() async {
    final data = await _feed.following();
    setState(() {
      _isLoading = false;
      _following = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? LoadingCircle()
        : _following.isEmpty
            ? Padding(
                padding: const EdgeInsets.all(32.0),
                child: Center(
                  child: MyText(
                    'Not following anyone yet..',
                    size: FONTSIZE.BIG,
                    subtext: true,
                  ),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: _following.length,
                itemBuilder: (c, i) =>
                    _UserFollowing(following: _following[i]));
  }
}

/// Displays a single follower of a feed.
class _UserFollowing extends StatelessWidget {
  final Follow following;
  const _UserFollowing({Key? key, required this.following}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MyText(following.feedId.toString()),
    );
  }
}
