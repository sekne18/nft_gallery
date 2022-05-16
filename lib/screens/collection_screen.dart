import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
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
  List<int> verticalData = [];

  final int increment = 10;
  bool isLoadingVertical = false;

  Future loadNFTs() async {
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

  Future _loadMoreVertical() async {
    setState(() {
      isLoadingVertical = true;
    });

    // Add in an artificial delay
    await new Future.delayed(const Duration(seconds: 2));
    await loadNFTs();
    verticalData.addAll(
        List.generate(increment, (index) => verticalData.length + index));

    setState(() {
      isLoadingVertical = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadMoreVertical();
  }

  @override
  Widget build(BuildContext context) {
    return LazyLoadScrollView(
      isLoading: isLoadingVertical,
      onEndOfPage: () => _loadMoreVertical(),
      child: Scrollbar(
        child: SafeArea(
          child: NFTList(_userNFTs, verticalData),
        ),
      ),
    );
  }
}
