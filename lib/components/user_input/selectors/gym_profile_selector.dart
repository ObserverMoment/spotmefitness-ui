import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class GymProfileSelector extends StatefulWidget {
  final void Function(GymProfile profile) selectGymProfile;
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
    widget.selectGymProfile(gymProfile);
    setState(() => _activeSelectedGymProfile = gymProfile);
  }

  @override
  Widget build(BuildContext context) {
    return QueryObserver<GymProfiles$Query, json.JsonSerializable>(
      key: Key('GymProfileSelector - ${GymProfilesQuery().operationName}'),
      query: GymProfilesQuery(),
      builder: (data) {
        final gymProfiles = data.gymProfiles;
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NavBarTitle('Select Gym Profile'),
                  TextButton(
                    text: 'Done',
                    onPressed: context.pop,
                    underline: false,
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: ListView.builder(
                    itemCount: gymProfiles.length,
                    itemBuilder: (context, index) => GestureDetector(
                          onTap: () => _handleSelection(gymProfiles[index]),
                          child: SelecteGymProfileItem(gymProfiles[index],
                              gymProfiles[index] == _activeSelectedGymProfile),
                        )),
              ),
            )
          ],
        );
      },
    );
  }
}

class SelecteGymProfileItem extends StatelessWidget {
  final GymProfile gymProfile;
  final bool isSelected;
  SelecteGymProfileItem(this.gymProfile, this.isSelected);

  Widget _buildEquipmentTag(Equipment e) => Padding(
        padding: const EdgeInsets.only(right: 4.0),
        child: ContentBox(
            child: MyText(
          e.name,
          lineHeight: 1,
        )),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Card(
        // backgroundColor: context.theme.background,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: H3(
                    gymProfile.name,
                    textAlign: TextAlign.start,
                  ),
                ),
                if (isSelected)
                  FadeIn(
                    child: Icon(
                      CupertinoIcons.checkmark_alt,
                      color: Styles.infoBlue,
                    ),
                  )
              ],
            ),
            SizedBox(height: 6),
            if (gymProfile.equipments.isNotEmpty)
              SizedBox(
                height: 30,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: gymProfile.equipments.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, eIndex) =>
                        _buildEquipmentTag(gymProfile.equipments[eIndex])),
              ),
            HorizontalLine()
          ],
        ),
      ),
    );
  }
}
