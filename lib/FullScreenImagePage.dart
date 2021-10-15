import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:picture_of_the_day/widgets/download_button.dart';

class FullScreenImagePage extends StatelessWidget {
  final String? imageUrl;

  FullScreenImagePage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [DownloadButton(darkBackground: true,)],
        ),
        extendBodyBehindAppBar: true,
        body: PhotoView(
          imageProvider: NetworkImage(imageUrl!),
        ),
      ),
    );
  }
}
