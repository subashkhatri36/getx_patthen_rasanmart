import 'package:get/get.dart';

import 'package:rasan_mart/app/modules/account/bindings/account_binding.dart';
import 'package:rasan_mart/app/modules/account/views/account_view.dart';
import 'package:rasan_mart/app/modules/authentication/bindings/authentication_binding.dart';
import 'package:rasan_mart/app/modules/authentication/views/authentication_view.dart';
import 'package:rasan_mart/app/modules/cart/bindings/cart_binding.dart';
import 'package:rasan_mart/app/modules/cart/views/cart_view.dart';
import 'package:rasan_mart/app/modules/home/bindings/home_binding.dart';
import 'package:rasan_mart/app/modules/home/views/home_view.dart';
import 'package:rasan_mart/app/modules/nointernet/bindings/nointernet_binding.dart';
import 'package:rasan_mart/app/modules/nointernet/views/nointernet_view.dart';
import 'package:rasan_mart/app/modules/notificationpage/bindings/notificationpage_binding.dart';
import 'package:rasan_mart/app/modules/notificationpage/views/notificationpage_view.dart';
import 'package:rasan_mart/app/modules/productCategory/bindings/product_category_binding.dart';
import 'package:rasan_mart/app/modules/productCategory/views/product_category_view.dart';
import 'package:rasan_mart/app/modules/productdetail/bindings/productdetail_binding.dart';
import 'package:rasan_mart/app/modules/productdetail/views/productdetail_view.dart';
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
    GetPage(
      name: _Paths.ACCOUNT,
      page: () => AccountView(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCTDETAIL,
      page: () => ProductdetailView(),
      binding: ProductdetailBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONPAGE,
      page: () => NotificationpageView(),
      binding: NotificationpageBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_CATEGORY,
      page: () => ProductCategoryView(),
      binding: ProductCategoryBinding(),
    ),
  ];
}
