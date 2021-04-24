import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

const kBodyweightEquipmentId = 'b95da267-c036-4caa-9294-d1fab9b3d2e8';
const kFullScreenImageViewerHeroTag = 'kFullScreenImageViewerHeroTag';

/// [Free Session].
WorkoutSectionType kGenDefaultWorkoutSectionType() {
  return WorkoutSectionType()
    ..id = 0.toString()
    ..name = 'Section'
    ..description = '';
}

/// WorkoutSectionTypeNames
const kFreeSession = 'Free Session';
const kHIITCircuit = 'HIIT Circuit';

/// BodyArea selector SVG viewbox sizes.
/// Required to correctly render custom path clips on top of graphical SVG elements.
const double kBodyAreaSelector_svg_width = 93.6;
const double kBodyAreaSelector_svg_height = 213.43;
