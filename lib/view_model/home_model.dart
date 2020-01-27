import 'package:wan_android_flutter/model/article.dart';
import 'package:wan_android_flutter/model/banner.dart';
import 'package:wan_android_flutter/provider/view_state_refresh_list_model.dart';
import 'package:wan_android_flutter/service/wan_android_repository.dart';
import 'package:wan_android_flutter/view_model/favourite_model.dart';

class HomeModel extends ViewStateRefreshListModel {
  // 轮播
  List<Banner> _banners;
  // 置顶文章列表
  List<Article> _topArticles;

  List<Banner> get banners => _banners;
  List<Article> get topArticles => _topArticles;

  @override
  Future<List> loadData({int pageNum}) async {
    List<Future> futures = [];
    if (pageNum == ViewStateRefreshListModel.pageNumFirst) {
      futures.add(WanAndroidRepository.fetchBanners());
      futures.add(WanAndroidRepository.fetchTopArticles());
    }
    futures.add(WanAndroidRepository.fetchArticles(pageNum));

    var result = await Future.wait(futures);
    if (pageNum == ViewStateRefreshListModel.pageNumFirst) {
      _banners = result[0];
      _topArticles = result[1];
      return result[2];
    }

    return result[0];
  }

  @override
  onCompleted(List data) {
    GlobalFavouriteStateModel.refresh(data);
  }

}