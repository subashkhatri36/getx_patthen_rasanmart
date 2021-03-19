import 'package:get/get.dart';

import 'package:rasan_mart/app/modules/authentication/bindings/authentication_binding.dart';
import 'package:rasan_mart/app/modules/authentication/views/authentication_view.dart';
import 'package:rasan_mart/app/modules/home/bindings/home_binding.dart';
import 'package:rasan_mart/app/modules/home/views/home_view.dart';
import 'package:rasan_mart/app/modules/nointernet/bindings/nointernet_binding.dart';
import 'package:rasan_mart/app/modules/nointernet/views/nointernet_view.dart';
import 'package:rasan_mart/app/modules/searchpage/bindings/searchpage_binding.dart';
import 'package:rasan_mart/app/modules/searchpage/views/searchpage_view.dart';
import 'package:rasan_mart/app/modules/splash/bindings/splash_binding.dart';
import 'package:rasan_mart/app/modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.AUTHENTICATION,
      page: () => AuthenticationView(),
      binding: AuthenticationBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.SEARCHPAGE,
      page: () => SearchpageView(),
      binding: SearchpageBinding(),
    ),
    GetPage(
      name: _Paths.NOINTERNET,
      page: () => NointernetView(),
      binding: NointernetBinding(),
    ),
  ];
}
