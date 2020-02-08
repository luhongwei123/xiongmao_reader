import 'package:flutter/material.dart';
import 'package:xiongmao_reader/app/components/public.dart';

class Logo extends StatefulWidget {
  @override
  _LogoState createState() => _LogoState();
}

class _LogoState extends State<Logo> with SingleTickerProviderStateMixin{
  CurvedAnimation curved;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 3));
    curved = new CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut
    );
    curved.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _controller.forward();
  }
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 200,
      left: 140,
      child: FadeTransition(
        // turns: curved,
        opacity: curved,
        child: 
          Image.asset(
            'asset/logo.png',
            width: 120,
            height: 50,
            gaplessPlayback: true,
          ),
        )
    );
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}