import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:nft_gallery/models/nft.dart';
import 'package:nft_gallery/models/profile.dart';

import 'helper.dart';

class EthAPI {
  static const String _API_KEY = "8E3SY6IA38VWDESYM3V2E5IWM364BVGV3V";

  static Future<List<NFT>> fetchNFTs(
      List<NFT> _userNFTs, String _walletAddress) async {
    _userNFTs = [];
    String url =
        "https://api.opensea.io/api/v1/assets?&owner=${_walletAddress}&format=json";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var nftsJson = json.decode(response.body);
      for (var nft in nftsJson['assets']) {
        if (nft['image_url'] != "") {
          _userNFTs.add(
            NFT(
              id: nft['id'].toString(),
              image: nft['image_url'],
              name: nft['name'].toString(),
              creator: nft['creator']['user']['username'] ?? "",
              total_supply: nft['asset_contract']['total_supply'] != null
                  ? int.parse(nft['asset_contract']['total_supply']) + 1
                  : 0,
            ),
          );
        }
      }
    }
    // String encodedData = NFT.encode(_userNFTs);
    // Helper.prefs.setString('listOfNFTs', encodedData);
    return _userNFTs;
  }

  static Future fetchProfile(
      List<NFT> _userNFTs, String _walletAddress, String walletType) async {
    String url =
        "https://api.etherscan.io/api?module=account&action=balance&address=${_walletAddress}&tag=latest&apikey=8E3SY6IA38VWDESYM3V2E5IWM364BVGV3V";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var nftsJson = json.decode(response.body);
      var dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
      Profile.balance = double.parse(
          (double.parse(nftsJson['result']) * pow(10, -18)).toStringAsFixed(6));
      Profile.image = await getProfileImage(walletType);
      Profile.last_synched = dateFormat.format(DateTime.now());
      Profile.nfts_owned = _userNFTs.length;
      Profile.wallet_type = walletType;

      // String encodedData = Profile.encode(profile);
      // Helper.prefs.setString('profile', encodedData);
    }
  }

  static Future<String> getProfileImage(String walletType) async {
    String url =
        "https://api.coingecko.com/api/v3/coins/${walletType.toLowerCase()}";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var nftsJson = json.decode(response.body);
      return nftsJson['image']['large'];
    }
    return "";
  }
}