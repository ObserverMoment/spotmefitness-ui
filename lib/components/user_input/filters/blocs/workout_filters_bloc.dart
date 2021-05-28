import 'package:flutter/cupertino.dart';

class WorkoutFiltersBloc extends ChangeNotifier {
  late WorkoutFilters _workoutFilters;
  WorkoutFiltersBloc() {
    _workoutFilters = WorkoutFilters();
  }

  WorkoutFilters get filters => _workoutFilters;
}

class WorkoutFilters {}
