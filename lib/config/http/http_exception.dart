import 'package:wan_android_flutter/config/http/response_data.dart';

/*
 * @description: 接口的code没有返回为true的异常
 * @author leqiang222
 * @create 2020/1/23
 */

class NotSuccessException implements Exception {
  String message;

  NotSuccessException.fromRespData(BaseResponseData respData) {
    message = respData.message;
  }

  @override
  String toString() {
    return 'NotExpectedException{respData: $message}';
  }
}

/*
 * @description: 用于未登录等权限不够,需要跳转授权页面
 * @author leqiang222
 * @create 2020/1/23
 */

class UnAuthorizedException implements Exception {
  const UnAuthorizedException();

  @override
  String toString() => 'UnAuthorizedException';
}