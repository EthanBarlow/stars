import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picture_of_the_day/application/star_notifier.dart';
import 'package:picture_of_the_day/constants.dart';
import 'package:picture_of_the_day/infrastructure/models/Star.dart';
import 'package:picture_of_the_day/providers.dart';
import 'package:picture_of_the_day/services/image_downloader.dart';
import 'package:picture_of_the_day/star_exception.dart';
import 'package:picture_of_the_day/widgets/download_button.dart';

const _iconSize = 24.0;

class BottomIconRow extends StatefulWidget {
  const BottomIconRow({Key? key}) : super(key: key);

  @override
  State<BottomIconRow> createState() => _BottomIconRowState();
}

class _BottomIconRowState extends State<BottomIconRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black45,
              offset: Offset(0, 3.0),
              blurRadius: 3.0,
              spreadRadius: 2)
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Consumer(builder: (context, watch, child) {
          final starState = watch(starNotifierProvider);
          final notifier = watch(starNotifierProvider.notifier);
          final bool isError = starState is StarError;
          Star star;
          DateTime returnedDate = DateTime.now();
          String imgLink = '';
          if (!isError) {
            starState as StarLoaded;
            star = starState.star;
            imgLink = star.imgLink;
            returnedDate = star.returnedDate;
          }
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
                    Future<DateTime?> selectedDate = showDatePicker(
                      context: context,
                      initialDate: returnedDate,
                      firstDate: DateTime.parse(earliestDate),
                      lastDate: DateTime.now(),
                    );
                    selectedDate.then((datetime) {
                      // if datetime == null, the user canceled the dialog
                      if (datetime != null && datetime != returnedDate) {
                        try {
                          notifier.getStarData(datetime);
                        } on StarException {
                          return;
                        }
                        context
                            .read(downloadNotifierProvider.notifier)
                            .setHasNotDownloaded();
                      }
                    });
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: Icon(
                    Icons.share,
                    size: _iconSize,
                  ),
                  onPressed: isError
                      ? null
                      : () async {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return Center(
                                    child: CircularProgressIndicator());
                              });
                          await shareNetworkImage(imgLink);
                          Navigator.pop(context);
                        },
                ),
              ),
              Expanded(
                flex: 1,
                child: DownloadButton(
                  darkBackground: false,
                  imgLink: imgLink,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
