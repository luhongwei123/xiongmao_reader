import 'package:flutter/material.dart';
 
class BoyScene extends StatefulWidget{
  @override
  _BoyScene createState() => _BoyScene();
}
 
class _BoyScene extends State<BoyScene> with AutomaticKeepAliveClientMixin{
 
  @override
  bool get wantKeepAlive => true; 
 
  @override
  Widget build(BuildContext context) {
    super.build(context); 
    return Container(
      child: Center(
        child: Text('男生频道'),
      ),
    );
  }
}