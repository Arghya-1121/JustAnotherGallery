import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photu/pages/detailed_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.paths, required this.media});

  final List<AssetPathEntity> paths;
  final List<List<AssetEntity>> media;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool? p;
  bool? v;

  @override
  void initState() {
    super.initState();
    _needToDo();
    print(widget.paths);
  }

  Future<void> _needToDo() async {
    p = await Permission.photos.status.isGranted;
    v = await Permission.videos.status.isGranted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Just Another Gallery!',
          style: GoogleFonts.italianno(
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
        centerTitle: true,
        elevation: 3,
        shadowColor: Colors.grey.shade700,
      ),
      body: SizedBox(
        width: double.infinity,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 5.0,
            crossAxisSpacing: 5.0,
          ),
          itemCount: widget.paths.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => ImageView(
                          media: widget.media[index],
                          albumName: widget.paths[index].name,
                        ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    style: BorderStyle.solid,
                    color: Colors.cyanAccent,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.cyanAccent,
                ),
                child: Center(
                  child: Text(
                    widget.paths[index].name,
                    style: GoogleFonts.redRose(),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
