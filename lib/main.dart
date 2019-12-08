import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:digital_wallet/provider_models/theme_provider.dart';
import 'package:digital_wallet/services/Login.dart';
import 'package:digital_wallet/services/signup.dart';

import 'homepage.dart';

Future<void> main() async {
  runApp(
    ChangeNotifierProvider(
      builder: (_) => ThemeProvider(isLightTheme: true),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      routes: {
        Login.id: (context) => Login(),
        SignUp.id: (context) => SignUp(),
        HomePage.id: (context) => HomePage(),
      },
      debugShowMaterialGrid: false,
      title: 'digital_wallet',
      theme: themeProvider.getThemeData,
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}