import 'package:flutter/material.dart';
import 'package:nft_gallery/models/nft.dart';

import 'nft_item.dart';

class NFTList extends StatelessWidget {
  final List<NFT> nfts;

  NFTList(
    this.nfts,
  );

  @override
  Widget build(BuildContext context) {
    return nfts.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Center(
              child: Text(
                "Don't own any NFTs yet!",
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
              children: nfts
                  .map(
                    (tx) => NFTItem(
                      key: ValueKey(tx.id),
                      nft: tx,
                    ),
                  )
                  .toList(),
            ),
          );
  }
}
