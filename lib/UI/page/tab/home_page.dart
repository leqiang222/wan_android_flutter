

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_flutter/UI/helper/refresh_helper.dart';
import 'package:wan_android_flutter/UI/page/tab/banner_widget.dart';
import 'package:wan_android_flutter/UI/widget/animated_provider.dart';
import 'package:wan_android_flutter/UI/widget/article_list_Item.dart';
import 'package:wan_android_flutter/UI/widget/article_skeleton.dart';
import 'package:wan_android_flutter/UI/widget/skeleton.dart';
import 'package:wan_android_flutter/model/article.dart';
import 'package:wan_android_flutter/provider/provider_widget.dart';
import 'package:wan_android_flutter/provider/view_state_widget.dart';
import 'package:wan_android_flutter/util/status_bar_utils.dart';
import 'package:wan_android_flutter/view_model/home_model.dart';
import 'package:wan_android_flutter/view_model/tap_to_top_model.dart';

const double kHomeRefreshHeight = 180.0;

class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

// AutomaticKeepAliveClientMixin: 切换tab后保留tab的状态，避免initState方法重复调用
class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Widget build(BuildContext context) {
    // 轮播高度
    var bannerHeight = MediaQuery.of(context).size.width * 5 / 11;

    return ProviderWidget2<HomeModel, TapToTopModel>(
        model1: HomeModel(),
        model2: TapToTopModel(PrimaryScrollController.of(context), height: bannerHeight - kToolbarHeight),
        onModelReady: (homeModel, tapToTopModel) {
          homeModel.initData();
          tapToTopModel.init();
        },
        builder: (context, homeModel, tapToTopModel, child) {
          return Scaffold(
            body: MediaQuery.removePadding(
              context: context,
              child: Builder(builder: (_){
                if (homeModel.error && homeModel.list.isEmpty) {
                  return AnnotatedRegion<SystemUiOverlayStyle>(
                      value: StatusBarUtils.systemUiOverlayStyle(context),
                      child: ViewStateErrorWidget(
                          error: homeModel.viewStateError,
                          onPressed: homeModel.initData));
                }

//                return RefreshConfiguration.copyAncestor(
//                    context: context,
                return SmartRefresher(
                      controller: homeModel.refreshController,
                      footer: RefresherFooter(),
                      enablePullDown: homeModel.list.isNotEmpty,
                      onRefresh: () async {
                        await homeModel.refresh();
                        homeModel.showErrorMessage(context);
                      },
                      onLoading: homeModel.loadMore,
                      enablePullUp: homeModel.list.isNotEmpty,
                      child: CustomScrollView(
                        controller: tapToTopModel.scrollController,
                        slivers: <Widget>[
                          SliverToBoxAdapter(),
                          SliverAppBar(
                            pinned: true,
                            expandedHeight: bannerHeight,
                            // 加载中并且亮色模式下,状态栏文字为黑色
                            brightness: Theme.of(context).brightness ==
                                Brightness.light &&
                                homeModel.busy
                                ? Brightness.light
                                : Brightness.dark,
                            flexibleSpace: FlexibleSpaceBar(
                              title: const Text('玩安卓'),
                              background: BannerWidget(),
                            ),
                            actions: <Widget>[
                                /// appbar搜索按钮
                                EmptyAnimatedSwitcher(
                                  display: tapToTopModel.showTopBtn,
                                  child: IconButton(
                                    icon: Icon(Icons.search),
                                    onPressed: () {
//                                      showSearch(
//                                          context: context,
//                                          delegate: DefaultSearchDelegate());
                                    },
                                  ),
                                )
                              ],
                            ),
                            if (homeModel.empty)
                            SliverToBoxAdapter(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 50),
                                  child: ViewStateEmptyWidget(
                                      onPressed: homeModel.initData),
                                )),
                            if (homeModel.topArticles?.isNotEmpty ?? false)
                            HomeTopArticleList(),
                            HomeArticleList(),
                        ],
                      ),
                    );
//                );
              }),
            ),
          );
        },
    );
  }

}

class HomeTopArticleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeModel homeModel = Provider.of(context);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          Article item = homeModel.topArticles[index];
          return ArticleItemWidget(
            item,
            index: index,
            top: true,
          );
        },
        childCount: homeModel.topArticles?.length ?? 0,
      ),
    );
  }
}

class HomeArticleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeModel homeModel = Provider.of(context);
    if (homeModel.busy) {
      return SliverToBoxAdapter(
        child: SkeletonList(
          builder: (context, index) => ArticleSkeletonItem(),
        ),
      );
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          Article item = homeModel.list[index];
          return ArticleItemWidget(
            item,
            index: index,
          );
        },
        childCount: homeModel.list?.length ?? 0,
      ),
    );
  }
}
