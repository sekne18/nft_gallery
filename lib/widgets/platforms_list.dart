import 'package:flutter/material.dart';
import 'package:nft_gallery/helpers/helper.dart';

class PlatformsList extends StatelessWidget {
  const PlatformsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20, bottom: 20),
          child: Text(
            "Choose platform:",
            style: TextStyle(
              color: Theme.of(context).primaryColor == Colors.black
                  ? Colors.white
                  : Colors.grey.shade900,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextButton(
          style: Helper.walletType == "Ethereum"
              ? ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).primaryColor == Colors.black
                        ? Colors.white.withOpacity(0.25)
                        : Colors.grey.shade900.withOpacity(0.25),
                  ),
                )
              : ButtonStyle(),
          onPressed: () {
            Helper.walletType = "Ethereum";
            Navigator.of(context).pop();
          },
          child: Text(
            "Ethereum",
            style: TextStyle(
              color: Theme.of(context).primaryColor == Colors.black
                  ? Colors.white
                  : Colors.grey.shade900,
              fontSize: 19,
            ),
          ),
        ),
        TextButton(
          style: Helper.walletType == "Cardano"
              ? ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).primaryColor == Colors.black
                        ? Colors.white.withOpacity(0.25)
                        : Colors.grey.shade900.withOpacity(0.25),
                  ),
                )
              : ButtonStyle(),
          onPressed: () {
            Helper.walletType = "Cardano";
            Navigator.of(context).pop();
          },
          child: Text(
            "Cardano",
            style: TextStyle(
              color: Theme.of(context).primaryColor == Colors.black
                  ? Colors.white
                  : Colors.grey.shade900,
              fontSize: 19,
            ),
          ),
        ),
        TextButton(
          style: Helper.walletType == "Solana"
              ? ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).primaryColor == Colors.black
                        ? Colors.white.withOpacity(0.25)
                        : Colors.grey.shade900.withOpacity(0.25),
                  ),
                )
              : ButtonStyle(),
          onPressed: () {
            Helper.walletType = "Solana";
            Navigator.of(context).pop();
          },
          child: Text(
            "Solana",
            style: TextStyle(
              color: Theme.of(context).primaryColor == Colors.black
                  ? Colors.white
                  : Colors.grey.shade900,
              fontSize: 19,
            ),
          ),
        ),
        TextButton(
          style: Helper.walletType == "Avalanche"
              ? ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).primaryColor == Colors.black
                        ? Colors.white.withOpacity(0.25)
                        : Colors.grey.shade900.withOpacity(0.25),
                  ),
                )
              : ButtonStyle(),
          onPressed: () {
            Helper.walletType = "Avalanche";
            Navigator.of(context).pop();
          },
          child: Text(
            "Avalanche",
            style: TextStyle(
              color: Theme.of(context).primaryColor == Colors.black
                  ? Colors.white
                  : Colors.grey.shade900,
              fontSize: 19,
            ),
          ),
        ),
        TextButton(
          style: Helper.walletType == "Polygon"
              ? ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).primaryColor == Colors.black
                        ? Colors.white.withOpacity(0.25)
                        : Colors.grey.shade900.withOpacity(0.25),
                  ),
                )
              : ButtonStyle(),
          onPressed: () {
            Helper.walletType = "Polygon";
            Navigator.of(context).pop();
          },
          child: Text(
            "Polygon",
            style: TextStyle(
              color: Theme.of(context).primaryColor == Colors.black
                  ? Colors.white
                  : Colors.grey.shade900,
              fontSize: 19,
            ),
          ),
        ),
      ],
    );
  }
}
