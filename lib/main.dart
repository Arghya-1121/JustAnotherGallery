import 'package:flutter/material.dart';
import 'package:photu/pages/splash.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    home: SplashScreen(),
    debugShowCheckedModeBanner: false,
    title: "The OG Photo Gallery",
  );
}
