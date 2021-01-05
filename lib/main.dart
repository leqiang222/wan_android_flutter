import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_flutter/config/provider_manager.dart';
import 'package:wan_android_flutter/config/router_manager.dart';
import 'package:wan_android_flutter/view_model/locale_model.dart';

import 'config/storage_manager.dart';
import 'generated/i18n.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();

  // 持久化管理类初始化
  await StorageManager.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // 本地化
  final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates =
      const [
    S.delegate,
    RefreshLocalizations.delegate, //下拉刷新
    GlobalCupertinoLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: Consumer<LocaleModel>(
        builder: (context, localeModel, child) {
//          hideFooterWhenNotFull: true, //列表数据不满一页,不触发加载更多
          return MaterialApp(
            // 消除页面右上角的debug条幅
            debugShowCheckedModeBanner: false,
            // 初始化的路由名称，app启动一开始就显示这个页面
            initialRoute: RouteName.splash,
            onGenerateRoute: Router.onGenerateRoute,
            locale: localeModel.locale,
            supportedLocales: S.delegate.supportedLocales,
            localizationsDelegates: localizationsDelegates,
            // 设置主题
            theme: ThemeData(
                // 主题颜色
                primarySwatch: Colors.blue),
          );
        },
      ),
    );
  }
}
