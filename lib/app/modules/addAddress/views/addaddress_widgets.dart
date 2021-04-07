import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:rasan_mart/app/Widgets/buttons/buttons_widgets.dart';
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Defaults.defaultfontsize),
                Text(
                  ' Enter your Place *\n',
                  style: TextStyle(fontSize: Defaults.defaultfontsize),
                ),
                TextFormField(
                  controller: controller.placeController,
                  keyboardType: TextInputType.text,
                  autofocus: true,
                  validator: (value) => checkPlace(value),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.place),
                    hintText: 'Enter place *',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).backgroundColor, width: 1),
                        borderRadius:
                            BorderRadius.circular(Defaults.defaultfontsize)),
                  ),
                ),
                SizedBox(height: Defaults.defaultfontsize / 2),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ' Enter your tol *\n',
                            style:
                                TextStyle(fontSize: Defaults.defaultfontsize),
                          ),
                          TextFormField(
                            controller: controller.tolController,
                            keyboardType: TextInputType.text,
                            validator: (value) => checkPlace(value),
                            decoration: InputDecoration(
                                hintText: 'Enter your tol *',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Theme.of(context).backgroundColor,
                                        width: 1),
                                    borderRadius: BorderRadius.circular(
                                        Defaults.defaultfontsize)),
                                focusColor: Theme.of(context).backgroundColor),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: Defaults.defaultfontsize / 2),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ' Enter Landmark *\n',
                            style:
                                TextStyle(fontSize: Defaults.defaultfontsize),
                          ),
                          TextFormField(
                            controller: controller.landmarkController,
                            keyboardType: TextInputType.text,
                            validator: (value) => null,
                            decoration: InputDecoration(
                                hintText: 'Enter Landmark',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Theme.of(context).backgroundColor,
                                        width: 1),
                                    borderRadius: BorderRadius.circular(
                                        Defaults.defaultfontsize)),
                                focusColor: Theme.of(context).backgroundColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Defaults.defaultfontsize / 2),
                Text(
                  ' Enter City*\n',
                  style: TextStyle(fontSize: Defaults.defaultfontsize),
                ),
                TextFormField(
                  controller: controller.cityController,
                  keyboardType: TextInputType.text,
                  validator: (value) => checkPlace(value),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.place),
                      hintText: 'Enter City',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).backgroundColor,
                              width: 1),
                          borderRadius:
                              BorderRadius.circular(Defaults.defaultfontsize)),
                      focusColor: Theme.of(context).backgroundColor),
                ),
                SizedBox(height: Defaults.defaultfontsize / 2),
                Text(
                  ' Enter Muncipality*\n',
                  style: TextStyle(fontSize: Defaults.defaultfontsize),
                ),
                TextFormField(
                  controller: controller.muncipalityController,
                  keyboardType: TextInputType.text,
                  validator: (value) => checkPlace(value),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.place),
                      hintText: 'Enter Muncipality',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).backgroundColor,
                              width: 1),
                          borderRadius:
                              BorderRadius.circular(Defaults.defaultfontsize)),
                      focusColor: Theme.of(context).backgroundColor),
                ),
                SizedBox(height: Defaults.defaultfontsize / 2),
                Text(
                  ' Select State *\n',
                  style: TextStyle(fontSize: Defaults.defaultfontsize),
                ),
                Obx(
                  () => Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    padding: EdgeInsets.all(Defaults.defaultfontsize),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Defaults.defaultPadding),
                        border: Border.all(color: Colors.grey[300])),
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
                            style: TextStyle(color: Colors.black87),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(height: Defaults.defaultfontsize),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ' Zip Code *\n',
                            style:
                                TextStyle(fontSize: Defaults.defaultfontsize),
                          ),
                          TextFormField(
                            controller: controller.zipcodeController,
                            keyboardType: TextInputType.text,
                            validator: (value) => checkCode(value),
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.code),
                                hintText: 'Enter zip code',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Theme.of(context).backgroundColor,
                                        width: 1),
                                    borderRadius: BorderRadius.circular(
                                        Defaults.defaultfontsize)),
                                focusColor: Theme.of(context).backgroundColor),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: Defaults.defaultfontsize / 2),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ' Enter your phone no *\n',
                            style:
                                TextStyle(fontSize: Defaults.defaultfontsize),
                          ),
                          TextFormField(
                            controller: controller.phonenoController,
                            keyboardType: TextInputType.number,
                            validator: (value) => checkPhone(value),
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.phone),
                                hintText: 'Enter your phone no',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Theme.of(context).backgroundColor,
                                        width: 1),
                                    borderRadius: BorderRadius.circular(
                                        Defaults.defaultfontsize)),
                                focusColor: Theme.of(context).backgroundColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: Defaults.defaultfontsize / 2),

                SizedBox(height: Defaults.defaultfontsize),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: Defaults.defaultfontsize),
            height: 50,
            child: CustomeTextButton(
              label: controller.isAddressEdit.value ? 'Update' : 'Save',
              onPressed: () async {
                if (selectedState) {
                  if (addresskey.currentState.validate()) {
                    if (controller.isAddressEdit.value)
                      controller.updateAddress(selectedData);
                    else
                      controller.saveAddress(selectedData);
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
          SizedBox(height: Defaults.defaultfontsize),
        ],
      ),
    ));
  }
}
