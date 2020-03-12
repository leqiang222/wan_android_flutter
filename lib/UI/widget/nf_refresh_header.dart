import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sprintf/sprintf.dart';
import 'package:wan_android_flutter/config/resource_manager.dart';

class NFRefreshHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomHeader(builder: (BuildContext context, RefreshStatus mode) {
      String message = mode == RefreshStatus.idle
          ? "下拉刷新"
          : mode == RefreshStatus.refreshing
              ? "加载中..."
              : mode == RefreshStatus.canRefresh
                  ? "释放加载"
                  : mode == RefreshStatus.completed ? "刷新成功!" : "刷新失败";
      return Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        height: 44,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            if (mode != RefreshStatus.refreshing)
            Positioned(
              left: MediaQuery.of(context).size.width * 0.5 - 30 - 64,
                child: Image.asset(
                  ImageHelper.wrapAssets("load_hud/nf_loading_default@2x.png"),
                  width: 44,
                  height: 44,
                ),
            )
            else
            Positioned(
              left: MediaQuery.of(context).size.width * 0.5 - 30 - 64,
              child: ImagesAnimation(
                w: 44,
                h: 44,
                entry: ImagesAnimationEntry(0, 24, "assets/images/load_hud/nf_loading%02i@2x.png"),durationSeconds: 1,
              ),
            ) ,
            Positioned(
              child: Text(message),
            ),
          ],
        ),
      );
    });
  }
//  final BuildContext context;
//  final RefreshStatus mode;
//
//  NFRefreshHeader({this.context, this.mode});

//  @override
//  Widget build(BuildContext context) {
//    String message = mode == RefreshStatus.idle ? "下拉刷新":mode==RefreshStatus.refreshing?"加载中...":
//    mode==RefreshStatus.canRefresh?"释放加载":mode==RefreshStatus.completed?"刷新成功!":"刷新失败";
//    return Container(
//      margin: EdgeInsets.symmetric(vertical: 15),
//      height: 44,
//      child: Stack(
//        alignment: AlignmentDirectional.center,
//        children: <Widget>[
//          Positioned(
//            left: MediaQuery.of(context).size.width * 0.5 - 30 - 64,
////            child: Image.asset(
////              ImageHelper.wrapAssets("logo_weibo.png"),
////              width: 44,
////              height: 44,
////            ),
//            child: ImagesAnimation(w: 44, h: 44, entry: ImagesAnimationEntry(0, 24, "assets/images/load_hud/nf_loading%02i.png"), durationSeconds: 1,),
//          ),
//          Positioned(
//            child: Text(message),
//          ),
//        ],
//      ),
//    );
//  }

}

class ImagesAnimation extends StatefulWidget {
  final double w;
  final double h;
  final ImagesAnimationEntry entry;
  final int durationSeconds;

  ImagesAnimation(
      {Key key, this.w: 80, this.h: 80, this.entry, this.durationSeconds: 3})
      : super(key: key);

  @override
  _InState createState() {
    return _InState();
  }
}

class _InState extends State<ImagesAnimation> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
        vsync: this, duration: Duration(seconds: widget.durationSeconds))
      ..repeat();
    _animation =
        new IntTween(begin: widget.entry.lowIndex, end: widget.entry.highIndex)
            .animate(_controller);
//widget.entry.lowIndex 表示从第几下标开始，如0；widget.entry.highIndex表示最大下标：如7
  }

  @override
  Widget build(BuildContext context) {
    return new AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget child) {
//        String frame = _animation.value.toString();
        int frame = _animation.value;
        print("llq001: " + sprintf(widget.entry.basePath, [frame]));
        return new Image.asset(
          sprintf(widget.entry.basePath, [frame]), //根据传进来的参数拼接路径
          gaplessPlayback: true, //避免图片闪烁
          width: widget.w,
          height: widget.h,
        );
      },
    );
  }
}

class ImagesAnimationEntry {
  int lowIndex = 0;
  int highIndex = 0;
  String basePath;

  ImagesAnimationEntry(this.lowIndex, this.highIndex, this.basePath);
}
