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
  DownloadButton({Key? key, required this.darkBackground}) : super(key: key);
  final bool darkBackground;

  @override
  _DownloadButtonState createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  DownloadState _downloadState = DownloadState.initial;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Consumer(
          builder: (context, watch, child) {
            final starState = watch(starNotifierProvider);
            final downloadedState = watch(downloadNotifierProvider.notifier);
            starState as StarLoaded;
            switch (_downloadState) {
              case DownloadState.running:
                return Container(
                    width: 24.0,
                    height: 24.0,
                    child: CircularProgressIndicator(
                      color: widget.darkBackground
                          ? Colors.amber[100]
                          : Colors.amber[800],
                    ));
              case DownloadState.success:
                return Icon(Icons.download_done);
              case DownloadState.failure:
                return Icon(Icons.file_download_off);
              case DownloadState.initial:
                if (downloadedState.hasDownloaded) {
                  return Icon(Icons.download_done);
                }
                return InkResponse(
                  child: Icon(Icons.download),
                  onTap: () {
                    setState(() {
                      _downloadState = DownloadState.running;
                    });
                    downloadedState.setHasDownloaded();
                    downloadNetworkImage(starState.star.imgLink).then((result) {
                      if (!mounted) return;
                      setState(() {
                        _downloadState = result
                            ? DownloadState.success
                            : DownloadState.failure;
                      });
                    });
                  },
                );
            }
          },
        ),
      ),
    );
  }
}
