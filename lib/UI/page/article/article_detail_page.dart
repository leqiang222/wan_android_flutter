import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wan_android_flutter/UI/page/article/webview_pop_up_menu_page.dart';
import 'package:wan_android_flutter/UI/widget/app_bar_indicator.dart';
import 'package:wan_android_flutter/generated/i18n.dart';
import 'package:wan_android_flutter/model/article.dart';
import 'package:wan_android_flutter/util/StringUtils.dart';
import 'package:wan_android_flutter/util/third_app_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

/*
 * @description: 文章详情web容器
 * @author leqiang222
 * @create 2020/2/18
 */

class ArticleDetailPage extends StatefulWidget {
  final Article article;

  ArticleDetailPage({this.article});

  @override
  _ArticleDetailPageState createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  WebViewController _webViewController;
  Completer<bool> _finishedCompleter = Completer();

  ValueNotifier canGoBack = ValueNotifier(false);
  ValueNotifier canGoForward = ValueNotifier(false);

  // 该文章链接是否能打开第三方app
  Future canOpenAppFuture;

  @override
  void initState() {
    canOpenAppFuture = ThirdAppUtils.canOpenApp(widget.article.link);
    super.initState();
  }

  // 创建web的标题栏
  AppBar createWebAppBar() {
    return AppBar(
      title: WebViewTitle(
        title: widget.article.title,
        future: _finishedCompleter.future,
      ),
      actions: <Widget>[
        IconButton(
          // 跳转手机app浏览器
          ///            tooltip: S.of(context).openBrowser,
          icon: Icon(Icons.open_in_browser),
          onPressed: () {
            launch(widget.article.link, forceSafariVC: false);
          },
        ),
        WebViewPopupMenu(
          _webViewController,
          widget.article,
        )
      ],
    );
  }

  // 创建webview
  WebView createWebView() {
    return WebView(
      // 初始化加载的url
      initialUrl: widget.article.link,
      // web已经创建
      onWebViewCreated: (WebViewController controller) {
        _webViewController = controller;
        _webViewController.currentUrl().then((url) {
          debugPrint('返回当前$url');
        });
      },
      // web加载完成
      onPageFinished: (String value) async {
        debugPrint('加载完成: $value');
        if (!_finishedCompleter.isCompleted) {
          _finishedCompleter.complete(true);
        }
        refreshBottomNavigator();
      },
      // 加载js
      javascriptMode: JavascriptMode.unrestricted,
      navigationDelegate: (NavigationRequest request) {
        /// TODO isForMainFrame为false,页面不跳转.导致网页内很多链接点击没效果
        debugPrint('导航$request');
        if (request.url.startsWith('http')) {
          return NavigationDecision.navigate;
        }

        ThirdAppUtils.openAppByUrl(request.url);
        return NavigationDecision.prevent;
      },
    );
  }

  BottomAppBar createBottomAppBar() {
    return BottomAppBar(
      child: IconTheme(
        data: Theme.of(context).iconTheme.copyWith(opacity: 0.7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ValueListenableBuilder(
              valueListenable: canGoBack,
              builder: (context, value, child) => IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: !value
                      ? null
                      : () {
                          _webViewController.goBack();
                          refreshBottomNavigator();
                        }),
            ),
            ValueListenableBuilder(
              valueListenable: canGoForward,
              builder: (context, value, child) => IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: !value
                      ? null
                      : () {
                          _webViewController.goForward();
                          refreshBottomNavigator();
                        }),
            ),
            IconButton(
              tooltip: S.of(context).refresh,
              icon: const Icon(Icons.autorenew),
              onPressed: () {
                _webViewController.reload();
              },
            ),
//              ProviderWidget<FavouriteModel>(
//                model: FavouriteModel(
//                    globalFavouriteModel: Provider.of(context, listen: false)),
//                builder: (context, model, child) {
//                  var tag = 'detail';
//                  var userModel =
//                      Provider.of<UserModel>(context, listen: false);
//                  return IconButton(
//                    tooltip: S.of(context).favourites,
//                    icon: Hero(
//                      tag: tag,
//                      child: Icon(
//                          userModel.hasUser && (widget.article.collect ?? true)
//                              ? Icons.favorite
//                              : Icons.favorite_border,
//                          color: Colors.redAccent[100]),
//                    ),
//                    onPressed: () async {
////                      await addFavourites(context,
////                          article: widget.article, model: model, tag: tag);
//                    },
//                  );
//                },
//              ),
          ],
        ),
      ),
    );
  }

  Widget createOpenAppFuture() {
    return FutureBuilder<String>(
      future: canOpenAppFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return FloatingActionButton(
            onPressed: () {
              ThirdAppUtils.openAppByUrl(snapshot.data);
            },
            child: Icon(Icons.open_in_new),
          );
        }
        return SizedBox.shrink();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createWebAppBar(),
      body: SafeArea(
        bottom: false,
        child: createWebView(),
      ),
      bottomNavigationBar: createBottomAppBar(),
      floatingActionButton: createOpenAppFuture(),
    );
  }

  /// 刷新导航按钮
  ///
  /// 目前主要用来控制 '前进','后退'按钮是否可以点击
  /// 但是目前该方法没有合适的调用时机.
  /// 在[onPageFinished]中,会遗漏正在加载中的状态
  /// 在[navigationDelegate]中,会存在页面还没有加载就已经判断过了.
  void refreshBottomNavigator() {
    /// 是否可以后退
    _webViewController.canGoBack().then((value) {
      debugPrint('canGoBack--->$value');
      return canGoBack.value = value;
    });

    /// 是否可以前进
    _webViewController.canGoForward().then((value) {
      debugPrint('canGoForward--->$value');
      return canGoForward.value = value;
    });
  }
}

class WebViewTitle extends StatelessWidget {
  final String title;
  final Future<bool> future;

  WebViewTitle({this.title, this.future});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        FutureBuilder<bool>(
          future: future,
          initialData: false,
          builder: (context, snapshot) => snapshot.data
              ? SizedBox.shrink()
              : Padding(
                  padding: EdgeInsets.only(right: 5), child: AppBarIndicator()),
        ),
        Expanded(
            child: Text(
              //移除html标签
              StringUtils.removeHtmlLabel(title),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16),
        ))
      ],
    );
  }
}
