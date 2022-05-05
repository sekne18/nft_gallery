import 'package:http/http.dart' as http;

class Helper {
  static String address = "0x54b174179ae825ed630da40b625bb3c883cd40ae";
  static String walletType = "Ethereum";

  static const String imagesKey = "nft_images";

  static Future<bool> validUrl(String address) async {
    String url =
        "https://api.opensea.io/api/v1/assets?&owner=${address}&format=json";
    var response = await http.get(Uri.parse(url));
    return response.statusCode == 200 ? true : false;
  }
}
