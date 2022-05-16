import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:nft_gallery/models/nft.dart';
import 'package:nft_gallery/models/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EthAPI {
  static Future<List<NFT>> fetchNFTs(
      List<NFT> _userNFTs, String _walletAddress) async {
    _userNFTs = [];
    int i = 0;
    String url =
        "https://eth-mainnet.alchemyapi.io/v2/demo/getNFTs/?owner=${_walletAddress}";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var nftsJson = json.decode(response.body);
      nftsJson = nftsJson["ownedNfts"].length > 50 ? nftsJson["ownedNfts"].sublist(0,12) : nftsJson["ownedNfts"];
      for (var nft in nftsJson) {
            try {
              String url = nft['metadata']["image"];
              if (url.contains("ipfs://")) {
                url = url.replaceAll("ipfs://", "https://ipfs.moralis.io:2053/ipfs/");
              }
              http.Response res = await http.get(
                Uri.parse(url),
              );

              _userNFTs.add(
                NFT(
                  id: i.toString(),
                  image: NFT.base64String(res.bodyBytes),
                  name: nft['metadata']["name"].toString() ?? "Unknown",
                  total_supply: int.parse(nft['balance']) ?? 1,
                  description: nft['description'] ?? "",
                ),
              );
              i++;
            } catch (e) {
              _userNFTs.add(
                NFT(
                  id: i.toString(),
                  image: NFT.base64String(
                      (await rootBundle.load('assets/images/noimage.png')).buffer.asUint8List()),
                  name: nft['metadata']["name"].toString() ?? "Unknown",
                  total_supply: nft['balance'] != null ? int.parse(nft['balance']) : 1,
                  description: nft['description'] ?? "",
                ),
              );
              i++;
            }

      }
    }
    String encodedData = NFT.encode(_userNFTs);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('listOfNFTs', encodedData);
    return _userNFTs;
  }

  static Future<List<NFT>> searchNFTs(
      List<NFT> _userNFTs, String _walletAddress) async {
    _userNFTs = [];
    int i = 0;
    String url =
        "https://eth-mainnet.alchemyapi.io/v2/demo/getNFTs/?owner=${_walletAddress}";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var nftsJson = json.decode(response.body);
      for (var nft in nftsJson['assets']) {
        if (nft['image_url'] != "") {
          http.Response res = await http.get(
            Uri.parse(nft['image_url']),
          );
          _userNFTs.add(
            NFT(
              id: nft['id'].toString(),
              image: NFT.base64String(res.bodyBytes),
              name: nft['metadata']["name"].toString(),
              total_supply: nft['balance'],
              description: nft['description'],
            ),
          );
          i++;
        }
      }
    }
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
