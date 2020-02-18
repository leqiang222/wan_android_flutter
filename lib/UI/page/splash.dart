import 'package:flutter/material.dart';
import 'package:wan_android_flutter/config/resource_manager.dart';
import 'package:wan_android_flutter/config/router_manager.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  AnimationController _countdownController;

  @override
  void initState() {
    _countdownController = AnimationController(
        vsync: this, duration: Duration(seconds: 5));
    _countdownController.forward();

    super.initState();
  }

  @override
  void dispose() {
    _countdownController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image.asset(
                ImageHelper.wrapAssets(
                    Theme.of(context).brightness == Brightness.light
                        ? "splash_bg.png"
                        : "splash_bg_dark.png"),
                fit: BoxFit.fill,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: SafeArea(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed(RouteName.tab);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        margin: EdgeInsets.only(right: 20, bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.black.withAlpha(100),
                        ),
                        child: AnimatedCountdown(
                          context: context,
                          animation: StepTween(begin: _countdownController.duration.inSeconds, end: 1).animate(_countdownController),
                        ),
                      ),
                    )),
              )
            ],
          ),
          onWillPop: null),
    );
  }
}

class AnimatedCountdown extends AnimatedWidget {
  final Animation<int> animation;

  AnimatedCountdown({key, this.animation, context}): super(key: key, listenable: animation) {
    animation.addStatusListener((status){
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushReplacementNamed(RouteName.tab);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var value = animation.value - 1;
    return Text(
      value == 0? "": "$value | " + "跳过",
      style: TextStyle(color: Colors.white),
    );
  }

}
