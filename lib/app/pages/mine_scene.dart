import 'package:flutter/material.dart';
import 'package:xiongmao_reader/app/components/app_color.dart';
import 'package:xiongmao_reader/app/components/me_cell.dart';
import 'package:xiongmao_reader/app/components/public.dart';
class MineScene extends StatefulWidget {
  @override
  _MineSceneState createState() => _MineSceneState();
}

class _MineSceneState extends State < MineScene > {


  String _updateUrl = "https://luhongwei123.gitee.io/version/version.json";
  
  // String _updateUrl =
  //     "https://gitee.com/xuexiangjys/XUpdate/raw/master/jsonapi/update_test.json";
  @override
  void initState() {
    super.initState();
    // initXUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Container(color: AppColor.white),
        preferredSize: Size(ScreenUtil().setWidth(20), 0),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: < Widget > [
            _Header(),
            SizedBox(height: 10),
            buildCells(context),
          ],
        ),
      ),
    );
  }

  Widget _Header() {
    return GestureDetector(
      onTap: () {

      },
      child: Container(
        color: AppColor.white,
        padding: EdgeInsets.fromLTRB(20, 30, 15, 15),
        child: Row(
          children: < Widget > [
            CircleAvatar(
              radius: 40,
              backgroundImage: CachedNetworkImageProvider('http://b-ssl.duitang.com/uploads/item/201710/20/20171020164428_KXUMZ.thumb.700_0.jpeg'),
            ),
            SizedBox(width: 25),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: < Widget > [
                  Text(
                    '社会人',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  // buildItems(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildCells(BuildContext context) {
    return Container(
      child: Column(
        children: < Widget > [
          MeCell(
            title: '检查更新',
            iconName: 'asset/me/update.png',
            onPressed: () {
              // checkUpdate2();
              // _checkVersion();
              AppNavigator.toUpdate(context);
            },
          ),
          MeCell(
            title: '关于',
            iconName: 'asset/me/about.png',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
