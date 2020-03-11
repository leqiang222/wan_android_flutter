import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wan_android_flutter/UI/page/tab/user_header_page.dart';
import 'package:wan_android_flutter/UI/page/tab/user_list_page.dart';
import 'package:wan_android_flutter/UI/widget/activity_indicator.dart';
import 'package:wan_android_flutter/provider/provider_widget.dart';
import 'package:wan_android_flutter/view_model/login_model.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: false,
            backgroundColor: Colors.red,
            expandedHeight: 200 + MediaQuery.of(context).padding.top,
            flexibleSpace: UserHeaderWidget(),
            actions: <Widget>[
              ProviderWidget<LoginModel>(
                model: LoginModel(Provider.of(context)),
                builder: (context, model, child) {
                  if (model.busy) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: ActivityIndicator(),
                    );
                  }

                  return SizedBox.shrink();
                },
              )
            ],
          ),
          UserListWidget(),
        ],
      ),
    );
  }
}