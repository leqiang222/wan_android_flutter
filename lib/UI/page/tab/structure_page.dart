import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wan_android_flutter/config/router_manager.dart';
import 'package:wan_android_flutter/model/navigation_site.dart';
import 'package:wan_android_flutter/model/tree.dart';
import 'package:wan_android_flutter/provider/provider_widget.dart';
import 'package:wan_android_flutter/view_model/structure_model.dart';

/// 体系
class StructurePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StructurePageState();
  }
}

class _StructurePageState extends State<StructurePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<String> _tabs = ['体系', '导航'];

  AppBar createAppBar() {
    return AppBar(
      title: TabBar(
          isScrollable: true,
          tabs: List.generate(_tabs.length, (index) {
            return Tab(text: _tabs[index]);
          })),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: createAppBar(),
        body: TabBarView(
            children: [StructureCategoryList(), NavigationSiteCategoryList()]),
      ),
    );
  }
}

/// 体系->体系
class StructureCategoryList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StructureCategoryListState();
  }
}

class _StructureCategoryListState extends State<StructureCategoryList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  // 创建列表容器
  Widget createScrollView(StructureCategoryModel model) {
    return Scrollbar(
        // Scrollbar的作用是添加滚动指示条
        child: ListView.builder(
            padding: EdgeInsets.all(15),
            itemCount: model.list.length,
            itemBuilder: (context, index) {
              Tree item = model.list[index];
              return StructureCategoryWidget(item);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<StructureCategoryModel>(
      model: StructureCategoryModel(),
      onModelReady: (model) {
        model.initData();
      },
      builder: (context, model, child) {
//        if (model.busy) {
//          return ViewStateBusyWidget();
//        }
//
//        if (model.error && model.list.isEmpty) {
//          return ViewStateErrorWidget(error: model.viewStateError, onPressed: model.initData);
//        };

        return createScrollView(model);
      },
    );
  }
}

class StructureCategoryWidget extends StatelessWidget {
  final Tree tree;

  StructureCategoryWidget(this.tree);

  // 组标题
  Widget createTitleView(BuildContext context) {
    return Text(
      tree.name,
      style: Theme.of(context).textTheme.subtitle,
    );
  }

  // 标签tag
  Widget createTagsView(BuildContext context) {
    return Wrap(
        spacing: 10,
        children: List.generate(tree.children.length, (index) {
          return ActionChip(
            label: Text(
              tree.children[index].name,
              maxLines: 1,
            ),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(RouteName.structureList, arguments: [tree, index]);
            },
          );
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // 标题
          createTitleView(context),
          createTagsView(context)
        ],
      ),
    );
  }
}

/// 体系->公众号
class NavigationSiteCategoryList extends StatefulWidget {
  @override
  _NavigationSiteCategoryListState createState() =>
      _NavigationSiteCategoryListState();
}

class _NavigationSiteCategoryListState extends State<NavigationSiteCategoryList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  // 创建列表容器
  Widget createScrollView(NavigationSiteModel model) {
    return Scrollbar(
      child: ListView.builder(
          padding: EdgeInsets.all(15),
          itemCount: model.list.length,
          itemBuilder: (context, index) {
            NavigationSite item = model.list[index];
            return NavigationSiteCategoryWidget(item);
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<NavigationSiteModel>(
        model: NavigationSiteModel(),
        onModelReady: (model) {
          model.initData();
        },
        builder: (context, model, child) {
//          if (model.busy) {
//            return ViewStateBusyWidget();
//          }
//          if (model.error) {
//            return ViewStateErrorWidget(error: model.viewStateError, onPressed: model.initData);
//          }
          return createScrollView(model);
        });
  }
}

class NavigationSiteCategoryWidget extends StatelessWidget {
  final NavigationSite site;

  NavigationSiteCategoryWidget(this.site);

  // 组标题
  Widget createTitleView(BuildContext context) {
    return Text(
      site.name,
      style: Theme.of(context).textTheme.subtitle,
    );
  }

  // 标签tag
  Widget createTagsView(BuildContext context) {
    return Wrap(
        spacing: 10,
        children: List.generate(
            site.articles.length,
            (index) => ActionChip(
                  onPressed: () {
                    Navigator.of(context).pushNamed(RouteName.articleDetail,
                        arguments: site.articles[index]);
                  },
                  label: Text(
                    site.articles[index].title,
                    maxLines: 1,
                  ),
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          createTitleView(context),
          createTagsView(context),
        ],
      ),
    );
  }
}
