import 'package:flutter/material.dart';
import 'package:nft_gallery/models/nft.dart';

class NFTDetailsScreen extends StatelessWidget {
  NFT nft;

  NFTDetailsScreen({Key? key, required this.nft}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Hero(
        tag: 'nft_image_${nft.id}',
        child: Stack(
          children: <Widget>[
            NFT.imageFromBase64String(nft.image),
            Container(
              margin: EdgeInsets.only(top: size.height * 0.45),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35)),
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              padding: const EdgeInsets.only(top: 60),
            ),
            Material(
              type: MaterialType.transparency,
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: size.height * 0.51),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      nft.name,
                      style: const TextStyle(
                        fontSize: 23,
                      ),
                    ),
                    Text(
                      "Copies: " + nft.total_supply.toString(),
                      style: const TextStyle(
                        fontSize: 23,
                      ),
                    ),
                    // Text(
                    //   "Creator: " + nft.creator,
                    //   style: const TextStyle(
                    //     fontSize: 23,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
