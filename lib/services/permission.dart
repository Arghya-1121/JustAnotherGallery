import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

class GetPermission {
  static Future<bool> getPermission() async {
    try {
      Map<Permission, PermissionStatus> statuses =
          await [Permission.photos, Permission.videos].request();
      // if (!(await Permission.photos.status.isDenied)||!(await Permission.videos.status.isDenied)) {
      //
      // }

      if (statuses[Permission.photos]?.isPermanentlyDenied == true ||
          statuses[Permission.videos]?.isPermanentlyDenied == true) {
        await openAppSettings();
        return false;
      }

      // Check if granted
      if (statuses[Permission.photos]?.isGranted == true ||
          statuses[Permission.videos]?.isGranted == true) {
        return true;
      }

      return false;
    } catch (e) {
      debugPrint("Permission Error: $e");
      return false;
    }
  }
}
