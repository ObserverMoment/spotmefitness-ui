import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:sofie_ui/components/layout.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/extensions/context_extensions.dart';
import 'package:sofie_ui/pages/authed/progress/components/personal_bests_summary.dart';
import 'package:sofie_ui/pages/authed/progress/components/streak_and_stats_summary.dart';
import 'package:sofie_ui/router.gr.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyPageScaffold(
      navigationBar: const MyNavBar(
        withoutLeading: true,
        middle: LeadingNavBarTitle(
          'Progress',
          fontSize: FONTSIZE.five,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: CarouselSlider(
                items: [
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: StreakAndStatsSummary(),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: PersonalBestsSummary(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ContentBox(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            MyText(
                              'Recent Challenges Summary',
                              lineHeight: 1.5,
                            ),
                            MyText(
                              'Coming Soon',
                              lineHeight: 1.5,
                            ),
                          ],
                        ),
                      ],
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ContentBox(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            MyText(
                              'Recent Event Rankings Summary',
                              lineHeight: 1.5,
                            ),
                            MyText(
                              'Coming Soon',
                              lineHeight: 1.5,
                            ),
                          ],
                        ),
                      ],
                    )),
                  ),
                ],
                options: CarouselOptions(
                  height: 200,
                  viewportFraction: 0.95,
                  enableInfiniteScroll: false,
                )),
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4),
              child: GridView.count(
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                shrinkWrap: true,
                crossAxisCount: 2,
                children: [
                  _ProgressPageTile(
                    label: 'Personal Best Lifts & Times',
                    assetImagePath: 'progress_page_personal_bests.jpg',
                    onTap: () => context.navigateTo(const PersonalBestsRoute()),
                  ),
                  _ProgressPageTile(
                    label: 'Journal and Goal Tracking',
                    assetImagePath: 'progress_page_journal.jpg',
                    onTap: () => context.navigateTo(const JournalsRoute()),
                  ),
                  _ProgressPageTile(
                    label: 'Body Transformation',
                    assetImagePath: 'progress_page_body.jpg',
                    onTap: () =>
                        context.navigateTo(const BodyTransformationRoute()),
                  ),
                  _ProgressPageTile(
                    label: 'Workout Logs & History',
                    assetImagePath: 'progress_page_logs.jpg',
                    onTap: () =>
                        context.navigateTo(const LoggedWorkoutsRoute()),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _ProgressPageTile extends StatelessWidget {
  final String label;
  final String assetImagePath;
  final void Function() onTap;
  const _ProgressPageTile(
      {required this.label, required this.assetImagePath, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(4),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/progress_page_images/$assetImagePath')),
        ),
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: context.theme.cardBackground.withOpacity(0.9),
              ),
              padding:
                  const EdgeInsets.only(bottom: 8, right: 20, left: 20, top: 8),
              child: MyHeaderText(
                label,
                maxLines: 2,
                lineHeight: 1.3,
                textAlign: TextAlign.center,
              ),
            )),
      ),
    );
  }
}
