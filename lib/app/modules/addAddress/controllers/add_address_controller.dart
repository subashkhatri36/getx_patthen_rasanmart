import 'package:dartz/dartz.dart';
import 'package:dartz/dartz_unsafe.dart';
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
  AddressModel oldModel;
  RxBool isAddressLoad = false.obs;

  AddressProvider addressProvider = AddressRepository();

  RxInt selectedIndex = 0.obs;
  RxBool isAddressUpdated = false.obs;
  RxString selectedAddressString = ''.obs;
  RxBool isAddressEdit = false.obs;
  String id = '';

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
    var id = FirebaseAuth.instance.currentUser.uid;
    print(id);
    if (id.isNotEmpty) {
      Either<String, List<AddressModel>> myAddress =
          await accountRepositiories.getUserAddress(id);
      myAddress.fold((l) => print('no data found in address'), (r) {
        newuserAddress = r.toList();
        newAddress = newuserAddress.obs;
      });
    } else {
      newAddress = newuserAddress.obs;
    }
    isAddressLoad.value = false;
  }

  changeList(int changeIndex) async {
    var id = FirebaseAuth.instance.currentUser?.uid ?? "";
    if (id.isNotEmpty && id != null) {
      isAddressUpdated.value = true;
      //List<AddressModel> temp = newAddress;
      String id1 = newAddress[changeIndex].id;
      String id2 = newAddress[selectedIndex.value].id;
      newAddress[changeIndex].isSelected = true;
      newAddress[selectedIndex.value].isSelected = false;

      Either<String, String> result =
          await addressProvider.updateSingleFieldAddress(id, true, id1);
      result.fold((l) {
        CustomeSnackbar(
          title: 'Addresses !',
          message: 'Failed to Change Selected Address .',
          icon: Icon(Icons.error),
        );
      }, (r) async {
        Either<String, String> result =
            await addressProvider.updateSingleFieldAddress(id, false, id2);
        result.fold((l) {
          CustomeSnackbar(
            title: 'Addresses !',
            message: 'Failed to Change Selected Address .',
            icon: Icon(Icons.error),
          );
        }, (r) {
          isAddressUpdated.value = false;
          selectedIndex.value = changeIndex;
        });
      });
    }

    //  newAddress = temp.obs;
  }

  void updateAddress(String address) async {
    AddressModel addressModel = new AddressModel(
      tol: tolController.text,
      landmark: landmarkController?.text ?? '',
      place: placeController.text,
      city: cityController.text,
      muncipalit: muncipalityController.text,
      state: address,
      zipcode: zipcodeController.text,
      phoneno: phonenoController.text,
      isSelected: oldModel.isSelected,
    );
    String upId = oldModel.id;

    var id = FirebaseAuth.instance.currentUser?.uid ?? "";
    if (id.isNotEmpty && id != null) {
      Either<String, String> result =
          await addressProvider.updateAddress(id, addressModel, upId);
      result.fold((l) {
        CustomeSnackbar(
          title: 'Addresses !',
          message: 'Failed to Update Address \nCheck your data!.',
          icon: Icon(Icons.error),
        );
      }, (r) async {
        newAddress.remove(oldModel);
        addressModel.id = oldModel.id;
        oldModel = null;
        newAddress.add(addressModel);
        clearData();
        CustomeSnackbar(
          title: 'Addresses !',
          message: 'Successfully Updated Address \nCheck your data!.',
          icon: Icon(Icons.info),
        );
        isAddressUpdated.toggle();
        Get.back();
      });
    }
    isAddressEdit.value = false;
  }

  void deleteAddress(String docId, AddressModel addressModel) async {
    var id = FirebaseAuth.instance.currentUser?.uid ?? "";
    if (id.isNotEmpty && id != null) {
      Either<String, String> deleteAd =
          await addressProvider.deleteAddress(id, docId);
      deleteAd.fold((l) {
        CustomeSnackbar(
          title: 'Addresses !',
          message: 'Failed to Change Selected Address .',
          icon: Icon(Icons.error),
        );
      }, (r) {
        isAddressUpdated.toggle();
        CustomeSnackbar(
          title: 'Deleted !',
          message: 'Successfully Deleted .',
          icon: Icon(Icons.info),
        );
      });
    }
  }

  Future<void> saveAddress(String state) async {
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
      isSelected: true,
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
      }, (r) async {
        print(r);
        addressModel.id = r;
        val = await success(id, val, addressModel);
      });
    }
    isAddressLoad.value = false;
    Get.back();
  }

  Future<bool> success(String id, bool val, AddressModel addressModel) async {
    int length = newAddress?.length ?? 0;
    isAddressLoad.value = true;

    if (length > 0) {
      await isselectedchanged(id, newAddress);
    } else {
      fetchUserAddress();
    }
    print('Here');
    CustomeSnackbar(
      title: 'Saved and Updated !',
      message: 'Successfully Added Address.',
      icon: Icon(Icons.error),
    );
    val = true;
    newAddress.add(addressModel);
    newAddress[selectedIndex.value].isSelected = false;
    selectedIndex.value = newAddress.length - 1;
    clearData();
    isAddressUpdated.toggle();
    return val;
  }

  clearData() {
    isAddressUpdated.toggle();
    cityController.text = '';
    landmarkController.text = '';
    muncipalityController.text = '';
    phonenoController.text = '';
    placeController.text = '';
    tolController.text = '';
    zipcodeController.text = '';
  }

  Future<void> isselectedchanged(String id, List<AddressModel> list) async {
    for (AddressModel model in list) {
      if (model.id != null)
        await addressProvider.updateSingleFieldAddress(id, false, model.id);
    }
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
