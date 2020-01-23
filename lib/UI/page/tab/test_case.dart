import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wan_android_flutter/service/wan_android_repository.dart';

class TestCase extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TestCaseState();
  }
}

class TestCaseState extends State<TestCase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("测试用例"),),
      body: Container(
        child: RaisedButton(
          child: Text("网络测试"),
          onPressed: (){
            _test01_net();
          },
        ),
      ),
    );
  }

  /// 网络请求
  void _test01_net() {
    WanAndroidRepository.fetchBanners().then((onValue) {
      print("llq01: " + onValue.toString());
    });
  }
}


