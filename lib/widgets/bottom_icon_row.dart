import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picture_of_the_day/application/star_notifier.dart';
import 'package:picture_of_the_day/infrastructure/models/Star.dart';
import 'package:picture_of_the_day/providers.dart';
import 'package:picture_of_the_day/widgets/download_button.dart';

const _iconSize = 24.0;

class BottomIconRow extends StatelessWidget {
  const BottomIconRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white54,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Consumer(builder: (context, watch, child) {
          final starState = watch(starNotifierProvider);
          starState as StarLoaded;
          Star star = starState.star;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: Icon(
                    Icons.calendar_today,
                    size: _iconSize,
                  ),
                  onPressed: () {
                    print('calendar');
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: Icon(Icons.share, size: _iconSize),
                  onPressed: star.hasRestrictions
                      ? null
                      : () {
                          print('sharing');
                        },
                ),
              ),
              Expanded(
                flex: 1,
                child: DownloadButton(
                  imageLink: star.imgLink,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
