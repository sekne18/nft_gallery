import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nft_gallery/widgets/platforms_list.dart';

class PlatformPopupScreen extends StatelessWidget {
  const PlatformPopupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(35)),
              color: Theme.of(context).primaryColor == Colors.black
                  ? Colors.grey.shade900.withOpacity(0.8)
                  : Colors.white.withOpacity(0.8),
            ),
            width: MediaQuery.of(context).size.width - 20,
            height: 320,
            child: const Center(
              child: PlatformsList(),
            ),
          ),
        ),
      ),
    );
  }
}
