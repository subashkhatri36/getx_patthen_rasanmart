import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:rasan_mart/app/Widgets/buttons/buttons_widgets.dart';
import 'package:rasan_mart/app/Widgets/inputs/text_fields.dart';
import 'package:rasan_mart/app/Widgets/snakbar.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';
import 'package:rasan_mart/app/core/theme/app_theme.dart';
import 'package:rasan_mart/app/core/utils/validators.dart';

import '../controllers/forgetpassword_controller.dart';

class ForgetpasswordView extends GetView<ForgetpasswordController> {
  final controller = Get.put(ForgetpasswordController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('Forget Password'),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Form(
        key: controller.reset,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/forget.png',
                width: 70, fit: BoxFit.fitWidth),
            SizedBox(height: Defaults.defaultfontsize),
            Obx(
              () => controller.resetpassword.value
                  ? Container(
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.checkCircle,
                              color: Themes.lightSalesolor,
                            ),
                            SizedBox(width: Defaults.defaultfontsize),
                            Text(
                              'Successfully Send Email',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Themes.lightSalesolor,
                                  fontSize: Defaults.defaultPadding),
                            )
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(Defaults.defaultfontsize),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.envelopeOpenText,
                                size: 60,
                                color: Theme.of(context).backgroundColor,
                              ),
                              SizedBox(width: Defaults.defaultfontsize),
                              Expanded(
                                child: Text(
                                  'Please check your email and follow the process to reset password.\nThank you. ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ))
                  : Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(Defaults.defaultPadding),
                          child: TextInputField(
                            validator: (value) => checkEmail(value),
                            controller: controller.forgetController,
                            hinttext: 'your Email address',
                            lable: 'Your Email address',
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(right: Defaults.defaultPadding),
                          alignment: Alignment.centerRight,
                          child: CustomeTextButton(
                            color: Theme.of(context).backgroundColor,
                            label: 'Reset Password',
                            fcolor: Colors.white,
                            onPressed: () {
                              if (controller.reset.currentState.validate()) {
                                controller.resetPassword();
                              } else {
                                CustomeSnackbar(
                                  title: 'Warning !',
                                  message: 'Please type your email correctly.',
                                  icon: Icon(Icons.warning),
                                );
                              }
                            },
                          ),
                        )
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
