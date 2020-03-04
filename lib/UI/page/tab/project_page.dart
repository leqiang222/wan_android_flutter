import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wan_android_flutter/UI/page/article/article_list_page.dart';
import 'package:wan_android_flutter/model/tree.dart';
import 'package:wan_android_flutter/provider/provider_widget.dart';
import 'package:wan_android_flutter/provider/view_state_list_model.dart';
import 'package:wan_android_flutter/provider/view_state_widget.dart';
import 'package:wan_android_flutter/view_model/project_model.dart';

class ProjectPage extends StatefulWidget {
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  ValueNotifier<int> valueNotifier;
  TabController tabController;

  @override
  void initState() {
    valueNotifier = ValueNotifier(0);
    super.initState();
  }

  @override
  void dispose() {
    valueNotifier.dispose();
    super.dispose();
  }

  AppBar createAppBar(List<Tree> treeList, BuildContext context) {
    return AppBar(
      title: Stack( // 用Stack, 标题滚动栏遮挡下拉栏
        children: <Widget>[
          CategoryDropdownWidget(
              Provider.of<ProjectCategoryModel>(context)),
          Container(
            margin: const EdgeInsets.only(right: 30),
            color: Theme.of(context).primaryColor.withOpacity(1),
            child: TabBar(
              isScrollable: true,
              tabs: List.generate(treeList.length, (index) {
                return Tab(text: treeList[index].name);
              }),
            ),
          )
        ],
      ),
    );
  }

  TabBarView createTabBarView(List<Tree> treeList) {
    return TabBarView(
      children: List.generate(treeList.length, (index) {
        return ArticleListPage(treeList[index].id);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<ProjectCategoryModel>(
      model: ProjectCategoryModel(),
      onModelReady: (ProjectCategoryModel model) {
        model.initData();
      },
      builder:
          (BuildContext context, ProjectCategoryModel value, Widget child) {
        if (value.busy) {
          return ViewStateBusyWidget();
        }
        if (value.error) {
          return ViewStateErrorWidget(error: value.viewStateError, onPressed: value.initData);
        }

        List<Tree> treeList = value.list;
        var primaryColor = Theme.of(context).primaryColor;

        return ValueListenableProvider<int>.value(
          value: valueNotifier,
          child: DefaultTabController(
            length: value.list.length,
            initialIndex: valueNotifier.value,
            child: Builder(builder: (context) {
              if (tabController == null) {
                tabController = DefaultTabController.of(context);
                tabController.addListener(() {
                  valueNotifier.value = tabController.index;
                });
              }

              return Scaffold(
                appBar: createAppBar(treeList, context),
                body: createTabBarView(treeList),
              );
            }),
          ),
        );
      },
    );
  }
}

class CategoryDropdownWidget extends StatelessWidget {
  final ViewStateListModel model;
  CategoryDropdownWidget(this.model);

  @override
  Widget build(BuildContext context) {
    int currentIndex = Provider.of<int>(context);

    return Align(
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Theme.of(context).primaryColor,
        ),
        child: DropdownButtonHideUnderline(
            child: DropdownButton(
          elevation: 0,
          value: currentIndex,
          style: Theme.of(context).primaryTextTheme.subhead,
          items: List.generate(model.list.length, (index) {
            var theme = Theme.of(context);
            var subhead = theme.primaryTextTheme.subhead;
            return DropdownMenuItem(
              value: index,
              child: Text(
                model.list[index].name,
                style: currentIndex == index
                    ? subhead.apply(
                        fontSizeFactor: 1.15,
                        color: theme.brightness == Brightness.light
                            ? Colors.white
                            : theme.accentColor)
                    : subhead.apply(color: subhead.color.withAlpha(200)),
              ),
            );
          }),
          onChanged: (value) {
            DefaultTabController.of(context).animateTo(value);
          },
          isExpanded: true,
          icon: Container(
            child: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
            ),
          ),
        )),
      ),
      alignment: Alignment(1.1, -1),
    );
  }
}
