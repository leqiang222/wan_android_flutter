import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_flutter/UI/helper/refresh_helper.dart';
import 'package:wan_android_flutter/UI/widget/article_list_Item.dart';
import 'package:wan_android_flutter/UI/widget/article_skeleton.dart';
import 'package:wan_android_flutter/UI/widget/skeleton.dart';
import 'package:wan_android_flutter/config/resource_manager.dart';
import 'package:wan_android_flutter/model/article.dart';
import 'package:wan_android_flutter/model/tree.dart';
import 'package:wan_android_flutter/provider/provider_widget.dart';
import 'package:wan_android_flutter/provider/view_state_widget.dart';
import 'package:wan_android_flutter/view_model/structure_model.dart';

/// 文章列表页面
class ArticleListPage extends StatefulWidget {
  /// 目录id
  final int cid;

  ArticleListPage(this.cid);

  @override
  _ArticleListPageState createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Widget buildHeader2(BuildContext context, RefreshStatus mode){
    return Center(
        child:Text(
            mode == RefreshStatus.idle ? "下拉刷新":mode==RefreshStatus.refreshing?"刷新中...":
        mode==RefreshStatus.canRefresh?"可以松手了!":mode==RefreshStatus.completed?"刷新成功!":"刷新失败"
        )
    );
  }

  Widget buildHeader(BuildContext context, RefreshStatus mode) {
    String message = mode == RefreshStatus.idle ? "下拉刷新":mode==RefreshStatus.refreshing?"加载中...":
    mode==RefreshStatus.canRefresh?"释放加载":mode==RefreshStatus.completed?"刷新成功!":"刷新失败";
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      height: 44,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Positioned(
            left: MediaQuery.of(context).size.width * 0.5 - 30 - 64,
            child: Image.asset(
              ImageHelper.wrapAssets("logo_weibo.png"),
              width: 44,
              height: 44,
            ),
          ),
          Positioned(
            child: Text(message),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<StructureListModel>(
      model: StructureListModel(widget.cid),
      onModelReady: (model) => model.initData(),
      builder: (context, model, child) {
        if (model.busy) {
          return SkeletonList(
            builder: (context, index) => ArticleSkeletonItem(),
          );
        }
        if (model.error && model.list.isEmpty) {
          return ViewStateErrorWidget(
              error: model.viewStateError, onPressed: model.initData);
        }
        if (model.empty) {
          return ViewStateEmptyWidget(onPressed: model.initData);
        }
        return SmartRefresher(
            controller: model.refreshController,
            header: CustomHeader(
              builder: buildHeader,
            ),
//            header: WaterDropHeader(),
            footer: RefresherFooter(),
            onRefresh: model.refresh,
            onLoading: model.loadMore,
            enablePullUp: true,
            child: ListView.builder(
                itemCount: model.list.length,
                itemBuilder: (context, index) {
                  Article item = model.list[index];
                  return ArticleItemWidget(item);
                }));
      },
    );
  }
}

/// 体系--> 选择相关知识点的详情页
class ArticleCategoryTabPage extends StatelessWidget {
  final Tree tree;
  final int index;

  ArticleCategoryTabPage(this.tree, this.index);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tree.children.length,
      initialIndex: index,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(tree.name),
            bottom: TabBar(
                isScrollable: true,
                tabs: List.generate(
                    tree.children.length,
                    (index) => Tab(
                          text: tree.children[index].name,
                        ))),
          ),
          body: TabBarView(
            children: List.generate(tree.children.length,
                (index) => ArticleListPage(tree.children[index].id)),
          )),
    );
  }
}
