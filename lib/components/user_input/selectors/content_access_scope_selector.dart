import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/pickers/sliding_select.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';

/// Select between PRIVATE and PUBLIC via sliding select and display a brief explainer.
/// Content of the explainer depends on which option is selected.
class ContentAccessScopeSelector extends StatelessWidget {
  final ContentAccessScope contentAccessScope;
  final void Function(ContentAccessScope scope) updateContentAccessScope;
  const ContentAccessScopeSelector(
      {Key? key,
      required this.contentAccessScope,
      required this.updateContentAccessScope})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UserInputContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: double.infinity,
                child: SlidingSelect<ContentAccessScope>(
                    value: contentAccessScope,
                    children: <ContentAccessScope, Widget>{
                      for (final v in ContentAccessScope.values
                          .where((v) => v != ContentAccessScope.artemisUnknown))
                        v: MyText(v.display)
                    },
                    updateValue: updateContentAccessScope)),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: AnimatedSwitcher(
                  duration: kStandardAnimationDuration,
                  child: MyText(
                    contentAccessScope == ContentAccessScope.private
                        ? 'Only people you share this with, and people who are members of clubs you share this with, will have access.'
                        : 'Everyone will be able to view this.',
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    lineHeight: 1.2,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
