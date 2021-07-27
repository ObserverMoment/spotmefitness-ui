import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: BorderlessNavBar(
        customLeading: NavBarLargeTitle('Progress'),
      ),
      child: Column(
        children: [
          CarouselSlider(
              items: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ContentBox(
                      child: Row(
                    children: [
                      MyText('Streak Info + Stats Summary'),
                    ],
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ContentBox(
                      child: Row(
                    children: [
                      MyText('Recent PBs'),
                    ],
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ContentBox(
                      child: Row(
                    children: [
                      MyText('Journal Entry Scores graph'),
                    ],
                  )),
                ),
              ],
              options: CarouselOptions(
                height: 180,
                aspectRatio: 16 / 9,
                viewportFraction: 0.95,
                initialPage: 0,
                enableInfiniteScroll: false,
                scrollDirection: Axis.horizontal,
              )),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: GridView.count(
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              shrinkWrap: true,
              crossAxisCount: 2,
              children: [
                _ProgressPageTile(
                  label: 'Personal Best Lifts & Times',
                  assetImagePath: 'progress_page_personal_bests.jpg',
                  onTap: () => context.navigateTo(PersonalBestsRoute()),
                ),
                _ProgressPageTile(
                  label: 'Journal and Goal Tracking',
                  assetImagePath: 'progress_page_journal.jpg',
                  onTap: () => context.navigateTo(JournalsRoute()),
                ),
                _ProgressPageTile(
                  label: 'Body Transformation',
                  assetImagePath: 'progress_page_body.jpg',
                  onTap: () => context.navigateTo(BodyTransformationRoute()),
                ),
                _ProgressPageTile(
                  label: 'Workout Logs & History',
                  assetImagePath: 'progress_page_logs.jpg',
                  onTap: () => context.navigateTo(LoggedWorkoutsRoute()),
                ),
              ],
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
  _ProgressPageTile(
      {required this.label, required this.assetImagePath, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(6),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
              fit: BoxFit.cover,
              image:
                  AssetImage('assets/progress_page_images/${assetImagePath}')),
        ),
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: context.theme.cardBackground.withOpacity(0.9),
              ),
              padding:
                  const EdgeInsets.only(bottom: 8, right: 20, left: 20, top: 8),
              child: MyText(
                label,
                weight: FontWeight.bold,
                maxLines: 2,
                lineHeight: 1.3,
                textAlign: TextAlign.center,
              ),
            )),
      ),
    );
  }
}
