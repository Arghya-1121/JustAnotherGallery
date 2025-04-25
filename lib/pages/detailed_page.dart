import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photu/pages/photo_view.dart';

class ImageView extends StatelessWidget {
  final List<AssetEntity> media;
  final String albumName;

  const ImageView({super.key, required this.media, required this.albumName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          albumName,
          style: GoogleFonts.italianno(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemCount: media.length,
        itemBuilder: (context, index) {
          return FutureBuilder<Uint8List?>(
            future: media[index].thumbnailDataWithSize(
              const ThumbnailSize(200, 200),
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                );
              } else if (snapshot.hasData && snapshot.data != null) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Hero(
                    tag: "photu",
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => PhotoViewPage(
                                  rawPhoto: media[index],
                                  snapshot: snapshot,
                                ),
                          ),
                        );
                      },
                      child: Image.memory(snapshot.data!, fit: BoxFit.cover),
                    ),
                  ),
                );
              } else {
                return const Icon(Icons.broken_image);
              }
            },
          );
        },
      ),
    );
  }
}
