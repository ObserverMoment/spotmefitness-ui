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
      this.cardPadding = const EdgeInsets.all(6.0)});
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

class ShimmerDetailsPage extends StatelessWidget {
  final String title;
  ShimmerDetailsPage({required this.title});
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: BasicNavBar(
          heroTag: 'ShimmerDetailsPage',
          middle: NavBarTitle(title),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
          ),
        ));
  }
}