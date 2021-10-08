import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:picture_of_the_day/FullScreenImagePage.dart';
import 'package:picture_of_the_day/widgets/app_bar_header_widget.dart';
import 'package:picture_of_the_day/widgets/bottom_icon_row.dart';

const _explanationFontSize = 16.0;

class StarSliverAppBar extends StatelessWidget {
  const StarSliverAppBar({
    Key? key,
    required this.screenHeight,
    required this.hasRestrictions,
    required this.imageLink,
  }) : super(key: key);

  final double screenHeight;
  final bool hasRestrictions;
  final String imageLink;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: screenHeight / 2.0,
      bottom: PreferredSize(
        preferredSize: Size(double.infinity, _explanationFontSize * 3),
        child: BottomIconRow(
            hasRestrictions: hasRestrictions, imageLink: imageLink),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: AppBarHeaderWidget(
          hasRestrictions: hasRestrictions,
          imageLink: imageLink,
        ),
      ),
    );
  }
}
