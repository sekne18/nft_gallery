import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:nft_gallery/models/nft.dart';

import 'nft_item.dart';

class NFTList extends StatelessWidget {
  final List<NFT> nfts;
  List<int> verticalData;
  int index = -1;

  NFTList(
    this.nfts,
    this.verticalData,
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
        : Scrollbar(
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
              child: GridView.builder(
                // shrinkWrap: true,
                padding: const EdgeInsets.all(4.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                ),
                itemCount: verticalData.length,
                itemBuilder: (context, position) {
                  return NFTItem(nft: nfts[position],);
                },
              ),
            ),
        );
  }
}

// nfts.map((tx) {
// return AnimationConfiguration.staggeredGrid(
// position: index++,
// duration: const Duration(milliseconds: 650),
// columnCount: 2,
// child: ScaleAnimation(
// scale: 0.0,
// child: NFTItem(
// key: ValueKey(tx.id),
// nft: tx,
// ),
// ),
// );
// }).toList(),
