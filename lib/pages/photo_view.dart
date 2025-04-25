import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photu/services/share.dart';
import 'package:photu/services/delete.dart';

class PhotoViewPage extends StatefulWidget {
  const PhotoViewPage({
    super.key,
    required this.rawPhoto,
    required this.snapshot,
  });

  final AssetEntity rawPhoto;
  final AsyncSnapshot<Uint8List?> snapshot;

  @override
  State<PhotoViewPage> createState() => _PhotoViewPageState();
}

class _PhotoViewPageState extends State<PhotoViewPage> {
  File? file;
  Uint8List? imageSnap;

  Future<void> _needToDo() async {
    file = await widget.rawPhoto.originFile;
    imageSnap = await file!.readAsBytes();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _needToDo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: Center(
        child:
            imageSnap == null
                ? const CircularProgressIndicator()
                : SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: PhotoView(
                    imageProvider: MemoryImage(imageSnap!),
                    backgroundDecoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                  ),
                ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 100,
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () async {
                  await shareImage(file!);
                },
                icon: Icon(Icons.share, color: Colors.white),
              ),
              IconButton(
                onPressed: () async {
                  deleteAsset(widget.rawPhoto, context);
                },
                icon: Icon(Icons.delete, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
