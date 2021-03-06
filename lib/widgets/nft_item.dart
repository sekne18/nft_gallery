import 'package:flutter/material.dart';
import 'package:nft_gallery/models/nft.dart';
import 'package:nft_gallery/screens/nft_details_screen.dart';

class NFTItem extends StatelessWidget {
  final NFT nft;

  NFTItem({
    required this.nft,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 700),
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return NFTDetailsScreen(
                nft: nft,
              );
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return Align(
                child: FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              );
            },
          ),
        );
      },
      child: Hero(
        tag: 'nft_image_${nft.id}',
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            color: Colors.transparent,
            elevation: 6,
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: NFT.imageFromBase64String(nft.image),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
