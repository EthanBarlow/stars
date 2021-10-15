
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picture_of_the_day/Api.dart';
import 'package:picture_of_the_day/application/star_notifier.dart';
import 'package:picture_of_the_day/infrastructure/models/Star.dart';
import 'package:picture_of_the_day/providers.dart';
import 'package:picture_of_the_day/widgets/app_bar_header_widget.dart';
import 'package:url_launcher/url_launcher.dart';

const _explanationFontSize = 16.0;

class StarSliverAppBar extends StatelessWidget {
  const StarSliverAppBar({
    Key? key,
    required this.screenHeight,
  }) : super(key: key);

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final starState = watch(starNotifierProvider);
      starState as StarLoaded;
      Star star = starState.star;
      return SliverAppBar(
        backgroundColor: Colors.amber[100],
        actions: [
          IconButton(
            onPressed: () async {
              print('woo hoo');
              String _url = ApiHelper.deriveApodLink(star.returnedDate);
              if (await canLaunch(_url)) {
                print('able to launch!!!');
                await launch(
                  _url,
                  forceWebView: true,
                  forceSafariVC: true,
                  enableJavaScript: true,
                );
              } else {
                print('unable to launch <<<>>>');
              }
            },
            icon: Icon(
              Icons.launch,
              color: Colors.white,
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
            onPressed: () {
              print('how may I be of assistance?');
            },
          )
        ],
        expandedHeight: screenHeight / 2.0,
        // bottom: PreferredSize(
        //   preferredSize: Size(double.infinity, _explanationFontSize * 3),
        //   child: BottomIconRow(),
        // ),
        flexibleSpace: FlexibleSpaceBar(
          background: AppBarHeaderWidget(
            star: star,
          ),
        ),
      );
    });
  }
}

class AppBarHeaderWidget extends StatelessWidget {
  final Star star;
  AppBarHeaderWidget({
    Key? key,
    required this.star,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final starState = watch(starNotifierProvider);
      starState as StarLoaded;
      Star star = starState.star;
      // return Placeholder();

      return star.mediaType.contains('image')
          ? ImageWidget(star: star)
          : VideoWidget(star: star);
    });
  }
}
