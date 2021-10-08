import 'package:flutter/material.dart';
import 'package:picture_of_the_day/services/image_downloader.dart';

const _iconSize = 24.0;

class BottomIconRow extends StatelessWidget {
  const BottomIconRow({
    Key? key,
    required this.hasRestrictions,
    required this.imageLink,
  }) : super(key: key);

  final bool hasRestrictions;
  final String imageLink;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white54,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                Icons.calendar_today,
                size: _iconSize,
              ),
              onPressed: () {
                print('calendar');
              },
            ),
            IconButton(
              icon: Icon(Icons.share, size: _iconSize),
              onPressed: hasRestrictions
                  ? null
                  : () {
                      print('sharing');
                    },
            ),
            IconButton(
              icon: Icon(
                Icons.download_rounded,
                size: _iconSize,
              ),
              onPressed: hasRestrictions
                  ? null
                  : () {
                      downloadNetworkImage(imageLink).then((valid) {
                        if (valid) {
                          print('done downloading');
                        } else {
                          print('error downloading');
                        }
                        // print(file);
                      });
                      print('download');
                    },
            ),
          ],
        ),
      ),
    );
  }
}
