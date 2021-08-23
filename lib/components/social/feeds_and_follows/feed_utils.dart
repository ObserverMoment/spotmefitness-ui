import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/social/feeds_and_follows/model.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:stream_feed/stream_feed.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:collection/collection.dart';
import 'package:stream_feed/src/client/flat_feed.dart';

class FeedUtils {
  /// Calls our API to get the necessary data for the User (who created the post) and for the referenced object (all posts reference an object in the DB - e.g a Workout).
  /// Based on [userId] via [activity.actor], and [objectId] | [objectType] via [activity.object]
  /// [ActivityWithObjectData] is what is needed to display a single post in the UI.
  static Future<List<ActivityWithObjectData>> getPostsUserAndObjectData(
      BuildContext context, List<EnrichedActivity> activities) async {
    final List<TimelinePostDataRequestInput> postDataRequests =
        activities.map((a) {
      if (a.object == null) {
        throw Exception('Error: Activity.object should never be null.');
      }
      if (a.actor == null) {
        throw Exception('Error: Activity.actor should never be null.');
      }
      final idAndType = objectStringIdFromEnriched(a.object!).split(':');

      return TimelinePostDataRequestInput(
          posterId: actorStringIdFromEnriched(a.actor!).split(':')[1],
          objectId: idAndType[1],
          objectType: idAndType[0].toTimelinePostType());
    }).toList();

    /// Call API and get TimelinePostData[]
    final result = await context.graphQLStore.networkOnlyOperation<
            TimelinePostsData$Query, TimelinePostsDataArguments>(
        operation: TimelinePostsDataQuery(
            variables: TimelinePostsDataArguments(
                postDataRequests: postDataRequests)));

    if (result.hasErrors || result.data == null) {
      throw Exception(
          'getPostUserAndObjectData: Unable to retrieve full timeline posts data.');
    }

    /// [activities] and [requestedPosts] are in the same order - so we can match without going back into the [activities].
    /// Find the correct [TimelinePostData] by matching both the userId and the objectId, then add  to [ActivityWithObjectData] along with the [activity].
    return activities
        .mapIndexed<ActivityWithObjectData>((i, activity) =>
            ActivityWithObjectData(
                activity,
                result.data?.timelinePostsData.firstWhereOrNull((p) =>
                    p.poster.id == postDataRequests[i].posterId &&
                    p.object.id == postDataRequests[i].objectId)))
        .toList();
  }

  /// Call our API and get the data necessary to display a user avatar and name.
  /// The feed / timeline ID in getstream matches a User id in our API.
  /// eg. ["user_feed:{our_user_id}""] or ["user_timeline:{our_user_id}""]
  static Future<List<FollowWithUserAvatarData>> getFollowsWithUserData(
      BuildContext context, List<Follow> follows, List<String> userIds) async {
    /// Call API and get UserAvatarData[]
    final result = await context.graphQLStore
        .networkOnlyOperation<UserAvatars$Query, UserAvatarsArguments>(
            operation: UserAvatarsQuery(
                variables: UserAvatarsArguments(ids: userIds)));

    if (result.hasErrors || result.data == null) {
      throw Exception(
          '_getFollowsWithUserData: Unable to retrieve full user follow data.');
    }

    return follows
        .mapIndexed<FollowWithUserAvatarData>((i, follower) =>
            FollowWithUserAvatarData(
                follower,
                result.data?.userAvatars
                    .firstWhereOrNull((u) => u.id == userIds[i])))
        .toList();
  }

  static void deleteActivityById(
      BuildContext context, FlatFeed feed, String activityId) {
    context.showConfirmDeleteDialog(
        itemType: 'Post',
        message: 'This will remove the post from all timelines. Are you sure?',
        onConfirm: () async {
          try {
            await feed.removeActivityById(activityId);
            context.showToast(message: 'Post deleted.');
          } catch (e) {
            print(e);
            context.showToast(
                message:
                    'Sorry, there was a problem, the post could not be deleted.');
          }
        });
  }

  /// The difference between the structures of EnrichedActivity and Activty is awkward...
  /// Will also change depending if you have stored an object (a user for example) in getStream.
  /// Here we assume that no enriched data exists.
  static Activity activityFromEnrichedActivity(EnrichedActivity e) => Activity(
        id: e.id,
        // Must be [SU:id]
        actor: "SU:${(e.actor!.data as Map)['id']}",
        // Must be [ObjectType:id]
        object: e.object!.data.toString(),
        verb: e.verb,
        time: e.time,
        extraData: e.extraData,
      );

  /// Helpers to convert EnrichableField data to standard [type:id] string IDs.
  static String actorStringIdFromEnriched(EnrichableField actor) =>
      "SU:${(actor.data as Map)['id']}";

  static String objectStringIdFromEnriched(EnrichableField object) =>
      object.data.toString();
}
