import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wan_android_flutter/UI/widget/app_bar_indicator.dart';
import 'package:wan_android_flutter/config/router_manager.dart';
import 'package:wan_android_flutter/generated/i18n.dart';
import 'package:wan_android_flutter/provider/provider_widget.dart';
import 'package:wan_android_flutter/view_model/coin_model.dart';

class UserCoin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<CoinModel>(
        model: CoinModel(),
        onModelReady: (model) => model.initData(),
        builder: (context, model, child) {
          if (model.busy) {
            return AppBarIndicator(radius: 8);
          }
          var textStyle = Theme.of(context).textTheme.body1.copyWith(
              color: Colors.white.withAlpha(200),
              decoration: TextDecoration.underline);
          return InkWell(
              onTap: () {
                if (model.error) {
                  model.initData();
                } else if (model.idle) {
                  Navigator.pushNamed(context, RouteName.coinRecordList);
                }
              },
              child: model.error
                  ? Text(S.of(context).retry, style: textStyle)
                  : Text('${S.of(context).coin}：${model.coin}',
                  style: textStyle));
        });
  }
}