import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rasan_mart/app/Widgets/snakbar.dart';
import 'package:rasan_mart/app/data/account/account_repository.dart';
import 'package:rasan_mart/app/data/address/address_repository.dart';
import 'package:rasan_mart/app/modules/account/address_model.dart';
import 'package:rasan_mart/app/modules/account/controllers/account_controller.dart';
import 'package:rasan_mart/app/modules/account/providers/userdata_provider.dart';
import 'package:rasan_mart/app/modules/addAddress/providers/address_provider.dart';
import 'package:rasan_mart/app/modules/authentication/controllers/mainauth_controller.dart';

class AddAddressController extends GetxController {
  TextEditingController cityController = new TextEditingController();
  TextEditingController landmarkController = new TextEditingController();
  TextEditingController muncipalityController = new TextEditingController();
  TextEditingController phonenoController = new TextEditingController();
  TextEditingController placeController = new TextEditingController();
  TextEditingController tolController = new TextEditingController();
  TextEditingController zipcodeController = new TextEditingController();

  final controllerAccount = Get.find<AccountController>();

  UserdataProvider accountRepositiories = AccountRepositiories();

  RxList<AddressModel> newAddress;
  RxBool isAddressLoad = false.obs;

  AddressProvider addressProvider = AddressRepository();

  final auth = Get.find<MainauthController>().firebaseAuth;

  RxString uId = ''.obs;
  RxInt selectedIndex = 0.obs;

  List<String> state = [
    'Select State',
    'Province No. 1',
    'Province No. 2',
    'Bagmati Province',
    'Gandaki Province',
    'Lumbini Province',
    'Karnali Province',
    'Sudurpashchim Province',
  ];
  RxString stateValue = ''.obs;

  @override
  void onInit() {
    fetchUserAddress();
    super.onInit();
  }

  Future<void> fetchUserAddress() async {
    isAddressLoad.value = true;
    List<AddressModel> newuserAddress = [];
    uId = auth.currentUser.uid.obs;
    if (uId.isNotEmpty) {
      Either<String, List<AddressModel>> myAddress =
          await accountRepositiories.getUserAddress(uId.value);
      myAddress.fold(
          (l) => CustomeSnackbar(
                title: 'Failed',
                icon: Icon(Icons.warning),
                message: l.toString(),
              ), (r) {
        newuserAddress = r.toList();
        newAddress = newuserAddress.obs;
      });
    }
    isAddressLoad.value = false;
  }

  changeList(int changeIndex) {
    List<AddressModel> temp = newAddress;
    temp[changeIndex].isSelected = true;
    temp[selectedIndex.value].isSelected = false;
    newAddress = temp.obs;
  }

  Future<bool> saveAddress(String state) async {
    bool val = false;
    AddressModel addressModel = new AddressModel(
      tol: tolController.text,
      landmark: landmarkController?.text ?? '',
      place: placeController.text,
      city: cityController.text,
      muncipalit: muncipalityController.text,
      state: state,
      zipcode: zipcodeController.text,
      phoneno: phonenoController.text,
      isSelected: false,
    );
    var id = FirebaseAuth.instance.currentUser?.uid ?? "";
    if (id.isNotEmpty && id != null) {
      Either<String, String> result =
          await addressProvider.savedAddress(id, addressModel);
      result.fold((l) {
        CustomeSnackbar(
          title: 'Addresses !',
          message: 'Failed to Save Address \nCheck your data!.',
          icon: Icon(Icons.error),
        );
      }, (r) {
        CustomeSnackbar(
          title: 'Added !',
          message: 'Successfully Added Address.',
          icon: Icon(Icons.error),
        );
        val = true;
      });
    }
    return val;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    cityController.dispose();
    landmarkController.dispose();
    muncipalityController.dispose();
    phonenoController.dispose();
    placeController.dispose();
    tolController.dispose();
    zipcodeController.dispose();
  }
}
