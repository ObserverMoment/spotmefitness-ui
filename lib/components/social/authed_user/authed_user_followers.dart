import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:stream_feed/stream_feed.dart';
import 'package:stream_feed/src/client/flat_feed.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// Followers of the currently logged in User.
/// i.e Details of other users [user_timelines] which are following this users [user_feed]
class AuthedUserFollowers extends StatefulWidget {
  const AuthedUserFollowers({Key? key}) : super(key: key);

  @override
  _AuthedUserFollowersState createState() => _AuthedUserFollowersState();
}

class _AuthedUserFollowersState extends State<AuthedUserFollowers> {
  late AuthedUser _authedUser;
  late StreamFeedClient _streamFeedClient;
  late FlatFeed _feed;
  bool _isLoading = true;
  List<Follow> _followers = <Follow>[];

  @override
  void initState() {
    _authedUser = GetIt.I<AuthBloc>().authedUser!;
    _streamFeedClient = context.streamFeedClient;
    _feed = _streamFeedClient.flatFeed('user_feed', _authedUser.id);

    _loadFollowers();

    super.initState();
  }

  Future<void> _loadFollowers() async {
    final data = await _feed.followers();
    setState(() {
      _isLoading = false;
      _followers = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? LoadingCircle()
        : _followers.isEmpty
            ? Padding(
                padding: const EdgeInsets.all(32.0),
                child: Center(
                  child: MyText(
                    'No followers yet..',
                    size: FONTSIZE.BIG,
                    subtext: true,
                  ),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: _followers.length,
                itemBuilder: (c, i) => _UserFollower(follower: _followers[i]));
  }
}

/// Displays a single follower of a feed.
class _UserFollower extends StatelessWidget {
  final Follow follower;
  const _UserFollower({Key? key, required this.follower}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MyText(follower.feedId.toString()),
    );
  }
}
