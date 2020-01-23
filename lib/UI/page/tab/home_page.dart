import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_flutter/provider/provider_widget.dart';
import 'package:wan_android_flutter/provider/view_state_widget.dart';
import 'package:wan_android_flutter/util/status_bar_utils.dart';
import 'package:wan_android_flutter/view_model/home_model.dart';
import 'package:wan_android_flutter/view_model/tap_to_top_model.dart';

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

// AutomaticKeepAliveClientMixin: 切换tab后保留tab的状态，避免initState方法重复调用
class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  String _title;

  HomePageState(String title) {
    _title = title;
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // 轮播图高度
    var bannerHeight = MediaQuery.of(context).size.width * 5 / 11;

    return ProviderWidget2(
      model1: HomeModel(),
      // 使用PrimaryScrollController保留iOS点击状态栏回到顶部的功能
      model2: TapToTopModel(

      ),
      builder: (context, homeModel, tapToTopModel, child) {
        return Scaffold(
          body: MediaQuery.removePadding(
              context: context,
              child: Builder(
                  builder: (context) {
                    if (homeModel.error && homeModel.list.isEmpty) {
                      return AnnotatedRegion<SystemUiOverlayStyle>(
                        value: StatusBarUtils.systemUiOverlayStyle(context),
                          child: ViewStateErrorWidget(
                            error: homeModel.viewStateError,
                            onPressed: (){
                              homeModel.initData;
                            },
                          )
                      );
                    }
                    return RefreshConfiguration.copyAncestor(
                        context: context,
                        child: SmartRefresher(
                          controller: homeModel.refreshController,

                        )
                    );
                  }
              )),
        );
      },
    );
  }

}

