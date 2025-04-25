import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_manager/photo_manager.dart';

import '../services/fetch.dart';
import '../services/permission.dart';
import 'init_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 5),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(paths: paths, media: media),
        ),
      ),
    );
    _initWorks();
  }

  Future<void> _initWorks() async {
    GetPermission.getPermission();
    paths = await Fetch.getAssetPathEntity();
    media = await Future.wait(
      paths.map((path) => path.getAssetListPaged(page: 0, size: 100)),
    );
  }

  List<AssetPathEntity> paths = [];
  List<List<AssetEntity>> media = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Text(
          'Just Another Gallery!',
          style: GoogleFonts.italianno(fontSize: 30),
        ),
      ),
    );
  }
}
