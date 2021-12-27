import 'package:flutter/material.dart';
import 'package:nft_gallery/models/profile.dart';
import 'package:nft_gallery/widgets/change_theme_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            height: 50,
            alignment: Alignment.centerRight,
            child: const ChangeThemeButtonWidget(),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor == Colors.black
                          ? Colors.white
                          : Colors.grey.shade900,
                  radius: 80,
                  child: Image.network(Profile.image),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 9,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(
                  left: 30,
                  top: 100,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 15.0),
                      child: Text(
                        "Number of NFTs owned: ${Profile.nfts_owned}",
                        style: const TextStyle(fontSize: 17),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: Text(
                        "Wallet balance: ${Profile.balance} ETH",
                        style: const TextStyle(fontSize: 17),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        "Last synched: ${Profile.last_synched}",
                        style: const TextStyle(fontSize: 17),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
