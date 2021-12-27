import 'package:flutter/material.dart';
import 'package:nft_gallery/helpers/eth_api.dart';
import 'package:nft_gallery/helpers/helper.dart';
import 'package:nft_gallery/models/nft.dart';
import 'package:nft_gallery/models/profile.dart';
import 'package:nft_gallery/widgets/nft_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({Key? key}) : super(key: key);

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  List<NFT> _userNFTs = [];

  void loadNFTs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (Profile.last_synched == "" ||
        DateTime.parse(Profile.last_synched)
                .difference(DateTime.now())
                .inHours >
            1) {
      EthAPI.fetchNFTs(_userNFTs, Helper.address).then((_) {
        setState(() {
          _userNFTs = _;
          Profile.nfts_owned = _userNFTs.length;
        });
      });
      EthAPI.fetchProfile(_userNFTs, Helper.address, Helper.walletType);
    } else {
      setState(() {
        _userNFTs = NFT.decode(prefs.getString('listOfNFTs') ?? "");
      });
    }
  }

  @override
  void initState() {
    loadNFTs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NFTList(_userNFTs),
    );
  }
}
