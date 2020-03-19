import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:xiongmao_reader/app/components/event_util.dart';
import 'package:xiongmao_reader/app/components/public.dart';

class VideoPlayerScene extends StatefulWidget {
  final VideoPlayerController _controller;

  VideoPlayerScene(this._controller);
  @override
  _VideoPlayerSceneState createState() => _VideoPlayerSceneState();
}

class _VideoPlayerSceneState extends State < VideoPlayerScene > {
  VideoPlayerController _controller;

  Future _initializeVideoPlayerFuture;

  ChewieController chewieController;

  StreamSubscription _colorSubscription;

  @override
  void initState() {
    super.initState();
    _controller = this.widget._controller;
    _controller.setLooping(true);
    _controller.setVolume(100);
    _initializeVideoPlayerFuture = _controller.initialize();
    chewieController = ChewieController(
      videoPlayerController: _controller,
      autoInitialize: true,
      autoPlay: true,
      fullScreenByDefault:true,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(errorMessage, style: TextStyle(color: Colors.white)),
        );
      }
    );
    // _colorSubscription = eventBus.on<VideoEvent>().listen((event) {
    //     if(event.pause == this.widget.index){
    //         setState(() {
    //           visable='play';
    //           _controller.play();
    //         });
    //     }else{
    //       setState(() {
    //           visable='play1';
    //           _controller.pause();
    //         });
    //     }
    // });
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
         Padding(
          padding: EdgeInsets.all(8),
          child: Chewie(controller: chewieController),
        ),
      ],
    );
  }
  @override
  void dispose() {
    _controller.dispose();
    chewieController.dispose();
    // _colorSubscription.cancel();
    super.dispose();
  }
}