import 'package:photo_manager/photo_manager.dart';
import 'package:flutter/material.dart';

Future<void> deleteAsset(AssetEntity asset, var context) async {
  final permission = await PhotoManager.requestPermissionExtend();
  if (!permission.isAuth || !permission.hasAccess) {
    print("Permission not granted");
    PhotoManager.openSetting();
    return;
  }

  final result = await PhotoManager.editor.deleteWithIds([asset.id]);
  if (result.contains(asset)) {
    print("Deleted!");
    Navigator.pop(context); // or refresh your view
  } else {
    print("Failed to delete ${asset.title}");
  }
}

