import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class NFT {
  String id;
  String name;
  String image;
  int total_supply;
  String description;

  NFT({
    required this.id,
    required this.name,
    required this.image,
    required this.total_supply,
    required this.description,
  });

  factory NFT.fromJson(Map<String, dynamic> jsonData) {
    return NFT(
      id: jsonData['fingerprint'],
      name: jsonData['name'],
      image: jsonData['image'],
      total_supply: jsonData['total_supply'],
      description: jsonData['description'],
    );
  }

  static Map<String, dynamic> toMap(NFT nft) => {
        'fingerprint': nft.id,
        'name': nft.name,
        'total_supply': nft.total_supply,
        'image': nft.image,
        'description': nft.description,
      };

  static String encode(List<NFT> nfts) => json.encode(
        nfts.map<Map<String, dynamic>>((nft) => NFT.toMap(nft)).toList(),
      );

  static List<NFT> decode(String nfts) => (json.decode(nfts) as List<dynamic>)
      .map<NFT>((item) => NFT.fromJson(item))
      .toList();

  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }
}
