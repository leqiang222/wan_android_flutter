import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wan_android_flutter/generated/i18n.dart';
import 'package:wan_android_flutter/provider/provider_widget.dart';
import 'package:wan_android_flutter/view_model/login_model.dart';

import 'login_field_widget.dart';
import 'login_widget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget createPopLogin () {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
      child: IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        // 不可滚动
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Stack(
              children: <Widget>[
                LoginTopPanel(),
                createPopLogin(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      LoginLogo(),
                      LoginFormContainer(
                        child: ProviderWidget<LoginModel>(
                          model: LoginModel(Provider.of(context)),
                          builder: (context, model, child) {
                            return Form(
                              onWillPop: () async {
                                return !model.busy;
                              },
                              child: child,
                            );
                          },
                          child: Column(
                              children: <Widget>[
                                LoginTextField(
                                  label: S.of(context).userName,
                                  icon: Icons.perm_identity,
                                  controller: _nameController,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (text) {
//                                    FocusScope.of(context)
//                                        .requestFocus(_pwdFocus);
                                  },
                                ),
                                LoginTextField(
                                  controller: _passwordController,
                                  label: S.of(context).password,
                                  icon: Icons.lock_outline,
                                  obscureText: true,
//                                  focusNode: _pwdFocus,
                                  textInputAction: TextInputAction.done,
                                ),
                                LoginButton(_nameController, _passwordController),
                                SingUpWidget(_nameController),
                              ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

}



