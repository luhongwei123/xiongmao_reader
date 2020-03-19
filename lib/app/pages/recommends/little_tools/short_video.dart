import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';

class ShortVideoScene extends StatefulWidget {
  final String url;
  ShortVideoScene(this.url);
  @override
  _ShortVideoSceneState createState() => _ShortVideoSceneState();
}

class _ShortVideoSceneState extends State<ShortVideoScene> {
  VideoPlayerController _controller;
  Future _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);

    _controller = VideoPlayerController.network(widget.url);
    _controller.setLooping(true);
    _controller.setVolume(50); 

    setState(() {
      _controller.play();
    });
    _initializeVideoPlayerFuture = _controller.initialize();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: < Widget > [
        FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            if (snapshot.connectionState == ConnectionState.done) {
              return Transform.scale(
                scale: _controller.value.aspectRatio /
                MediaQuery.of(context).size.aspectRatio,
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  // aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              );
            } else {
              return Center(
                child: Container(),
              );
            }
          },
        ),
      ],
    );
  }
}