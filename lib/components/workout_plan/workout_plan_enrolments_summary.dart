import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/media/images/user_avatar.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class WorkoutPlanEnrolmentsSummary extends StatelessWidget {
  final List<WorkoutPlanEnrolmentSummary> enrolments;
  final int showMax;
  final String? subtitle;
  const WorkoutPlanEnrolmentsSummary(
      {Key? key, required this.enrolments, this.showMax = 5, this.subtitle})
      : super(key: key);

  /// Less than one means an overlap.
  final kAvatarWidthFactor = 0.8;
  final kAvatarSize = 34.0;

  @override
  Widget build(BuildContext context) {
    return enrolments.isEmpty
        ? MyText(
            'No participants yet',
            size: FONTSIZE.SMALL,
            subtext: true,
          )
        : Column(
            children: [
              Container(
                height: 40,
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    reverse: true,
                    children: [
                      ...enrolments
                          .take(showMax)
                          .mapIndexed((i, e) => Align(
                                widthFactor: kAvatarWidthFactor,
                                child: UserAvatar(
                                  border: true,
                                  borderWidth: 1,
                                  avatarUri: e.user.avatarUri,
                                  size: kAvatarSize,
                                ),
                              ))
                          .toList(),
                      if (enrolments.length > showMax)
                        Align(
                          widthFactor: kAvatarWidthFactor,
                          child: PlusOthersIcon(
                            overflow: enrolments.length - showMax,
                            size: kAvatarSize,
                          ),
                        )
                    ]),
              ),
              if (Utils.textNotNull(subtitle))
                MyText(
                  subtitle!,
                  size: FONTSIZE.TINY,
                ),
            ],
          );
  }
}
