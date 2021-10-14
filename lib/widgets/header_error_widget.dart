import 'dart:ui';

import 'package:flutter/material.dart';

class HeaderErrorWidget extends StatelessWidget {
  final String imageLink;
  const HeaderErrorWidget({Key? key, required this.imageLink})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
          ),
        ),
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
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 26.0),
                child: Text(
                  'There seems to be an issue with this media... try visiting the astronomy picture of the day website by tapping the button in the upper right corner',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
