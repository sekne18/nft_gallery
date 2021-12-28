import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:nft_gallery/models/nft.dart';

import 'nft_item.dart';

class NFTList extends StatelessWidget {
  final List<NFT> nfts;
  int index = -1;

  NFTList(
    this.nfts,
  );

  @override
  Widget build(BuildContext context) {
    return nfts.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Center(
              child: Text(
                "You don't own any NFTs yet!",
                style: Theme.of(context).textTheme.headline6,
              ),
            );
          })
        : Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: GridView.count(
              physics: const BouncingScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1,
              padding: const EdgeInsets.all(4.0),
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              children: nfts.map((tx) {
                return AnimationConfiguration.staggeredGrid(
                  position: index++,
                  duration: const Duration(milliseconds: 650),
                  columnCount: 2,
                  child: ScaleAnimation(
                    scale: 0.2,
                    child: NFTItem(
                      key: ValueKey(tx.id),
                      nft: tx,
                    ),
                  ),
                );
              }).toList(),
            ),
          );
  }
}
