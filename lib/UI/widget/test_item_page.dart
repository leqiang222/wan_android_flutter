import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:wan_android_flutter/config/resource_manager.dart';

class TestItemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("TestItemPage"),
      ),
      body: ListView.builder(
          itemCount: 100,
          itemBuilder: (context, index) {
            return TestItem();
          }),
    );
  }
}

class TestItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        /// 点击事件的容器 作为 一个次顶容器
        InkWell(
          child: Container(
            /// 内部所有控件的内边距
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              border: Border(
                bottom: Divider.createBorderSide(context, width: 0.7),
              )
            ),
            /// 内部所有控件自上而下的控件布局
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 5),
                Row(
                  children: <Widget>[
                    ClipOval(
                      child: Image.asset(
                        ImageHelper.wrapAssets('logo_weibo.png'),
                        width: 30,
                        height: 30,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text("作者名字"),
                    ),
                    Expanded(child: SizedBox.shrink()),
                    Text("2020年03月11日20:59:10"),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: <Widget>[
                    /// 标题和介绍用Expanded(撑开)的控件,可以让图片控件固定在右边
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "文章标题文章标题文章标题文章标题文章标题文章标题",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          SizedBox(height: 3),
                          Text(
                            "文章介绍文章介绍文章介绍文章介绍文章介绍文章介绍文章介绍文章介绍文章介绍文章介绍文章介绍文章介绍文章介绍文章介绍文章介绍文章介绍文章介绍",
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Image.asset(
                      ImageHelper.wrapAssets('login_logo.png'),
                      width: 70,
                      height: 70,
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: <Widget>[
                    Text(
                      "所属项目_xxx",
                      style: TextStyle(color: Colors.orange, fontSize: 12),
                    ),
                  ],
                )
              ],
            ),
          ),
          onTap: () {
          },
        )
      ],
    );
  }
}
