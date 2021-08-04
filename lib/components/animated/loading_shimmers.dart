import 'package:flutter/cupertino.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class ShimmerCircle extends StatelessWidget {
  final double diameter;
  ShimmerCircle({required this.diameter});
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.15,
      child: Shimmer.fromColors(
          child: Container(
            height: diameter,
            width: diameter,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: context.theme.primary),
          ),
          baseColor: context.theme.cardBackground,
          highlightColor: context.theme.primary),
    );
  }
}

class ShimmerCard extends StatelessWidget {
  final double? height;
  final double? width;
  ShimmerCard({this.height, this.width});
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.15,
      child: Shimmer.fromColors(
          child: Card(
            height: height,
            child: Container(),
          ),
          baseColor: context.theme.cardBackground,
          highlightColor: context.theme.primary),
    );
  }
}

class ShimmerCardList extends StatelessWidget {
  final int itemCount;
  final double cardHeight;
  final EdgeInsets cardPadding;
  ShimmerCardList(
      {required this.itemCount,
      this.cardHeight = 160,
      this.cardPadding = const EdgeInsets.symmetric(vertical: 6.0)});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ListView.builder(
        itemCount: itemCount,
        itemBuilder: (context, index) => Padding(
          padding: cardPadding,
          child: ShimmerCard(
            height: cardHeight,
          ),
        ),
      ),
    );
  }
}

class ShimmerCardGrid extends StatelessWidget {
  final int itemCount;
  final double maxCardWidth;
  final EdgeInsets cardPadding;
  ShimmerCardGrid(
      {required this.itemCount,
      this.maxCardWidth = 200,
      this.cardPadding = const EdgeInsets.all(6.0)});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, left: 12, right: 12),
      child: GridView.builder(
          shrinkWrap: true,
          itemCount: itemCount,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: maxCardWidth,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16),
          itemBuilder: (c, i) => ShimmerCard()),
    );
  }
}

class ShimmerListPage extends StatelessWidget {
  final String title;
  ShimmerListPage({this.title = 'Getting ready...'});
  @override
  Widget build(BuildContext context) {
    return MyPageScaffold(
        navigationBar: BorderlessNavBar(
          middle: NavBarTitle(title),
        ),
        child: ShimmerCardList(
          itemCount: 10,
        ));
  }
}

class ShimmerGridPage extends StatelessWidget {
  final String title;
  ShimmerGridPage({this.title = 'Getting ready...'});
  @override
  Widget build(BuildContext context) {
    return MyPageScaffold(
        navigationBar: BorderlessNavBar(
          middle: NavBarTitle(title),
        ),
        child: ShimmerCardGrid(
          itemCount: 10,
        ));
  }
}

class ShimmerDetailsPage extends StatelessWidget {
  final String title;
  ShimmerDetailsPage({this.title = 'Getting ready...'});
  @override
  Widget build(BuildContext context) {
    return MyPageScaffold(
        navigationBar: BorderlessNavBar(
          middle: NavBarTitle(title),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ShimmerCard(),
              ),
            ),
            Flexible(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ShimmerCard(),
              ),
            ),
            Flexible(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ShimmerCard(),
              ),
            ),
          ],
        ));
  }
}
