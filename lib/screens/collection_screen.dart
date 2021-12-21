import 'package:flutter/material.dart';
import 'package:nft_gallery/helpers/eth_api.dart';
import 'package:nft_gallery/models/nft.dart';
import 'package:nft_gallery/models/profile.dart';
import 'package:nft_gallery/widgets/nft_list.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({Key? key}) : super(key: key);

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  List<NFT> _userNFTs = [];
  String address = "0x8637d538488513e3f71b5399fa04d2fb6ec19a4c";
  String walletType = "Ethereum";

  @override
  void initState() {
    if (Profile.last_synched == "" ||
        DateTime.parse(Profile.last_synched)
                .difference(DateTime.now())
                .inHours >
            1) {
      EthAPI.fetchNFTs(_userNFTs, address).then((_) {
        setState(() {
          _userNFTs = _;
        });
      });
      EthAPI.fetchProfile(_userNFTs, address, walletType);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NFTList(_userNFTs),
    );
  }
}
