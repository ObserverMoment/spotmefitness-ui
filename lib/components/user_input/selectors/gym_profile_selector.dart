import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/gym_profile_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:auto_route/auto_route.dart';

/// Not wrapped in a page scaffold to allow inline opening or bottom sheet style.
class GymProfileSelector extends StatefulWidget {
  final void Function(GymProfile? profile) selectGymProfile;
  final GymProfile? selectedGymProfile;
  GymProfileSelector({required this.selectGymProfile, this.selectedGymProfile});

  @override
  _GymProfileSelectorState createState() => _GymProfileSelectorState();
}

class _GymProfileSelectorState extends State<GymProfileSelector> {
  GymProfile? _activeSelectedGymProfile;

  @override
  void initState() {
    super.initState();
    _activeSelectedGymProfile = widget.selectedGymProfile;
  }

  void _handleSelection(GymProfile gymProfile) {
    /// Allow for toggle type interaction.
    if (gymProfile == _activeSelectedGymProfile) {
      widget.selectGymProfile(null);
      setState(() => _activeSelectedGymProfile = null);
    } else {
      widget.selectGymProfile(gymProfile);
      setState(() => _activeSelectedGymProfile = gymProfile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return QueryObserver<GymProfiles$Query, json.JsonSerializable>(
      key: Key('GymProfileSelector - ${GymProfilesQuery().operationName}'),
      loadingIndicator: ShimmerListPage(
        cardHeight: 160,
      ),
      query: GymProfilesQuery(),
      builder: (data) {
        final gymProfiles = data.gymProfiles.reversed.toList();
        return MyPageScaffold(
          navigationBar: BorderlessNavBar(
            withoutLeading: true,
            middle: NavBarTitle('Select Gym Profile'),
            trailing: NavBarSaveButton(context.pop, text: 'Done'),
          ),
          child: gymProfiles.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      MyText('No gym profiles created...'),
                      SizedBox(height: 16),
                      BorderButton(
                          prefix: Icon(
                            CupertinoIcons.add_circled,
                            size: 22,
                          ),
                          text: 'Create a Gym Profile',
                          onPressed: () =>
                              context.pushRoute(GymProfileCreatorRoute()))
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: gymProfiles.length,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: GestureDetector(
                          onTap: () => _handleSelection(gymProfiles[index]),
                          child: SelectGymProfileItem(gymProfiles[index],
                              gymProfiles[index] == _activeSelectedGymProfile),
                        ),
                      )),
        );
      },
    );
  }
}

class SelectGymProfileItem extends StatelessWidget {
  final GymProfile gymProfile;
  final bool isSelected;
  SelectGymProfileItem(this.gymProfile, this.isSelected);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: kStandardAnimationDuration,
      decoration: BoxDecoration(
          borderRadius: kStandardCardBorderRadius,
          border: Border.all(
              width: 3,
              color: Styles.colorOne.withOpacity(isSelected ? 1.0 : 0.0))),
      child: GymProfileCard(
        gymProfile: gymProfile,
      ),
    );
  }
}
