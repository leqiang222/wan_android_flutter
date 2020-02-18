import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:wan_android_flutter/generated/i18n.dart';
import 'package:wan_android_flutter/model/article.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPopupMenu extends StatelessWidget {
  final WebViewController controller;
  final Article article;

  WebViewPopupMenu(this.controller, this.article);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => <PopupMenuEntry<int>>[
        PopupMenuItem(
          child: WebViewPopupMenuItem(Icons.collections, "收藏"),
          value: 1,
        ),
        PopupMenuItem(
          child: WebViewPopupMenuItem(Icons.share, S.of(context).share),
          value: 2,
        ),
//        PopupMenuDivider(),
      ],
      onSelected: (value) async {
        switch (value) {
          case 0:
            break;
          case 1:
            break;
          case 2:
            Share.share(article.title + ' ' + article.link);
            break;
        }
      },
    );
  }
}

class WebViewPopupMenuItem<T> extends StatelessWidget {
  final IconData iconData;
  final Color color;
  final String text;

  WebViewPopupMenuItem(this.iconData, this.text, {this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(
          iconData,
          size: 20,
          color: color ?? Theme.of(context).textTheme.body1.color,
        ),
        SizedBox(
          width: 20,
        ),
        Text(text)
      ],
    );
  }
}