import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/gym_profile_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/tappable_row.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:auto_route/auto_route.dart';

class GymProfileSelectorDisplay extends StatelessWidget {
  final GymProfile? gymProfile;
  final void Function(GymProfile? gymProfile) selectGymProfile;
  final VoidCallback clearGymProfile;
  const GymProfileSelectorDisplay({
    Key? key,
    required this.gymProfile,
    required this.selectGymProfile,
    required this.clearGymProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          Expanded(
            child: TappableRow(
              onTap: () => context.push(
                  child: GymProfileSelector(
                selectedGymProfile: gymProfile,
                selectGymProfile: selectGymProfile,
              )),
              title: 'Gym Profile',
              display: gymProfile == null
                  ? MyText(
                      'Select...',
                      subtext: true,
                    )
                  : ContentBox(child: MyText(gymProfile!.name)),
            ),
          ),
          if (gymProfile != null)
            FadeIn(
              child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Icon(
                    CupertinoIcons.clear_thick,
                    color: Styles.errorRed,
                    size: 20,
                  ),
                  onPressed: clearGymProfile),
            )
        ],
      ),
    );
  }
}

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
          navigationBar: BottomBorderNavBar(
            bottomBorderColor: context.theme.navbarBottomBorder,
            customLeading: NavBarCancelButton(context.pop),
            middle: NavBarTitle('Select Gym Profile'),
            trailing: NavBarSaveButton(context.pop, text: 'Done'),
          ),
          child: gymProfiles.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          MyText('No gym profiles...'),
                          SizedBox(height: 16),
                          SecondaryButton(
                              prefixIconData: CupertinoIcons.add,
                              text: 'Create a Gym Profile',
                              onPressed: () =>
                                  context.pushRoute(GymProfileCreatorRoute()))
                        ],
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
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
