import 'package:provider/provider.dart';
import 'package:wan_android_flutter/view_model/favourite_model.dart';
import 'package:wan_android_flutter/view_model/locale_model.dart';
import 'package:wan_android_flutter/view_model/user_model.dart';

List<SingleChildCloneableWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders
];

/// 独立的model
List<SingleChildCloneableWidget> independentServices = [
//  ChangeNotifierProvider<ThemeModel>(
//    create: (context) => ThemeModel(),
//  ),
  ChangeNotifierProvider<LocaleModel>(
    create: (context) => LocaleModel(),
  ),
//  ChangeNotifierProvider<GlobalFavouriteStateModel>(
//    create: (context) => GlobalFavouriteStateModel(),
//  )
  ChangeNotifierProvider<UserModel>(
      create: (context) => UserModel(),
  )
];

/// 需要依赖的model
///
/// UserModel依赖globalFavouriteStateModel
List<SingleChildCloneableWidget> dependentServices = [
//  ChangeNotifierProxyProvider<GlobalFavouriteStateModel, UserModel>(
//    create: null,
//    update: (context, globalFavouriteStateModel, userModel) =>
//    userModel ??
//        UserModel(globalFavouriteStateModel: globalFavouriteStateModel),
//  )
];

List<SingleChildCloneableWidget> uiConsumableProviders = [
//  StreamProvider<User>(
//    builder: (context) => Provider.of<AuthenticationService>(context, listen: false).user,
//  )
];
