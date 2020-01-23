//import 'package:cookie_jar/cookie_jar.dart';
//import 'package:dio/dio.dart';
//import 'package:dio_cookie_manager/dio_cookie_manager.dart';
//import 'package:wan_android_flutter/config/storage_manager.dart';
//
//import 'base_api.dart';
//
//final Http http = Http();
//
//class Http extends BaseHttp {
////  @override
////  void init() {
////    options.baseUrl = 'https://www.wanandroid.com/';
////    interceptors.add(ApiInterceptor());
////    interceptors.add(CookieManager(PersistCookieJar(
////        dir: StorageManager.temporaryDirectory.path)
////    ));
////  }
//  @override
//  void init() {
//    options.baseUrl = 'https://www.wanandroid.com/';
//
//    interceptors.add(ApiWanInterceptor());
//
//  }
//}
//
//class ApiWanInterceptor extends InterceptorsWrapper {
////  @override
////  onRequest(RequestOptions options) async {
////    options.baseUrl = 'https://www.wanandroid.com/';
////    return options;
////  }
//
//  @override
//  Future onResponse(Response response) async {
//    print('---api-response--->resp----->${response.data}');
//    ResponseData respData = ResponseData.fromJson(response.data);
//    if (respData.success) {
//      response.data = respData.data;
//      return http.resolve(response);
//    }
//
//    if (respData.code == -1001) {
//      // 如果cookie过期,需要清除本地存储的登录信息
//      // StorageManager.localStorage.deleteItem(UserModel.keyUser);
//      throw const UnAuthorizedException(); // 需要登录
//    } else {
//      throw NotSuccessException.fromRespData(respData);
//    }
//  }
//}
//
//class ResponseData extends BaseResponseData {
//  bool get success => 0 == code;
//
//  ResponseData.fromJson(Map<String, dynamic> json) {
//    code = json['errorCode'];
//    message = json['errorMsg'];
//    data = json['data'];
//  }
//}
