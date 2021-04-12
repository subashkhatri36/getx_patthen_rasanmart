import 'package:get/get.dart';

import 'package:rasan_mart/app/modules/account/bindings/account_binding.dart';
import 'package:rasan_mart/app/modules/account/views/account_view.dart';
import 'package:rasan_mart/app/modules/addAddress/bindings/add_address_binding.dart';
import 'package:rasan_mart/app/modules/addAddress/views/add_address_view.dart';
import 'package:rasan_mart/app/modules/authentication/bindings/authentication_binding.dart';
import 'package:rasan_mart/app/modules/authentication/views/authentication_view.dart';
import 'package:rasan_mart/app/modules/cart/bindings/cart_binding.dart';
import 'package:rasan_mart/app/modules/cart/views/cart_view.dart';
import 'package:rasan_mart/app/modules/checkout/bindings/checkout_binding.dart';
import 'package:rasan_mart/app/modules/checkout/views/checkout_view.dart';
import 'package:rasan_mart/app/modules/conformation/bindings/conformation_binding.dart';
import 'package:rasan_mart/app/modules/conformation/views/conformation_view.dart';
import 'package:rasan_mart/app/modules/conformdelivery/bindings/conformdelivery_binding.dart';
import 'package:rasan_mart/app/modules/conformdelivery/views/conformdelivery_view.dart';
import 'package:rasan_mart/app/modules/deliveryviewall/bindings/deliveryviewall_binding.dart';
import 'package:rasan_mart/app/modules/deliveryviewall/views/deliveryviewall_view.dart';
import 'package:rasan_mart/app/modules/forgetpassword/bindings/forgetpassword_binding.dart';
import 'package:rasan_mart/app/modules/forgetpassword/views/forgetpassword_view.dart';
import 'package:rasan_mart/app/modules/home/bindings/home_binding.dart';
import 'package:rasan_mart/app/modules/home/views/home_view.dart';
import 'package:rasan_mart/app/modules/nointernet/bindings/nointernet_binding.dart';
import 'package:rasan_mart/app/modules/nointernet/views/nointernet_view.dart';
import 'package:rasan_mart/app/modules/notificationpage/bindings/notificationpage_binding.dart';
import 'package:rasan_mart/app/modules/notificationpage/views/notificationpage_view.dart';
import 'package:rasan_mart/app/modules/orderdetails/bindings/orderdetails_binding.dart';
import 'package:rasan_mart/app/modules/orderdetails/views/orderdetails_view.dart';
import 'package:rasan_mart/app/modules/otpverification/bindings/otpverification_binding.dart';
import 'package:rasan_mart/app/modules/otpverification/views/otpverification_view.dart';
import 'package:rasan_mart/app/modules/productCategory/bindings/product_category_binding.dart';
import 'package:rasan_mart/app/modules/productCategory/views/product_category_view.dart';
import 'package:rasan_mart/app/modules/productdetail/bindings/productdetail_binding.dart';
import 'package:rasan_mart/app/modules/productdetail/views/productdetail_view.dart';
import 'package:rasan_mart/app/modules/productview/bindings/productview_binding.dart';
import 'package:rasan_mart/app/modules/productview/views/productview_view.dart';
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
    GetPage(
      name: _Paths.ADD_ADDRESS,
      page: () => AddAddressView(),
      binding: AddAddressBinding(),
    ),
    GetPage(
      name: _Paths.CHECKOUT,
      page: () => CheckoutView(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: _Paths.CONFORMATION,
      page: () => ConformationView(),
      binding: ConformationBinding(),
    ),
    GetPage(
      name: _Paths.OTPVERIFICATION,
      page: () => OtpverificationView(),
      binding: OtpverificationBinding(),
    ),
    GetPage(
      name: _Paths.CONFORMDELIVERY,
      page: () => ConformdeliveryView(),
      binding: ConformdeliveryBinding(),
    ),
    GetPage(
      name: _Paths.DELIVERYVIEWALL,
      page: () => DeliveryviewallView(),
      binding: DeliveryviewallBinding(),
    ),
    GetPage(
      name: _Paths.ORDERDETAILS,
      page: () => OrderdetailsView(),
      binding: OrderdetailsBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCTVIEW,
      page: () => ProductviewView(),
      binding: ProductviewBinding(),
    ),
    GetPage(
      name: _Paths.FORGETPASSWORD,
      page: () => ForgetpasswordView(),
      binding: ForgetpasswordBinding(),
    ),
  ];
}
