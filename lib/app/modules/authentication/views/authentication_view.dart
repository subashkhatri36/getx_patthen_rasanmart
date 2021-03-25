import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rasan_mart/app/Widgets/buttons/buttons_widgets.dart';
import 'package:rasan_mart/app/Widgets/inputs/text_fields.dart';
import 'package:rasan_mart/app/Widgets/snakbar.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';
import 'package:rasan_mart/app/core/constant/strings.dart';
import 'package:rasan_mart/app/core/enum/enums.dart';
import 'package:rasan_mart/app/core/utils/validators.dart';

import '../controllers/authentication_controller.dart';

class AuthenticationView extends GetView<AuthenticationController> {
  final authController = Get.put(AuthenticationController());
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Container(
              padding: EdgeInsets.all(Defaults.defaultPadding),
              child: Column(children: [
                SizedBox(height: Defaults.defaultfontsize * 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        //close Icons
                      },
                      child: Padding(
                        padding:
                            const EdgeInsets.all(Defaults.defaultfontsize / 2),
                        child: Icon(
                          Icons.close,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Defaults.defaultfontsize),
                //Logo
                Image.asset(
                  'assets/images/logo.PNG',
                  width: 200,
                  height: 200,
                ),

                SizedBox(height: Defaults.defaultfontsize),

                InputField(
                  label: Strings.email,
                  context: context,
                  hintText: Strings.email,
                  controller: authController.emailtextEditingController,
                  textInputType: TextInputType.emailAddress,
                  obscureText: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => checkEmail(value),
                ),
                //email address

                //password
                InputField(
                  label: Strings.password,
                  context: context,
                  hintText: Strings.password,
                  controller: authController.passwordtextEditingController,
                  textInputType: TextInputType.visiblePassword,
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => checkpassword(value),
                ),

                SizedBox(height: Defaults.defaultfontsize),

                Obx(() => authController.isLoading.value
                    ? CircularProgressIndicator()
                    : Text('')),

                // GetX<UserAuthController>(builder: (controller) {
                //   return Text(controller.isloading.toString());
                // }),

                SizedBox(height: Defaults.defaultfontsize),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: () {},
                        child: Text(
                          Strings.forgetPassword,
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.white),
                        )),
                  ],
                ),
                SizedBox(height: Defaults.defaultfontsize * 2),

                //Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomOutlinedButton(
                      label: 'Log In',
                      onPressed: () {
                        if (formkey.currentState.validate()) {
                          authController.onSubmit(AuthenticateType.LogIn);
                        } else {
                          CustomeSnackbar(
                            title: 'Authentication !',
                            message: 'Check your data!.',
                            icon: Icon(Icons.warning),
                          );
                        }
                      },
                    ),
                    CustomOutlinedButton(
                      label: 'Register',
                      onPressed: () {
                        if (formkey.currentState.validate()) {
                          authController.onSubmit(AuthenticateType.Register);
                        } else {
                          CustomeSnackbar(
                            title: 'Authentication !',
                            message: 'Check your data!.',
                            icon: Icon(Icons.warning),
                          );
                        }
                      },
                    )
                  ],
                )
              ]),
            ),
          ),
        ));
  }

  OutlineInputBorder buildOutlineInputBorder(BuildContext context) {
    return OutlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1),
        borderRadius: BorderRadius.circular(Defaults.defaultfontsize));
  }
}
