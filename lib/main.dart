import 'package:flutter/material.dart';

import 'package:testapp/slide_transition.dart';
import 'package:testapp/splacescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My First App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: SlideRightTransitionBuilder(),
            TargetPlatform.iOS: SlideRightTransitionBuilder(),
          },
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
