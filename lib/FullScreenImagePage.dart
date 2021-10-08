import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImagePage extends StatelessWidget {
  final String? imageUrl;

  FullScreenImagePage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.download_rounded),
              onPressed: () => {
                print('downloading from fullscreen'),
              },
            ),
          ],
        ),
        extendBodyBehindAppBar: true,
        body: PhotoView(
          imageProvider: NetworkImage(imageUrl!),
        ),
      ),
    );
  }
}
