import 'package:flutter/material.dart';
import 'package:nft_gallery/provider/theme_provider.dart';
import 'package:nft_gallery/screens/nft_details_screen.dart';
import 'package:provider/provider.dart';
import 'screens/collection_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/search_screen.dart';
import 'screens/tab_screen.dart';

void main() {
  runApp(const NFTGallery());
}

class NFTGallery extends StatelessWidget {
  const NFTGallery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (BuildContext context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            title: 'NFT Gallery',
            themeMode: themeProvider.themeMode,
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            initialRoute: '/',
            routes: {
              '/': (context) => const TabScreen(),
              '/collection': (context) => const CollectionScreen(),
              '/search': (context) => const SearchScreen(),
              '/profile': (context) => const ProfileScreen(),
            },
          );
        },
      );
}
