import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/utils.dart';

enum ObjectTextSearchScope { private, public }

class TextSearchFilters {
  static bool workoutBySearchString(Workout workout, String searchString) {
    return [
      workout.name,
      ...workout.workoutGoals.map((g) => g.name).toList(),
      ...workout.workoutTags.map((t) => t.tag).toList()
    ]
        .where((t) => Utils.textNotNull(t))
        .map((t) => t.toLowerCase())
        .any((t) => t.contains(searchString));
  }

  static List<Workout> workoutsBySearchString(
      List<Workout> original, String searchString) {
    return Utils.textNotNull(searchString)
        ? original.where((m) => workoutBySearchString(m, searchString)).toList()
        : [];
  }
}
