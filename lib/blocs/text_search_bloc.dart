import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gql_exec/gql_exec.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/debounce.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

enum TextSearchType {
  workout,
  workoutName,
  workoutPlan,
  workoutPlanName,
  publicProfile,
  publicProfileName
}

enum TextSearchState { empty, loading, hasResults, error }

/// Handles all types of text search api calls via a 500ms debounce.
/// Returns them via [bloc.results] stream.
class TextSearchBloc<T> {
  final BuildContext context;
  final TextSearchType _textSearchType;
  Debouncer _debouncer = Debouncer();

  TextSearchBloc(this.context, this._textSearchType) {
    _textSearchState.add(TextSearchState.empty);
    _textSearchResults.add(<T>[]);
  }

  /// Streams updated lists of results.
  StreamController<List<T>> _textSearchResults =
      StreamController<List<T>>.broadcast();

  Stream<List<T>> get results => _textSearchResults.stream;

  /// Streams the results data state.
  StreamController<TextSearchState> _textSearchState =
      StreamController<TextSearchState>.broadcast();

  Stream<TextSearchState> get state => _textSearchState.stream;

  void search(String text) {
    /// Defaults to 500ms debounce.
    _debouncer.run(() => _run(text));
  }

  void _checkResponse(Response? response) {
    if (response == null ||
        (response.errors != null && response.errors!.isNotEmpty) ||
        response.data == null) {
      response!.errors!.forEach((e) => print(e));

      throw Exception(
          'There was a problem getting search results from the API');
    }
  }

  void _run(String text) async {
    _textSearchState.add(TextSearchState.loading);

    try {
      Response? response;
      switch (_textSearchType) {
        case TextSearchType.workout:
          final query = TextSearchWorkoutsQuery(
              variables: TextSearchWorkoutsArguments(text: text));

          response = await context.graphQLStore.execute(query);

          _checkResponse(response);

          _textSearchResults.add(
              query.parse(response.data ?? {}).textSearchWorkouts! as List<T>);
          break;
        case TextSearchType.workoutName:
          final query = TextSearchWorkoutNamesQuery(
              variables: TextSearchWorkoutNamesArguments(text: text));

          response = await context.graphQLStore.execute(query);

          _checkResponse(response);

          _textSearchResults.add(query
              .parse(response.data ?? {})
              .textSearchWorkoutNames! as List<T>);
          break;
        case TextSearchType.workoutPlan:
          final query = TextSearchWorkoutPlansQuery(
              variables: TextSearchWorkoutPlansArguments(text: text));

          response = await context.graphQLStore.execute(query);

          _checkResponse(response);

          _textSearchResults.add(query
              .parse(response.data ?? {})
              .textSearchWorkoutPlans! as List<T>);
          break;
        case TextSearchType.workoutPlanName:
          final query = TextSearchWorkoutPlanNamesQuery(
              variables: TextSearchWorkoutPlanNamesArguments(text: text));

          response = await context.graphQLStore.execute(query);

          _checkResponse(response);

          _textSearchResults.add(query
              .parse(response.data ?? {})
              .textSearchWorkoutPlanNames! as List<T>);
          break;
        case TextSearchType.publicProfile:
          print('TextSearchType.publicProfile: Not implemented');
          break;
        case TextSearchType.publicProfileName:
          print('TextSearchType.publicProfileName: Not implemented');
          break;
        default:
          throw Exception(
              'TextSearchBloc.runTextSearch: No method defined for $_textSearchType');
      }

      _textSearchState.add(TextSearchState.hasResults);
    } catch (e) {
      print(e);
      _textSearchState.add(TextSearchState.error);
    }
  }

  /// [gotoState] allows reverting any state after clearing.
  /// Initailly implemented due to the way workout finder text search handles the two types of results for public workouts. [List<Workout> and List<TextSearchResult>], and how it transitions between them based on state and empty results lists.
  void clear({TextSearchState gotoState = TextSearchState.empty}) {
    _textSearchResults.add(<T>[]);
    _textSearchState.add(gotoState);
  }

  void dispose() {
    _textSearchResults.close();
  }
}
