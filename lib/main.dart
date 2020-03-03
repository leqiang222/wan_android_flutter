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

  // 持久化相关初始化
  await StorageManager.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates = const [
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
            title: '玩android',
            initialRoute: RouteName.splash,
            onGenerateRoute: Router.onGenerateRoute,
            locale: localeModel.locale,
            supportedLocales: S.delegate.supportedLocales,
            localizationsDelegates: localizationsDelegates,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
          );
        },
      ),
    );
  }
}
