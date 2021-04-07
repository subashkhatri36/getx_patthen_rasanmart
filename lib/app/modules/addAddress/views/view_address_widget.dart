import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rasan_mart/app/Widgets/buttons/buttons_widgets.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';
import 'package:rasan_mart/app/core/theme/app_theme.dart';
import 'package:rasan_mart/app/modules/account/address_model.dart';
import 'package:rasan_mart/app/modules/addAddress/controllers/add_address_controller.dart';

class ViewAddressWidget extends StatelessWidget {
  const ViewAddressWidget({
    Key key,
    this.change,
  }) : super(key: key);
  final bool change;

  @override
  Widget build(BuildContext context) {
    final controllerAddress = Get.find<AddAddressController>();

    return Obx(() {
      return controllerAddress.isAddressLoad.value
          ? CircularProgressIndicator()
          : Container(
              padding: EdgeInsets.only(top: Defaults.defaultPadding / 2),
              child: controllerAddress.isAddressUpdated.value
                  ? CustomeList(controllerAddress: controllerAddress)
                  : CustomeList(controllerAddress: controllerAddress),
            );
    });
  }
}

class CustomeList extends StatelessWidget {
  const CustomeList({
    Key key,
    @required this.controllerAddress,
  }) : super(key: key);

  final AddAddressController controllerAddress;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: controllerAddress.newAddress?.length ?? 0,
        itemBuilder: (context, index) {
          AddressModel addressModel = controllerAddress.newAddress[index];
          return Dismissible(
            key: Key(addressModel.fullAddress),
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.endToStart) {
                //delete
                bool value = await deleteAddress(addressModel, context);
                controllerAddress.newAddress.removeAt(index);
                return value;
              } else {
                //Edit
                controllerAddress.oldModel = addressModel;
                controllerAddress.isAddressEdit.value = true;
                controllerAddress.cityController.text = addressModel.city;
                controllerAddress.tolController.text = addressModel.tol;
                controllerAddress.landmarkController.text =
                    addressModel.landmark;
                controllerAddress.muncipalityController.text =
                    addressModel.muncipalit;
                controllerAddress.zipcodeController.text = addressModel.zipcode;
                controllerAddress.phonenoController.text = addressModel.phoneno;
                controllerAddress.placeController.text = addressModel.place;
                controllerAddress.stateValue.value = addressModel.state;
                return false;
              }
            },
            background: slideRightBackground(),
            secondaryBackground: slideLeftBackground(),
            child: AddressListTile(
              addressModel: addressModel,
              index: index,
            ),
          );
        });
  }

  deleteAddress(AddressModel addressModel, BuildContext context) async {
    bool val = false;
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Icon(Icons.warning),
                Text("Warning !"),
              ],
            ),
            content: Text("Are you sure to delete Cart Itme"),
            actions: [
              CustomeTextButton(
                label: 'Cancel',
                onPressed: () {
                  Navigator.of(context).pop();
                  val = false;
                },
              ),
              CustomeTextButton(
                label: 'Delete',
                color: Themes.lightBackgroundColor,
                onPressed: () async {
                  controllerAddress.deleteAddress(
                      addressModel.id, addressModel);
                  Navigator.of(context).pop();
                  val = true;
                },
              ),
            ],
          );
        });
    return val;
  }
}

class AddressListTile extends StatelessWidget {
  const AddressListTile({
    Key key,
    @required this.addressModel,
    this.index,
  }) : super(key: key);

  final AddressModel addressModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    final controllerAddress = Get.find<AddAddressController>();

    if (addressModel.isSelected) controllerAddress.selectedIndex.value = index;
    return GestureDetector(
      onTap: () {
        if (controllerAddress.newAddress.length > 0) {
          if (controllerAddress.selectedIndex.value != index) {
            controllerAddress.changeList(index);
          }
        }
      },
      child: Container(
        child: ListTile(
          title: Text(
            addressModel.fullAddress,
            style: TextStyle(
                fontSize: Defaults.defaultfontsize,
                fontWeight: addressModel.isSelected
                    ? FontWeight.bold
                    : FontWeight.normal),
            textAlign: TextAlign.left,
          ),
          trailing: addressModel.isSelected
              ? Icon(
                  FontAwesomeIcons.check,
                  color: Themes.lightSalesolor,
                )
              : null,
        ),
      ),
    );
  }
}

Widget slideRightBackground() {
  return Container(
    color: Themes.lightSalesolor,
    child: Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.edit,
            color: Colors.white,
          ),
          Text(
            " Edit",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
      alignment: Alignment.centerLeft,
    ),
  );
}

Widget slideLeftBackground() {
  return Container(
    color: Themes.lightBackgroundColor,
    child: Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
          Text(
            " Delete",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      alignment: Alignment.centerRight,
    ),
  );
}
