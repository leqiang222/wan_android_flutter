import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wan_android_flutter/UI/page/tab/bottom_clipper.dart';
import 'package:wan_android_flutter/config/resource_manager.dart';
import 'package:wan_android_flutter/config/router_manager.dart';
import 'package:wan_android_flutter/generated/i18n.dart';
import 'package:wan_android_flutter/view_model/login_model.dart';

class LoginTopPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BottomClipper(),
      child: Container(
        height: 284,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}

class LoginLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Hero(
      tag: 'loginLogo',
      child: Image.asset(
        ImageHelper.wrapAssets('login_logo.png'),
        width: 130,
        height: 100,
        fit: BoxFit.fitWidth,
        color: theme.brightness == Brightness.dark
            ? theme.accentColor
            : Colors.white,
        colorBlendMode: BlendMode.srcIn,
      ),
    );
  }
}

class LoginFormContainer extends StatelessWidget {
  final Widget child;

  LoginFormContainer({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(),
          color: Theme.of(context).cardColor,
          shadows: [
            BoxShadow(
                color: Theme.of(context).primaryColor.withAlpha(20),
                offset: Offset(1.0, 1.0),
                blurRadius: 10.0,
                spreadRadius: 3.0),
          ]),
      child: child,
    );
  }
}

class ButtonProgressIndicator extends StatelessWidget {
  final double size;
  final Color color;

  ButtonProgressIndicator({this.size: 24, this.color: Colors.white});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation(color),
        ));
  }
}

class SingUpWidget extends StatefulWidget {
  final nameController;

  SingUpWidget(this.nameController);

  @override
  _SingUpWidgetState createState() => _SingUpWidgetState();
}

class _SingUpWidgetState extends State<SingUpWidget> {
  TapGestureRecognizer _recognizerRegister;

  @override
  void initState() {
    _recognizerRegister = TapGestureRecognizer()
      ..onTap = () async {
        // 将注册成功的用户名,回填如登录框
        widget.nameController.text =
            await Navigator.of(context).pushNamed(RouteName.register);
      };
    super.initState();
  }

  @override
  void dispose() {
    _recognizerRegister.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(TextSpan(text: S.of(context).noAccount, children: [
        TextSpan(
            text: S.of(context).toSignUp,
            recognizer: _recognizerRegister,
            style: TextStyle(color: Theme.of(context).accentColor))
      ])),
    );
  }
}

class LoginButton extends StatelessWidget {
  final nameController;
  final passwordController;

  LoginButton(this.nameController, this.passwordController);

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<LoginModel>(context);
    return LoginButtonWidget(
      child: model.busy
          ? ButtonProgressIndicator()
          : Text(
              S.of(context).signIn,
              style: Theme.of(context)
                  .accentTextTheme
                  .title
                  .copyWith(wordSpacing: 6),
            ),
      onPressed: model.busy
          ? null
          : () {
              var formState = Form.of(context);
              if (formState.validate()) {
                model
                    .login(nameController.text, passwordController.text)
                    .then((value) {
                  if (value) {
                    Navigator.of(context).pop(true);
                  } else {
                    model.showErrorMessage(context);
                  }
                });
              }
            },
    );
  }
}

/// LoginPage 按钮样式封装
class LoginButtonWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  LoginButtonWidget({this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).primaryColor.withAlpha(180);
//    return Padding(
//        padding: const EdgeInsets.fromLTRB(15, 40, 15, 20),
//        child: CupertinoButton(
//          padding: EdgeInsets.all(10),
//          color: color,
//          disabledColor: color,
////          borderRadius: BorderRadius.circular(10),
//          pressedOpacity: 0.5,
//          child: child,
//          onPressed: onPressed,
//        ));
    return Container(
      margin: EdgeInsets.fromLTRB(15, 35, 15, 20),
        height: 44,
        width: 500,
        child: CupertinoButton(
          padding: EdgeInsets.all(10),
          color: color,
          disabledColor: color,
          borderRadius: BorderRadius.circular(22),
          pressedOpacity: 0.5,
          child: child,
          onPressed: onPressed,
        ));
  }
}
