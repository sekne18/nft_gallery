import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:nft_gallery/helpers/eth_api.dart';
import 'package:nft_gallery/helpers/helper.dart';
import 'package:nft_gallery/models/nft.dart';
import 'package:nft_gallery/widgets/nft_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<NFT> _searchedNFTs = [];
  late TextEditingController textController;
  String addressToSearch = "";
  bool loading = false;

  void loadNFTs(String address) async {
    bool valid = await Helper.validUrl(address);
    if (valid) {
      EthAPI.searchNFTs(_searchedNFTs, address).then((_) {
        setState(() {
          _searchedNFTs = _;
          loading = false;
        });
      });
    }
  }

  @override
  void initState() {
    textController = TextEditingController()
      ..addListener(() {
        setState(() {
          if (textController.text != "" && textController.text.length == 42) {
            loading = true;
            loadNFTs(textController.text);
          }
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                  child: GridView.count(
                    physics: const BouncingScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    padding: const EdgeInsets.all(4.0),
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                    children: _searchedNFTs
                        .map(
                          (tx) => NFTItem(
                            key: ValueKey(tx.id),
                            nft: tx,
                          ),
                        )
                        .toList(),
                  ),
                ),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: AnimSearchBar(
              color: Theme.of(context).primaryColor == Colors.black
                  ? Colors.white
                  : Colors.grey.shade900,
              style: TextStyle(
                color: Theme.of(context).primaryColor == Colors.black
                    ? Colors.grey.shade900
                    : Colors.white,
              ),
              width: 400,
              textController: textController,
              onSuffixTap: () {
                setState(() {
                  textController.clear();
                  _searchedNFTs = [];
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
