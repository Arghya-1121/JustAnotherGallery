import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:share_plus/share_plus.dart';

Future<void> shareImage(File imageFile) async {
  try {
    //await Share.downloadFallbackEnabled([imageFile.path], mimeTypes: ['image/*']);
    final params = ShareParams(files: [XFile(imageFile.path)]);
    await SharePlus.instance.share(params);
  } catch (e) {
    debugPrint('Error sharing image: $e');
  }
}
