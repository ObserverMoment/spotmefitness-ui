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
            child: Container(width: width),
          ),
          baseColor: context.theme.cardBackground,
          highlightColor: context.theme.primary),
    );
  }
}

class ShimmerCardList extends StatelessWidget {
  final int itemCount;
  final double? cardHeight;
  final EdgeInsets cardPadding;
  ShimmerCardList(
      {required this.itemCount,
      this.cardHeight = 160,
      this.cardPadding = const EdgeInsets.symmetric(vertical: 6.0)});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(4.0),
      itemCount: itemCount,
      itemBuilder: (context, index) => Padding(
        padding: cardPadding,
        child: ShimmerCard(
          height: cardHeight,
        ),
      ),
    );
  }
}

class ShimmerHorizontalCardList extends StatelessWidget {
  final int itemCount;
  final double listHeight;
  final double cardWidth;

  ShimmerHorizontalCardList(
      {this.itemCount = 10, this.listHeight = 120, this.cardWidth = 170});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: listHeight,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(4.0),
          child: ShimmerCard(
            width: cardWidth,
          ),
        ),
      ),
    );
  }
}

class ShimmerFriendsList extends StatelessWidget {
  final int itemCount;
  final double avatarSize;
  final Axis scrollDirection;
  const ShimmerFriendsList(
      {this.itemCount = 10,
      this.avatarSize = 76,
      this.scrollDirection = Axis.horizontal});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: avatarSize,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: itemCount,
        scrollDirection: scrollDirection,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(right: 8),
          child: ShimmerCircle(
            diameter: avatarSize,
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

class ShimmerCirclesGrid extends StatelessWidget {
  final int itemCount;
  final double maxDiameter;
  final EdgeInsets cardPadding;
  ShimmerCirclesGrid(
      {this.itemCount = 20,
      this.maxDiameter = 80,
      this.cardPadding = const EdgeInsets.all(6.0)});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, left: 12, right: 12),
      child: GridView.builder(
          shrinkWrap: true,
          itemCount: itemCount,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: maxDiameter,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16),
          itemBuilder: (c, i) => ShimmerCircle(
                diameter: maxDiameter,
              )),
    );
  }
}

class ShimmerListPage extends StatelessWidget {
  final String title;
  final double? cardHeight;
  ShimmerListPage({this.title = 'Getting ready...', this.cardHeight = 200});
  @override
  Widget build(BuildContext context) {
    return MyPageScaffold(
        navigationBar: MyNavBar(
          middle: NavBarTitle(title),
        ),
        child: ShimmerCardList(
          itemCount: 10,
          cardHeight: cardHeight,
        ));
  }
}

class ShimmerGridPage extends StatelessWidget {
  final String title;
  ShimmerGridPage({this.title = 'Getting ready...'});
  @override
  Widget build(BuildContext context) {
    return MyPageScaffold(
        navigationBar: MyNavBar(
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
        navigationBar: MyNavBar(
          backgroundColor: context.theme.background,
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

class ShimmerChatChannelPreviewList extends StatelessWidget {
  final int itemCount;
  ShimmerChatChannelPreviewList({
    this.itemCount = 20,
  });

  @override
  Widget build(BuildContext context) {
    final primary = context.theme.primary.withOpacity(0.4);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: itemCount,
          itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Shimmer.fromColors(
                  baseColor: context.theme.cardBackground,
                  highlightColor: primary,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    height: 66,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: primary,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints.tightFor(
                            height: 44,
                            width: 44,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: primary,
                                  borderRadius: BorderRadius.circular(11),
                                ),
                                constraints: const BoxConstraints.tightFor(
                                  height: 14,
                                  width: 90,
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: primary,
                                      borderRadius: BorderRadius.circular(11),
                                    ),
                                    constraints: const BoxConstraints.expand(
                                      height: 14,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        Container(
                          decoration: BoxDecoration(
                            color: primary,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints.tightFor(
                            height: 22,
                            width: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
    );
  }
}
