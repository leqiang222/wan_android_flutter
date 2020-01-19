import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  String _title;

  HomePage(String title) {
    _title = title;
  }

  @override
  State<StatefulWidget> createState() {
    return HomePageState(_title);
  }
}

class HomePageState extends State<HomePage> {
  String _title;

  HomePageState(String title) {
    _title = title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        body: Text("home"));
  }
}

