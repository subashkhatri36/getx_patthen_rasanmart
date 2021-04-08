import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:rasan_mart/app/Widgets/buttons/buttons_widgets.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';
import 'package:rasan_mart/app/core/theme/app_theme.dart';
import 'package:rasan_mart/app/modules/account/views/order_view.dart';
import 'package:rasan_mart/app/modules/account/views/user_info_edit.dart';
import 'package:rasan_mart/app/modules/addAddress/controllers/add_address_controller.dart';
import 'package:rasan_mart/app/modules/addAddress/views/add_address_view.dart';
import 'package:rasan_mart/app/modules/addAddress/views/address_selected_navigation.dart';
import 'package:rasan_mart/app/modules/authentication/views/authentication_view.dart';
import 'package:rasan_mart/app/modules/checkout/controllers/delivery_controller.dart';
import 'package:rasan_mart/app/modules/checkout/delivery_model.dart';
import 'package:rasan_mart/app/modules/deliveryviewall/views/deliveryviewall_view.dart';

import '../controllers/account_controller.dart';

class AccountView extends GetView<AccountController> {
  // final user = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
    var val = FirebaseAuth.instance?.currentUser ?? null;
    if (val != null) {
      controller.isLogOut.value = false;
      controller.fetchUserInfo();
    }
    final addressController = Get.find<AddAddressController>();
    final deliveryController = Get.put(DeliveryController());
    return SingleChildScrollView(
        child: Obx(
      () => !controller.isLogOut.value
          ? Column(
              children: [
                AccountHeader(),
                GestureDetector(
                  onTap: () {
                    Get.to(() => AddAddressView(), arguments: [true, false]);
                  },
                  child: Container(
                      padding: EdgeInsets.all(Defaults.defaultPadding - 5),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Themes.lightcounterbtnColor)),
                      child: Row(
                        children: [
                          Icon(Icons.add),
                          SizedBox(width: Defaults.defaultPadding / 2),
                          Text('Add Address')
                        ],
                      )),
                ),
                Obx(() => addressController.isAddressUpdated.value
                    ? AddressSelectedWidget(
                        controller: addressController,
                        ischange: false,
                        isadd: false)
                    : AddressSelectedWidget(
                        controller: addressController,
                        ischange: false,
                        isadd: false)),
                Container(
                    padding: EdgeInsets.all(Defaults.defaultPadding - 5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Themes.lightcounterbtnColor)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.shopping_bag),
                        SizedBox(width: Defaults.defaultPadding / 2),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Current Order',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => DeliveryviewallView());
                                },
                                child: Text(
                                  'View All',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).backgroundColor),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
                Obx(() {
                  int lenght = deliveryController.deliveryModel?.length ?? 0;

                  return deliveryController.isDeliveryLoaded.isTrue
                      ? CircularProgressIndicator()
                      : lenght > 0
                          ? Container(
                              //   width: MediaQuery.of(context).size.width,
                              height: Defaults.defaultPadding * 10,
                              child: ListView.builder(
                                  reverse: true,
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: lenght,
                                  itemBuilder: (context, index) {
                                    DeliveryTotalModel model =
                                        deliveryController.deliveryModel[index];
                                    return model.orderStatus.toUpperCase() !=
                                            'Completed'.toUpperCase()
                                        ? OrderContiainer(model)
                                        : Container();
                                  }),
                            )
                          : Text('No Data');
                }),
                Container(
                  padding: EdgeInsets.all(Defaults.defaultfontsize / 2),
                  width: MediaQuery.of(context).size.width,
                  child: CustomeTextButton(
                    label: 'Log Out',
                    onPressed: () {
                      controller.logOut();
                    },
                    color: Theme.of(context).backgroundColor,
                  ),
                )
              ],
            )
          : SignIn(),
    ));
  }
}

class SignIn extends StatelessWidget {
  const SignIn({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 75,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'You can have Your Own Account',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          CustomeTextButton(
            label: 'Sing In',
            onPressed: () {
              Get.to(() => AuthenticationView());
            },
            color: Theme.of(context).backgroundColor,
          )
        ],
      ),
    );
  }
}

class AccountHeader extends StatelessWidget {
  const AccountHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userInfo = Get.find<AccountController>();
    return Stack(children: [
      Obx(() => Container(
          padding: EdgeInsets.only(top: Defaults.defaultfontsize),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .30,
          color: Theme.of(context).backgroundColor,
          child: userInfo.isLoading.isTrue
              ? Center(child: CircularProgressIndicator())
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: Defaults.defaultfontsize / 2),
                    Stack(
                      children: [
                        CircleAvatar(
                            foregroundColor: Theme.of(context).primaryColor,
                            backgroundColor: Colors.white,
                            radius: 60,
                            child: userInfo.isImageUploading.isTrue
                                ? Center(child: CircularProgressIndicator())
                                : Text(''),
                            backgroundImage: userInfo.isImageNetwork.value
                                ? NetworkImage(userInfo.userImage.value)
                                : userInfo.image != null
                                    ? FileImage(
                                        userInfo.image,
                                      )
                                    : AssetImage(
                                        'assets/images/logo.PNG',
                                      )),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            child: IconButton(
                                onPressed: () {
                                  userInfo.getImage(true);
                                },
                                icon: Icon(
                                  FontAwesomeIcons.camera,
                                  size: Defaults.defaultfontsize,
                                )),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: Defaults.defaultfontsize),
                    Text(
                      userInfo.userName.value,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Defaults.defaultPadding / 1.8,
                          color: Theme.of(context).primaryColor),
                    ),
                    SizedBox(height: Defaults.defaultfontsize / 3),
                    Text(
                      userInfo.userEmail.value,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Defaults.defaultPadding - 4,
                          color: Theme.of(context).primaryColor),
                    ),
                    SizedBox(height: Defaults.defaultfontsize / 3),
                    Text(
                      userInfo.userPhone.value,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Defaults.defaultPadding / 1.8,
                          color: Theme.of(context).primaryColor),
                    ),
                  ],
                ))),
      Positioned(
        top: 2,
        right: 2,
        child: IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(child: dialogInfo(context));
                  });
            },
            icon: Icon(
              FontAwesomeIcons.pencilAlt,
              color: Colors.white,
            )),
      )
    ]);
  }
}
