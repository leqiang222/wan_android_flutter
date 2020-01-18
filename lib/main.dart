import 'package:flutter/material.dart';
import 'package:wan_android_flutter/config/router_manager.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '玩android',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: RouteName.splash,
      onGenerateRoute: Router.onGenerateRoute,
    );
  }
}

