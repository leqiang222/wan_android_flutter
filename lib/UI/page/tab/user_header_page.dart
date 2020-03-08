import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wan_android_flutter/UI/page/tab/user_coin.dart';
import 'package:wan_android_flutter/config/resource_manager.dart';
import 'package:wan_android_flutter/config/router_manager.dart';
import 'package:wan_android_flutter/generated/i18n.dart';
import 'package:wan_android_flutter/view_model/user_model.dart';

import 'bottom_clipper.dart';

class UserHeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
        clipper: BottomClipper(),
        child: Container(
            color: Theme.of(context).primaryColor.withAlpha(200),
            padding: EdgeInsets.only(top: 10),
            child: Consumer<UserModel>(
                builder: (context, model, child) => InkWell(
                    onTap: model.hasUser
                        ? null
                        : () {
                      Navigator.of(context).pushNamed(RouteName.login);
                    },
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            child: Hero(
                              tag: 'loginLogo',
                              child: ClipOval(
                                child: Image.asset(
                                    ImageHelper.wrapAssets('user_avatar.png'),
                                    fit: BoxFit.cover,
                                    width: 80,
                                    height: 80,
                                    color: model.hasUser
                                        ? Theme.of(context)
                                        .accentColor
                                        .withAlpha(200)
                                        : Theme.of(context)
                                        .accentColor
                                        .withAlpha(10),
                                    // https://api.flutter.dev/flutter/dart-ui/BlendMode-class.html
                                    colorBlendMode: BlendMode.colorDodge),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(children: <Widget>[
                            Text(
                                model.hasUser
                                    ? model.user.nickname
                                    : S.of(context).toSignIn,
                                style: Theme.of(context)
                                    .textTheme
                                    .title
                                    .apply(color: Colors.white.withAlpha(200))),
                            SizedBox(
                              height: 10,
                            ),
                            if (model.hasUser) UserCoin()
                          ])
                        ])))));
  }
}

