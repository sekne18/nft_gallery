import 'package:http/http.dart' as http;

class Helper {
  static String address = "0x931d1156B4C2f95B21D61f129D1e1B640bB30932";
  static String walletType = "Ethereum";

  static const String imagesKey = "nft_images";

  static Future<bool> validUrl(String address) async {
    String url =
        "https://eth-mainnet.alchemyapi.io/v2/demo/getNFTs/?owner=${address}";
    var response = await http.get(Uri.parse(url));
    return response.statusCode == 200 ? true : false;
  }
}
