import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:picture_of_the_day/FullScreenImagePage.dart';

class AppBarHeaderWidget extends StatelessWidget {
  final bool hasRestrictions;
  final String imageLink;

  AppBarHeaderWidget(
      {Key? key, required this.hasRestrictions, required this.imageLink})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hasRestrictions
          ? null
          : () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        FullScreenImagePage(imageUrl: imageLink),
                  ),
                )
              },
      child: !hasRestrictions
          ? Image.network(
              imageLink,
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
                      imageLink,
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
  }
}
