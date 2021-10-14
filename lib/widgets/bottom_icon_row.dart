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
      decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow( color: Colors.black45, offset: Offset(0, 3.0), blurRadius: 3.0, spreadRadius: 2)]),
      // color: Colors.white54,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Consumer(builder: (context, watch, child) {
          final starState = watch(starNotifierProvider);
          final notifier = watch(starNotifierProvider.notifier);
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
                    Future<DateTime?> selectedDate = showDatePicker(
                      context: context,
                      initialDate: star.returnedDate,
                      firstDate: DateTime.parse('1995-06-16'),
                      lastDate: DateTime.now(),
                    );
                    selectedDate.then((datetime) {
                      print('datetime');
                      print(datetime);
                      // if datetime == null, the user canceled the dialog
                      if (datetime != null && datetime != star.returnedDate) {
                        notifier.getStarData(datetime);
                        context.read(downloadNotifierProvider.notifier).setHasNotDownloaded();
                      }
                    });
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
                child: DownloadButton(darkBackground: false,),
              ),
            ],
          );
        }),
      ),
    );
  }
}
