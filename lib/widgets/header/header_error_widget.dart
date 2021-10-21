import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:picture_of_the_day/constants.dart';

class HeaderErrorWidget extends StatelessWidget {
  final String errorText;
  final String imageLink;
  const HeaderErrorWidget({
    Key? key,
    required this.imageLink,
    this.errorText = '',
  }) : super(key: key);

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
                  errorText.isNotEmpty ? errorText : problemMedia,
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
