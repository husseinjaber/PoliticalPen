import 'package:flutter/material.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'DynamicLinkk/DynamicLinkService.dart';
import 'locator.dart';
import 'pages/HomePage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(MyApp());
}



class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Political Pen',
      home: SplashScreen(
        'assets/Splash.flr',
        HomePage(),
        startAnimation: 'intro',
        backgroundColor: Color(0xffFFFFFF),
      ),
    );
  }
}
