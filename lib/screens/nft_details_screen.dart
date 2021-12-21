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
            Image.network(nft.image),
            Container(
              margin: EdgeInsets.only(top: size.height * 0.45),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35)),
                color: Colors.white,
              ),
              padding: const EdgeInsets.only(top: 60),
            ),
          ],
        ),
      ),
    );
  }
}
