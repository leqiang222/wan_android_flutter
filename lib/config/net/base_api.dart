//import 'dart:io';
//
//import 'package:dio/dio.dart';
//import 'package:dio/native_imp.dart';
//import 'package:wan_android_flutter/util/PlatformUtils.dart';
//
//abstract class BaseHttp extends DioForNative {
//  BaseHttp([BaseOptions options]):super(options){
//    // 添加request拦截器, 注入入参
//    interceptors.add(HeaderInterceptor());
//    init();
//  }
//
//  void init();
//}
//
//
/////每个 Dio 实例都可以添加任意多个拦截器，他们组成一个队列，拦截
/////器队列的执行顺序是FIFO。通过拦截器你可以在请求之前或响应之后(但还
/////没有被 then 或 catchError处理)做一些统一的预处理操作
//class HeaderInterceptor extends InterceptorsWrapper {
//  @override
//  onRequest(RequestOptions options) async {
//    options.connectTimeout = 1000 * 45;
//    options.receiveTimeout = 1000 * 45;
//
//    var appVersion = await PlatformUtils.getAppVersion();
//    var version = Map()
//      ..addAll({
//        'appVerison': appVersion,
//      });
//    options.headers['version'] = version;
//    options.headers['platform'] = Platform.operatingSystem;
//
//    // 在请求被发送之前做一些事情
//    return options;
//  }
//}
//
///// 子类需要重写
//abstract class BaseResponseData {
//  int code = 0;
//  String message;
//  dynamic data;
//
//  bool get success;
//
//  BaseResponseData({this.code, this.message, this.data});
//
//  @override
//  String toString() {
//    return 'BaseRespData{code: $code, message: $message, data: $data}';
//  }
//}
//
//
///// 接口的code没有返回为true的异常
//class NotSuccessException implements Exception {
//  String message;
//
//  NotSuccessException.fromRespData(BaseResponseData respData) {
//    message = respData.message;
//  }
//
//  @override
//  String toString() {
//    return 'NotExpectedException{respData: $message}';
//  }
//}
//
///// 用于未登录等权限不够,需要跳转授权页面
//class UnAuthorizedException implements Exception {
//  const UnAuthorizedException();
//
//  @override
//  String toString() => 'UnAuthorizedException';
//}