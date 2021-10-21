import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picture_of_the_day/providers.dart';
import 'package:picture_of_the_day/services/image_downloader.dart';

enum DownloadState {
  initial,
  running,
  success,
  failure,
}

class DownloadButton extends StatefulWidget {
  DownloadButton({
    Key? key,
    required this.darkBackground,
    required this.imgLink,
  }) : super(key: key);
  final bool darkBackground;
  final String imgLink;

  @override
  _DownloadButtonState createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  DownloadState _downloadState = DownloadState.initial;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Center(
        child: Consumer(
          builder: (context, watch, child) {
            final downloadedState = watch(downloadNotifierProvider.notifier);
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
                  return IconButton(
                    onPressed: null,
                    icon: Icon(Icons.download_done),
                  );
                }
                return IconButton(
                  icon: Icon(
                    Icons.download,
                    color: widget.imgLink.isEmpty
                        ? Theme.of(context).disabledColor
                        : widget.darkBackground
                            ? Colors.white
                            : Colors.black,
                  ),
                  onPressed: widget.imgLink.isEmpty
                      ? null
                      : () {
                          setState(() {
                            _downloadState = DownloadState.running;
                          });
                          downloadedState.setHasDownloaded();
                          downloadNetworkImage(widget.imgLink).then((result) {
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
