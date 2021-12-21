import 'dart:convert';

class NFT {
  String id;
  String name;
  String image;
  String creator;
  int total_supply;

  NFT({
    required this.id,
    required this.name,
    required this.image,
    required this.creator,
    required this.total_supply,
  });

  factory NFT.fromJson(Map<String, dynamic> jsonData) {
    return NFT(
      id: jsonData['fingerprint'],
      name: jsonData['name'],
      image: jsonData['image'],
      creator: jsonData['creator'],
      total_supply: jsonData['total_supply'],
    );
  }

  static Map<String, dynamic> toMap(NFT nft) => {
        'fingerprint': nft.id,
        'name': nft.name,
        'total_supply': nft.total_supply,
        'creator': nft.creator,
        'image': nft.image,
      };

  static String encode(List<NFT> nfts) => json.encode(
        nfts.map<Map<String, dynamic>>((nft) => NFT.toMap(nft)).toList(),
      );

  static List<NFT> decode(String nfts) => (json.decode(nfts) as List<dynamic>)
      .map<NFT>((item) => NFT.fromJson(item))
      .toList();
}
