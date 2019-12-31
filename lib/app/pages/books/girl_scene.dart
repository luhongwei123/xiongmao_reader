import 'package:flutter/material.dart';
 
class GirlScene extends StatefulWidget{
  @override
  _GirlSceneState createState() => _GirlSceneState();
}
 
class _GirlSceneState extends State<GirlScene> with AutomaticKeepAliveClientMixin{
 
  @override
  bool get wantKeepAlive => true; 
 
  @override
  Widget build(BuildContext context) {
    super.build(context); 
    return Container(
      child: Center(
        child: Text('女生频道'),
      ),
    );
  }
}