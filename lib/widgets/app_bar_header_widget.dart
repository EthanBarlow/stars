import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picture_of_the_day/FullScreenImagePage.dart';
import 'package:picture_of_the_day/application/star_notifier.dart';
import 'package:picture_of_the_day/infrastructure/models/Star.dart';
import 'package:picture_of_the_day/providers.dart';

class AppBarHeaderWidget extends StatelessWidget {
  AppBarHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final starState = watch(starNotifierProvider);
      starState as StarLoaded;
      Star star = starState.star;
      return GestureDetector(
        onTap: star.hasRestrictions
            ? null
            : () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          FullScreenImagePage(imageUrl: star.imgLink),
                    ),
                  )
                },
        child: !star.hasRestrictions
            ? Image.network(
                star.imgLink,
                fit: BoxFit.cover,
              )
            : Stack(
                fit: StackFit.expand,
                children: [
                  ImageFiltered(
                      imageFilter: ImageFilter.blur(
                        sigmaX: 20,
                        sigmaY: 20,
                      ),
                      child: Image.network(
                        star.imgLink,
                        fit: BoxFit.cover,
                      )),
                  Container(
                    color: Colors.white38,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.warning_rounded,
                          size: 64,
                          color: Colors.orange.shade400,
                        ),
                        SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 26.0),
                          child: Text(
                            'There seem to be copyright restrictions on this image... go to the APOD website to view the image',
                            style: TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      );
    });
  }
}
