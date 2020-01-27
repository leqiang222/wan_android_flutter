import 'package:flutter/material.dart';
import 'package:wan_android_flutter/UI/page/tab/home_page2.dart';
import 'package:wan_android_flutter/UI/page/tab/structure_page.dart';
import 'package:wan_android_flutter/UI/page/tab/test_case.dart';

List<Widget> pages = <Widget>[
  StructurePage(),
  StructurePage(),
  StructurePage(),
];

class TabMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TabMainState();
  }
}

class TabMainState extends State<TabMain> {
  List<TabItemInfo> _tabInfoList = TabItemInfo.getTabInfoList();

  DateTime _lastPressedTime;
  var _pageController = PageController();
  int _pageSelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
          // 双击返回与界面退出提示
          onWillPop: () async {
            if (_lastPressedTime == null ||
                DateTime.now().difference(_lastPressedTime) >
                    Duration(seconds: 1)) {
              //两次点击间隔超过1秒则重新计时
              _lastPressedTime = DateTime.now();
              return false;
            }

            return true;
          },
          child: PageView.builder(
            itemBuilder: (BuildContext context, int index) {
              return pages[index];
            },
            itemCount: pages.length,
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(), // page禁止滚动
            onPageChanged: (index) {
              setState(() {
                _pageSelectedIndex = index;
              });
            },
          )),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageSelectedIndex,
        items: _getTabData(),
        onTap: (int index) {
          _pageController.jumpToPage(index);
        },
      ),
    );
  }

  // 标签item组件数组
  List<BottomNavigationBarItem> _getTabData() {
    var tempList = _tabInfoList.map((value) {
      return BottomNavigationBarItem(
          icon: value.tabIcon, title: Text(value.tabTitle));
    });

    return tempList.toList();
  }
}

// 数据
class TabItemInfo {
  String tabTitle;
  Icon tabIcon;

  static List _tabData = [
    {
      'tabTitle': '首页',
      'tabIcon': new Icon(Icons.home),
    },
    {
      'tabTitle': '消息',
      'tabIcon': new Icon(Icons.message),
    },
    {
      'tabTitle': '我的',
      'tabIcon': new Icon(Icons.person),
    },
  ];

  static List<TabItemInfo> getTabInfoList() {
    List<TabItemInfo> tmp = List();

    for (int i = 0; i < _tabData.length; i++) {
      TabItemInfo info = TabItemInfo();
      info.tabTitle = _tabData[i]["tabTitle"];
      info.tabIcon = _tabData[i]["tabIcon"];

      tmp.add(info);
    }

    return tmp;
  }
}
