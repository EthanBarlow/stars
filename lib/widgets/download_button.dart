import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picture_of_the_day/application/star_notifier.dart';
import 'package:picture_of_the_day/providers.dart';
import 'package:picture_of_the_day/services/image_downloader.dart';

enum DownloadState {
  initial,
  running,
  success,
  failure,
}

class DownloadButton extends StatefulWidget {
  DownloadButton({Key? key, required this.imageLink}) : super(key: key);
  // final DownloadState _downloadState = DownloadState.initial;
  final String imageLink;

  @override
  _DownloadButtonState createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  // late Future<bool> result;
  DownloadState _downloadState = DownloadState.initial;
  @override
  Widget build(BuildContext context) {
    switch (_downloadState) {
      case DownloadState.running:
        return Center(
            child: Container(
                width: 24.0, height: 24.0, child: CircularProgressIndicator()));
      case DownloadState.success:
        return Icon(Icons.download_done);
      case DownloadState.failure:
        return Icon(Icons.file_download_off);
      case DownloadState.initial:
        return Consumer(builder: (context, watch, child) {
          final starState = watch(starNotifierProvider);
          starState as StarLoaded;
          if (starState.star.userSaved) {
            return Icon(Icons.download_done);
          }
          return IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              setState(() {
                _downloadState = DownloadState.running;
              });
              downloadNetworkImage(widget.imageLink).then((result) {
                setState(() {
                  if (result) {
                    starState.star.userSaved = true;
                  }
                  _downloadState =
                      result ? DownloadState.success : DownloadState.failure;
                });
              });
            },
          );
        });
      // break;

    }
  }
}
