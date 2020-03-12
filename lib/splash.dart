import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:video_player/video_player.dart';
import 'package:xiongmao_reader/app/components/public.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State < SplashPage > {

  VideoPlayerController _controller;
  Future _initializeVideoPlayerFuture;
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    _controller = VideoPlayerController.asset('asset/qidong.mp4');
    _controller.setLooping(true);
    _controller.setVolume(100); 

    setState(() {
      _controller.play();
    });
    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: < Widget > [
        FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            print(snapshot.connectionState);

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
        Positioned(
          left: 135,
          bottom: 120,
          child: RaisedButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            color: Colors.transparent,
            disabledElevation:0,
            textColor: Colors.white,
            elevation: 0,
            onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  new MaterialPageRoute(builder: (context) => new HomeScene()
                  ), (route) => route == null);
            },
            shape: RoundedRectangleBorder(
               side: BorderSide(
                    color: Colors.white,
                  ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Text('立即体验', style: TextStyle(fontSize: 30, ))
          ),
        ),
      ],
    );
  }
}