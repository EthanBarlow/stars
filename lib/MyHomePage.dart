import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:picture_of_the_day/application/download_notifier.dart';
import 'package:picture_of_the_day/application/star_notifier.dart';
import 'package:picture_of_the_day/constants.dart';
import 'package:picture_of_the_day/providers.dart';
import 'package:picture_of_the_day/star_exception.dart';
import 'package:picture_of_the_day/widgets/bottom_icon_row.dart';
import 'package:picture_of_the_day/widgets/header/star_sliver_app_bar.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

const _dateFontSize = 30.0;
const _textInset = 20.0;
const _explanationFontSize = 16.0;

class _MyHomePageState extends State<MyHomePage> {
  late final UserDownloadStateNotifier userDownloadStateNotifier;
  late final StarNotifier starNotifier;

  @override
  void initState() {
    super.initState();
    starNotifier = context.read(starNotifierProvider.notifier);
    userDownloadStateNotifier = context.read(downloadNotifierProvider.notifier);
    try {
      starNotifier.getStarData(DateTime.now());
    } on StarException catch (se) {
      // Any StarExceptions thrown should be caught further down the call tree
      // This is here just in case
      if (se.code == StarExceptionCode.rateLimitReached) {
      }
      return;
    }
    userDownloadStateNotifier.setHasNotDownloaded();
    userDownloadStateNotifier.addListener((state) {
      // used to update the download icon after returning from the full screen page view
      if (userDownloadStateNotifier.mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    userDownloadStateNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Consumer(builder: (context, watch, child) {
          final starState = watch(starNotifierProvider);
          if (starState is StarInitial) {
            return Center(child: Text('initial state'));
          } else if (starState is StarLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (starState is StarError) {
            return MainView(
              screenHeight: screenHeight,
              returnedDate: earliestDateTime.subtract(Duration(days: 1)),
              explanation: starState.message.compareTo(rateLimitMessage) == 0 ? rateLimitTechMessage : starState.message,
            );
          } else if (starState is StarLoaded) {
            return MainView(
              screenHeight: screenHeight,
              title: starState.star.title,
              copyright: starState.star.copyright,
              returnedDate: starState.star.returnedDate,
              explanation: starState.star.explanation,
            );
          } else {
            return Center(child: Text('how... what... how?'));
          }
        }),
      ),
    );
  }
}

class MainView extends StatelessWidget {
  const MainView({
    Key? key,
    required this.screenHeight,
    required this.returnedDate,
    this.title = '',
    this.copyright = '',
    this.explanation = '',
    // required this.starState,
  }) : super(key: key);

  final double screenHeight;
  final String title;
  final String copyright;
  final DateTime returnedDate;
  final String explanation;
  // final StarState starState;

  @override
  Widget build(BuildContext context) {
    bool isInErrorState = returnedDate.isBefore(earliestDateTime);
    return CustomScrollView(slivers: [
      StarSliverAppBar(
        screenHeight: screenHeight,
        returnedDate: returnedDate,
      ),
      SliverToBoxAdapter(
        child: PreferredSize(
          preferredSize: Size(double.infinity, _explanationFontSize * 3),
          child: BottomIconRow(),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(
              bottom: _textInset, left: _textInset, right: _textInset),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isInErrorState)
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: _dateFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              if (!isInErrorState && copyright.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    'Credits: $copyright',
                    style: TextStyle(fontSize: 14.0),
                  ),
                ),
              if (!isInErrorState)
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    DateFormat.yMMMd().format(returnedDate),
                    style: TextStyle(fontSize: _dateFontSize / 1.2),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  explanation,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
