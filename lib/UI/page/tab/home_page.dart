

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_flutter/provider/provider_widget.dart';
import 'package:wan_android_flutter/view_model/home_model.dart';
import 'package:wan_android_flutter/view_model/tap_to_top_model.dart';

const double kHomeRefreshHeight = 180.0;

class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

// AutomaticKeepAliveClientMixin: 切换tab后保留tab的状态，避免initState方法重复调用
class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => null;

  Widget build(BuildContext context) {
    return null;
  }


//  @override
//  Widget build(BuildContext context) {
//    return ProviderWidget2<HomeModel, TapToTopModel>(
//      model1: HomeModel(),
//    // 使用PrimaryScrollController保留iOS点击状态栏回到顶部的功能
//      model2: TapToTopModel(PrimaryScrollController.of(context), height: 200),
//      onModelReady: (HomeModel homeModel, TapToTopModel tapToTopModel) {
//        homeModel.initData();
//        tapToTopModel.init();
//      },
//      builder: (context, homeModel, tapToTopModel, child) {
//        return Scaffold(
//          body: MediaQuery.removePadding(
//            context: context,
//            removeTop: false,
//            child: Builder(
//                builder: (_) {
//                  return RefreshConfiguration.copyAncestor(
//                      context: context,
//                      // 下拉触发二楼距离
//                      twiceTriggerDistance: kHomeRefreshHeight - 15,
//                      //最大下拉距离,android默认为0,这里为了触发二楼
//                      maxOverScrollExtent: kHomeRefreshHeight,
//                      headerTriggerDistance: 80 + MediaQuery.of(context).padding.top / 3,
//                      child: SmartRefresher(
//                        controller: homeModel.refreshController,
//                        header: HomeRefreshHeader(),
//                        enableTwoLevel: homeModel.list.isNotEmpty,
//                      ));
//                }
//
//            ),
//          ),
//        );
//      },
//    );
//  }
}