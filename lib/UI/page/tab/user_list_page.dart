import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wan_android_flutter/config/router_manager.dart';
import 'package:wan_android_flutter/generated/i18n.dart';

class UserListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var iconColor = Theme.of(context).accentColor;

    return ListTileTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 30),
      child: SliverList(
          delegate: SliverChildListDelegate([
            ListTile(
              title: Text(S.of(context).favourites),
              onTap: () {
              },
              leading: Icon(
                Icons.favorite_border,
                color: iconColor,
              ),
              trailing: Icon(Icons.chevron_right),
            ),
            ListTile(
              title: Text(S.of(context).darkMode),
              onTap: () {
              },
              leading: Transform.rotate(
                angle: -pi,
                child: Icon(
                  Theme.of(context).brightness == Brightness.light
                      ? Icons.brightness_5
                      : Icons.brightness_2,
                  color: iconColor,
                ),
              ),
              trailing: CupertinoSwitch(
                  activeColor: Theme.of(context).accentColor,
                  value: Theme.of(context).brightness == Brightness.dark,
                  onChanged: (value) {
                  }),
            ),
            ListTile(
              title: Text(S.of(context).setting),
              onTap: () {
                Navigator.pushNamed(context, RouteName.setting);
              },
              leading: Icon(
                Icons.settings,
                color: iconColor,
              ),
              trailing: Icon(Icons.chevron_right),
            ),
            ListTile(
              title: Text(S.of(context).appUpdateCheckUpdate),
              onTap: () {
              },
              leading: Icon(
                Icons.system_update,
                color: iconColor,
              ),
              trailing: Icon(Icons.chevron_right),
            ),
          ]),
      ),
    );
  }

}