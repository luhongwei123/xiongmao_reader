import 'package:flutter/material.dart';
 
class NewBookScene extends StatefulWidget{
  @override
  _NewBookScene createState() => _NewBookScene();
}
 
class _NewBookScene extends State<NewBookScene> with AutomaticKeepAliveClientMixin{
 
  @override
  bool get wantKeepAlive => true; 
 
  @override
  Widget build(BuildContext context) {
    super.build(context); 
    return Container(
      child: Center(
        child: Text('新书'),
      ),
    );
  }
}