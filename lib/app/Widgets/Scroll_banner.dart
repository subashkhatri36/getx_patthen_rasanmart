import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';
import 'package:rasan_mart/app/modules/customeproductpage/controllers/scrollbanner_controller.dart';

class BannerScrollImage extends StatelessWidget {
  final scrollController = Get.put(ScrollbannerController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Defaults.defaultfontsize),
      child: Obx(() => scrollController.isScrollBannerLoading.isTrue
          ? Container()
          : CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
              ),
              items: scrollController.scrollbanner
                  .map(
                    (item) => CachedNetworkImage(
                      imageUrl: item.imagepath,
                      width: MediaQuery.of(context).size.width,
                      fadeInDuration: Duration(milliseconds: 1),
                      imageBuilder: (context, imageProvider) => Container(
                        width: 3000.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  )
                  .toList())),
    );
  }
}
