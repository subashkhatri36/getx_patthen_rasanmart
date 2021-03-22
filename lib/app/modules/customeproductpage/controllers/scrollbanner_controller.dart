import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rasan_mart/app/Widgets/snakbar.dart';
import 'package:rasan_mart/app/data/Banner/scroll_banner_repository.dart';
import 'package:rasan_mart/app/modules/customeproductpage/scroll_banner_model.dart';

class ScrollbannerController extends GetxController {
  RxList<ScrollBanner> scrollbanner;
  RxBool isScrollBannerLoading = false.obs;
  BannerRepo bannerRepo = new ScrollBannerRepository();

  final count = 0.obs;
  @override
  void onInit() {
    fetchscrollBanner();
    super.onInit();
  }

  fetchscrollBanner() async {
    isScrollBannerLoading.toggle();

    Either<String, List<ScrollBanner>> banner =
        await bannerRepo.fetchScrollBanner();
    banner.fold(
        (l) => CustomeSnackbar(
              title: 'Error on Banner',
              message: l.toString(),
              icon: Icon(Icons.warning),
            ),
        (r) => scrollbanner = r.toList().obs);

    isScrollBannerLoading.toggle();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
