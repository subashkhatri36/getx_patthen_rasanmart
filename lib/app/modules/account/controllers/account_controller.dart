import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rasan_mart/app/Widgets/snakbar.dart';
import 'package:rasan_mart/app/data/account/account_repository.dart';
import 'package:rasan_mart/app/modules/account/address_model.dart';
import 'package:rasan_mart/app/modules/account/providers/userdata_provider.dart';
import 'package:rasan_mart/app/modules/authentication/controllers/mainauth_controller.dart';
import 'package:rasan_mart/app/modules/cart/controllers/cart_controller.dart';

class AccountController extends GetxController {
  RxList<AddressModel> addressList;
  RxString userName = 'Profile Name'.obs;
  RxString userEmail = 'Email Address'.obs;
  RxString userPhone = 'User phone No'.obs;
  final auth = Get.find<MainauthController>().firebaseAuth;
  var user;
  RxString userImage = 'assets/images/logo.PNG'.obs;
  RxString uId = ''.obs;

  RxBool isImageNetwork = false.obs;
  RxBool isImageUploading = false.obs;
  RxBool isLoading = false.obs;
  RxBool isLogOut = true.obs;

  RxList<AddressModel> userAddress;

  File image;

  TextEditingController userInputName = new TextEditingController();
  TextEditingController userInputPhone = new TextEditingController();

  UserdataProvider accountRepositiories = AccountRepositiories();

  final count = 0.obs;

  @override
  void onInit() {
    user = auth.currentUser.obs;
    print(user);
    super.onInit();
    fetchUserInfo();
     fetchUserAddress();
  }

  Future<void> fetchUserAddress() async {
    List<AddressModel> newuserAddress = [];

    Either<String, List<AddressModel>> myAddress =
        await accountRepositiories.getUserAddress(uId.value);
    myAddress.fold(
        (l) => CustomeSnackbar(
              title: 'Failed',
              icon: Icon(Icons.warning),
              message: l.toString(),
            ), (r) {
      newuserAddress = r.toList();
      userAddress = newuserAddress.obs;
    });
  }

  String fetchingSingleAddress() {
    if (userAddress.length < 1) {
      fetchUserAddress();
    }
    String addressValue = '';
    AddressModel addressModel;
    userAddress.asMap().forEach((key, value) {
      if (value.isSelected) {
        addressModel = value;
      }
    });
    if (addressModel != null) {
      addressValue = addressModel.landmark +
          ' ' +
          addressModel.tol +
          ' ' +
          addressModel.place +
          ', ' +
          addressModel.city +
          ', ' +
          addressModel.muncipalit +
          ', ' +
          addressModel.state +
          ',' +
          addressModel.zipcode +
          ' \n' +
          'Phone : ' +
          addressModel.phoneno;
    }
    return addressValue;
  }

  void fetchUserInfo() async {
    isLoading.value = true;
    var id = FirebaseAuth.instance.currentUser?.uid ?? '';
    if (id.isNotEmpty) {
      uId.value = id;
      Either<String, UserDetail> value =
          await accountRepositiories.fetchUserData(id);
      value.fold((l) => print('Error on Fetching data'), (r) {
        if (r.userName != null && r.userName.isNotEmpty)
          userName.value = r.userName;

        if (r.userEmail != null && r.userEmail.isNotEmpty)
          userEmail.value = r.userEmail;

        if (r.phone != null && r.phone.isNotEmpty) userPhone.value = r.phone;
        if (r.photo != null && r.photo.isNotEmpty) {
          isImageNetwork.value = true;
          userImage.value = r.photo;
        }
      });
    }
    isLoading.value = false;
  }

  void logOut() {
    auth.signOut();
    isLogOut.value = true;
    clearData();
  }

  void clearData() {
    Get.find<CartController>().cartList.clear();
    userEmail.value = 'User Email';

    userPhone.value = 'User Phone Number';
    userImage.value = 'assets/images/logo.PNG';
  }

  void updateUserInfo() async {
    if (userInputPhone.text.length == 10 && userInputName.text.length > 2) {
      UserDetail userDetail = new UserDetail(
          userName: userInputName.text,
          userEmail: userEmail.value,
          photo: userImage.value,
          phone: userInputPhone.text);

      Either<String, String> userUpdate =
          await accountRepositiories.updateUserData(userDetail, uId.value);
      userUpdate.fold(
          (l) => CustomeSnackbar(
                title: 'Updating Failed !',
                icon: Icon(Icons.warning),
                message: l.toString(),
              ), (r) {
        CustomeSnackbar(
          title: 'Successful',
          icon: Icon(Icons.info),
          message: r,
        );
        userName.value = userInputName.text;
        userPhone.value = userInputPhone.text;
      });
    } else {
      CustomeSnackbar(
        title: 'Updating Failed !',
        icon: Icon(Icons.warning),
        message: 'Not a valid Data.',
      );
    }
  }

  Future getImage(bool gallery) async {
    ImagePicker picker = ImagePicker();
    PickedFile pickedFile;

    // Let user select photo from gallery
    if (gallery) {
      pickedFile = await picker.getImage(
        source: ImageSource.gallery,
      );
    }
    // Otherwise open camera to get new photo
    else {
      pickedFile = await picker.getImage(
        source: ImageSource.camera,
      );
    }

    if (pickedFile != null) {
      isImageUploading.value = true;
      // image.add(File(pickedFile.path));
      image = File(pickedFile.path).obs();
      final id = FirebaseAuth.instance.currentUser.uid;
      if (id != null) {
        Either<String, String> uploaded =
            await accountRepositiories.uploadImage(image, id);
        uploaded.fold((l) {
          print(l);
        }, (r) {
          userImage.value = r;
          isImageNetwork.value = true;
        });
        isImageUploading.value = false;

        //_image = File(pickedFile.path); // Use if you only need a single picture
      } else {
        print('No image selected.');
      }
      isImageUploading.value = false;
    }

    @override
    void onReady() {
      super.onReady();
    }

    @override
    void onClose() {}
  }
}
