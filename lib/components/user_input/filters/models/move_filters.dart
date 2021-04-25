import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

class MoveFilters {
  static MoveFilters retrieveFiltersFromdevice() {
    /// TODO: Check if filters are saved in hive box.
    /// If so then retrieve, convert to model and return.
    /// If not then return default empty settings.
    return MoveFilters();
  }

  static void persistFiltersTodevice(MoveFilters filters) {
    /// TODO: Convert filters into JSON and persist to Hive box;
  }

  /// Return only moves of these types.
  List<MoveType> moveTypes;

  /// Return only moves that can be done given that you have only these equipments.
  List<Equipment> equipments;

  /// Moves that either
  /// 1. Have empty required and selectable equipments
  /// 2. Have no required equipments and selectable equipments includes bodyweight.
  bool bodyWeightOnly;

  /// Return only moves that target one or more of these body areas.
  List<BodyArea> bodyAreas;

  MoveFilters(
      {this.bodyWeightOnly = false,
      this.moveTypes = const [],
      this.equipments = const [],
      this.bodyAreas = const []});

  List<Move> filter(List<Move> moves) => moves;
}
