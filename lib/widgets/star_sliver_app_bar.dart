import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:picture_of_the_day/widgets/app_bar_header_widget.dart';
import 'package:picture_of_the_day/widgets/bottom_icon_row.dart';

const _explanationFontSize = 16.0;

class StarSliverAppBar extends StatelessWidget {
  const StarSliverAppBar({
    Key? key,
    required this.screenHeight,
  }) : super(key: key);

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      actions: [IconButton(onPressed: (){print('woo hoo');}, icon: Icon(Icons.launch))],
      expandedHeight: screenHeight / 2.0,
      // bottom: PreferredSize(
      //   preferredSize: Size(double.infinity, _explanationFontSize * 3),
      //   child: BottomIconRow(),
      // ),
      flexibleSpace: FlexibleSpaceBar(
        background: AppBarHeaderWidget(),
      ),
    );
  }
}
