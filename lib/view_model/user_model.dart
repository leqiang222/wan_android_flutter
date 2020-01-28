import 'package:flutter/cupertino.dart';
import 'package:wan_android_flutter/config/storage_manager.dart';
import 'package:wan_android_flutter/model/user.dart';

import 'favourite_model.dart';

class UserModel extends ChangeNotifier {
  static const String kUser = 'kUser';

//  final GlobalFavouriteStateModel globalFavouriteStateModel;

  User _user;

  User get user => _user;

  bool get hasUser => user != null;

//  UserModel({@required this.globalFavouriteStateModel}) {
//    var userMap = StorageManager.localStorage.getItem(kUser);
//    _user = userMap != null ? User.fromJsonMap(userMap) : null;
//  }

  saveUser(User user) {
    _user = user;
    notifyListeners();
//    globalFavouriteStateModel.replaceAll(_user.collectIds);
    StorageManager.localStorage.setItem(kUser, user);
  }

  /// 清除持久化的用户数据
  clearUser() {
    _user = null;
    notifyListeners();
    StorageManager.localStorage.deleteItem(kUser);
  }
}
