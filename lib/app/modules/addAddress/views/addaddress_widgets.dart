import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:rasan_mart/app/Widgets/buttons/buttons_widgets.dart';
import 'package:rasan_mart/app/Widgets/inputs/text_fields.dart';
import 'package:rasan_mart/app/Widgets/snakbar.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';
import 'package:rasan_mart/app/core/theme/app_theme.dart';
import 'package:rasan_mart/app/core/utils/validators.dart';
import 'package:rasan_mart/app/modules/addAddress/controllers/add_address_controller.dart';

class AddAddressWidget extends StatelessWidget {
  const AddAddressWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddAddressController>();
    final GlobalKey<FormState> addresskey = GlobalKey<FormState>();
    bool selectedState = false;
    String selectedData = '';

    //  List<DropdownMenuItem<String>> _dropDownMenuItems = getDropDownMenuItems();
    return SingleChildScrollView(
        child: Form(
      key: addresskey,
      child: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border.all(color: Themes.lightcounterbtnColor)),
              padding: EdgeInsets.all(Defaults.defaultfontsize),
              child: Text(
                '* Field are required',
                style: TextStyle(color: Theme.of(context).backgroundColor),
              )),
          SizedBox(height: Defaults.defaultfontsize / 2),
          Container(
            padding: EdgeInsets.symmetric(horizontal: Defaults.defaultfontsize),
            child: Column(
              children: [
                TextInputField(
                  focus: true,
                  controller: controller.placeController,
                  lable: 'Enter Place *',
                  hinttext: 'Enter Place',
                  texttype: TextInputType.text,
                  icon: Icons.place,
                  validator: (value) => checkPlace(value),
                ),
                SizedBox(height: Defaults.defaultfontsize / 2),
                TextInputField(
                  controller: controller.tolController,
                  lable: 'Enter tol *',
                  hinttext: 'Enter tol',
                  texttype: TextInputType.text,
                  validator: (value) => checkPlace(value),
                ),
                SizedBox(height: Defaults.defaultfontsize / 2),
                TextInputField(
                  controller: controller.landmarkController,
                  lable: 'Enter landmark',
                  hinttext: 'Enter landmark',
                  texttype: TextInputType.text,
                  validator: (value) => null,
                ),
                SizedBox(height: Defaults.defaultfontsize / 2),
                TextInputField(
                  controller: controller.cityController,
                  lable: 'Enter City *',
                  hinttext: 'Enter City',
                  texttype: TextInputType.text,
                  validator: (value) => checkPlace(value),
                ),
                SizedBox(height: Defaults.defaultfontsize / 2),
                TextInputField(
                  controller: controller.muncipalityController,
                  lable: 'Enter Muncipality *',
                  hinttext: 'Enter Muncipality',
                  texttype: TextInputType.text,
                  validator: (value) => checkPlace(value),
                ),
                SizedBox(height: Defaults.defaultfontsize / 2),
                Obx(
                  () => Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    padding: EdgeInsets.all(Defaults.defaultfontsize),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Defaults.defaultPadding),
                        border: Border.all(
                            color: Theme.of(context).backgroundColor)),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: controller.stateValue.value.isEmpty
                          ? 'Select State'
                          : controller.stateValue.value,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Theme.of(context).backgroundColor,
                      ),
                      iconSize: 30, //this inicrease the size
                      elevation: 16,
                      style: TextStyle(color: Colors.red),
                      underline: Container(),
                      onChanged: (String newValue) {
                        controller.stateValue.value = newValue;
                        selectedData = newValue;
                        selectedState = true;
                      },
                      items: controller.state
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                                color: Theme.of(context).backgroundColor),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(height: Defaults.defaultfontsize / 2),
                TextInputField(
                  icon: Icons.code,
                  validator: (value) => checkCode(value),
                  controller: controller.zipcodeController,
                  lable: 'Enter zip code *',
                  hinttext: 'Enter zip code',
                  texttype: TextInputType.number,
                ),
                SizedBox(height: Defaults.defaultfontsize / 2),
                TextInputField(
                  validator: (value) => checkPhone(value),
                  icon: Icons.phone,
                  controller: controller.phonenoController,
                  lable: 'Enter phone No *',
                  hinttext: 'Enter phone No',
                  texttype: TextInputType.number,
                ),
                SizedBox(height: Defaults.defaultfontsize / 2),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: Defaults.defaultfontsize),
            child: CustomeTextButton(
              label: 'Save',
              onPressed: () async {
                if (selectedState) {
                  if (addresskey.currentState.validate()) {
                    bool val = await controller.saveAddress(selectedData);
                    if (val) {
                      Get.back();
                    }
                  } else {
                    CustomeSnackbar(
                      title: 'Addresses !',
                      message: 'Failed to Save Address \nCheck your data!.',
                      icon: Icon(Icons.error),
                    );
                  }
                } else {
                  CustomeSnackbar(
                    title: 'Select State !',
                    message: 'Failed to Save Address \nCheck your data!.',
                    icon: Icon(Icons.error),
                  );
                }
              },
              color: Theme.of(context).backgroundColor,
            ),
          ),
          SizedBox(height: Defaults.defaultfontsize / 2),
        ],
      ),
    ));
  }
}
