import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wan_android_flutter/UI/page/article/article_detail_page.dart';
import 'package:wan_android_flutter/UI/page/article/article_detail_plugin_page.dart';
import 'package:wan_android_flutter/UI/page/splash.dart';
import 'package:wan_android_flutter/UI/page/tab/tab_main.dart';
import 'package:wan_android_flutter/UI/widget/page_route_anim.dart';
import 'package:wan_android_flutter/config/storage_manager.dart';
import 'package:wan_android_flutter/model/article.dart';
import 'package:wan_android_flutter/view_model/setting_model.dart';

/**
 * 路由名称
 */
class RouteName {
  static const String splash = 'splash';
  static const String tab = '/';
  static const String homeSecondFloor = 'homeSecondFloor';
  static const String login = 'login';
  static const String register = 'register';
  static const String articleDetail = 'articleDetail';
  static const String structureList = 'structureList';
  static const String favouriteList = 'favouriteList';
  static const String setting = 'setting';
  static const String coinRecordList = 'coinRecordList';
  static const String coinRankingList = 'coinRankingList';
}

class Router {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch(settings.name){
      case RouteName.splash:
        return NoAnimRouteBuilder(SplashPage());
      case RouteName.tab:
        return NoAnimRouteBuilder(TabMain());
      case RouteName.articleDetail:
        // 获取路由传递的参数
        var article = settings.arguments as Article;
        return CupertinoPageRoute(
          builder: (_) {
            bool isWebPlugin = StorageManager.sharedPreferences.getBool(kUseWebViewPlugin) ?? false;
            if (isWebPlugin) {
              return ArticleDetailPluginPage(article: article);
            }

            return ArticleDetailPage(article: article);
          }
        );
    }
  }
}

/// Pop路由
class PopRoute extends PopupRoute {
  final Duration _duration = Duration(milliseconds: 300);
  Widget child;

  PopRoute({@required this.child});

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;
}


