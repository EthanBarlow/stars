import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:picture_of_the_day/Api.dart';
import 'package:picture_of_the_day/application/star_notifier.dart';
import 'package:picture_of_the_day/infrastructure/models/Star.dart';
import 'package:picture_of_the_day/providers.dart';
import 'package:picture_of_the_day/widgets/header/app_bar_header_widget.dart';
import 'package:picture_of_the_day/widgets/custom_about_dialog.dart';
import 'package:picture_of_the_day/widgets/header/header_error_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:picture_of_the_day/constants.dart';

class StarSliverAppBar extends StatelessWidget {
  StarSliverAppBar({
    Key? key,
    required this.screenHeight,
    required this.returnedDate,
  }) : super(key: key);

  final DateTime returnedDate;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    bool isInErrorState = returnedDate.isBefore(earliestDateTime);

    return SliverAppBar(
      backgroundColor: Colors.amber[100],
      actions: [
        IconButton(
          onPressed: isInErrorState
              ? null
              : () async {
                  String _url = ApiHelper.deriveApodLink(returnedDate);
                  if (await canLaunch(_url)) {
                    await launch(
                      _url,
                      forceWebView: true,
                      forceSafariVC: true,
                      enableJavaScript: true,
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(errorLaunch),
                        );
                      },
                    );
                  }
                },
          icon: Icon(
            Icons.launch,
            color:
                isInErrorState ? Theme.of(context).disabledColor : Colors.white,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        IconButton(
          icon: Icon(
            Icons.help_outline,
            color: Colors.white,
          ),
          onPressed: () async {
            // showLicensePage(context: context);
            PackageInfo packageInfo = await PackageInfo.fromPlatform();
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomAboutDialog(packageInfo: packageInfo);
                });
          },
        )
      ],
      expandedHeight: screenHeight / 2.0,
      flexibleSpace: FlexibleSpaceBar(
        background: AppBarHeaderWidget(),
      ),
    );
  }
}

class AppBarHeaderWidget extends StatelessWidget {
  AppBarHeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final starState =
          ref.watch(starNotifierProvider.select((value) => value.state));
      if (starState is StarLoaded) {
        Star star = starState.star;

        return star.mediaType.contains('image')
            ? ImageWidget(star: star)
            : VideoWidget(star: star);
      } else if (starState is StarError) {
        return HeaderErrorWidget(
          imageLink:
              'https://apod.nasa.gov/apod/image/1610/m33_brc_lrgb_ha_hiresPivato.jpg',
          errorText: starState.message,
        );
      } else {
        return HeaderErrorWidget(
          imageLink:
              'https://apod.nasa.gov/apod/image/1610/m33_brc_lrgb_ha_hiresPivato.jpg',
          errorText: 'unknown error',
        );
      }
    });
  }
}
