import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:picture_of_the_day/FullScreenImagePage.dart';
import 'package:picture_of_the_day/infrastructure/models/Star.dart';
import 'package:picture_of_the_day/widgets/header/header_error_widget.dart';
// import 'package:youtube_player_iframe/youtube_player_iframe.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({Key? key, required this.star}) : super(key: key);
  final Star star;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FullScreenImagePage(imageUrl: star.imgLink),
          ),
        )
      },
      child: Image.network(
        star.imgLink,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return LoadingBouncingGrid.circle(
            size: 100,
            backgroundColor: Color(0xFF4FB2E7),
            inverted: true,
          );
        },
      ),
    );
  }
}

class VideoWidget extends StatefulWidget {
  const VideoWidget({Key? key, required this.star}) : super(key: key);
  final Star star;

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HeaderErrorWidget(
      imageLink:
          'https://apod.nasa.gov/apod/image/1610/m33_brc_lrgb_ha_hiresPivato.jpg',
    );
  }
}
/* class _VideoWidgetState extends State<VideoWidget> {
  late YoutubePlayerController _controller;
  late PlayerState _playerState;
  bool _isPlayerReady = false;
  String? videoId;
  @override
  void initState() {
    super.initState();
    videoId = YoutubePlayerController.convertUrlToId(widget.star.imgLink);
    if (videoId != null) {
      _controller = YoutubePlayerController.fromVideoId(
        videoId: videoId ?? 'S5aK3TIOnIw',
        autoPlay: false,
        params: const YoutubePlayerParams(
          mute: false,
          loop: false,
          enableCaption: true,
        ),
      );

      _playerState = PlayerState.unknown;
    }
  }

  void listener() {
    if (_isPlayerReady && mounted) {
      setState(() {
        _playerState = _controller.value.playerState;
      });
    }
  }

  @override
  void deactivate() {
    _controller.pauseVideo();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return videoId != null
        ? YoutubePlayer(
            controller: _controller,
          )
        : HeaderErrorWidget(
            imageLink:
                'https://apod.nasa.gov/apod/image/1610/m33_brc_lrgb_ha_hiresPivato.jpg',
          );
  }
} */
/* class VideoWidget extends StatefulWidget {
  const VideoWidget({Key? key, required this.star}) : super(key: key);
  final Star star;

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late YoutubePlayerController _controller;
  late PlayerState _playerState;
  bool _isPlayerReady = false;
  String? videoId;
  @override
  void initState() {
    super.initState();
    videoId = YoutubePlayer.convertUrlToId(widget.star.imgLink);
    if (videoId != null) {
      _controller = YoutubePlayerController(
        initialVideoId: videoId ?? 'S5aK3TIOnIw',
        flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: false,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHD: false,
          enableCaption: true,
        ),
      )..addListener(listener);
      _playerState = PlayerState.unknown;
    }
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
      });
    }
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return videoId != null
        ? YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              onReady: () {
                _isPlayerReady = true;
              },
            ),
            builder: (context, player) => player,
          )
        : HeaderErrorWidget(
            imageLink:
                'https://apod.nasa.gov/apod/image/1610/m33_brc_lrgb_ha_hiresPivato.jpg',
          );
  }
} */
