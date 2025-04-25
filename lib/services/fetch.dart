import 'package:flutter/cupertino.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photu/services/permission.dart';

class Fetch {
  static Future<List<AssetPathEntity>> getAssetPathEntity() async {
    try {
      await GetPermission.getPermission();
      return await PhotoManager.getAssetPathList();
    } catch (e) {
      debugPrint("Can't Fetch the data.: $e");
      return [];
    }
  }
}
