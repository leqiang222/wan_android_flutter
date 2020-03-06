import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:wan_android_flutter/UI/widget/banner_image.dart';
import 'package:wan_android_flutter/config/router_manager.dart';
import 'package:wan_android_flutter/model/article.dart';
import 'package:wan_android_flutter/view_model/home_model.dart';

class BannerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Consumer<HomeModel>(builder: (_, homeModel, __) {
        if (homeModel.busy) {
          return CupertinoActivityIndicator();
        }

        var banners = homeModel?.banners ?? [];
        return Swiper(
          loop: true,
          autoplay: true,
          autoplayDelay: 5000,
          pagination: SwiperPagination(),
          itemCount: banners.length,
          itemBuilder: (ctx, index) {
            return InkWell(
                onTap: () {
                  var banner = banners[index];
                  Navigator.of(context).pushNamed(RouteName.articleDetail,
                      arguments: Article()
                        ..id = banner.id
                        ..title = banner.title
                        ..link = banner.url
                        ..collect = false);
                },
                child: BannerImage(banners[index].imagePath));
          },
        );
      }),
    );
  }

}