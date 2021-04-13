import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:rasan_mart/app/Widgets/buttons/buttons_widgets.dart';
import 'package:rasan_mart/app/Widgets/inputs/text_fields.dart';
import 'package:rasan_mart/app/Widgets/snakbar.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';
import 'package:rasan_mart/app/core/constant/strings.dart';
import 'package:rasan_mart/app/core/enum/enums.dart';
import 'package:rasan_mart/app/core/theme/app_theme.dart';
import 'package:rasan_mart/app/core/utils/validators.dart';
import 'package:rasan_mart/app/modules/forgetpassword/views/forgetpassword_view.dart';

import 'package:rasan_mart/app/modules/home/views/home_view.dart';

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
                        Get.to(() => HomeView());
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

                SizedBox(height: Defaults.defaultfontsize / 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.to(() => ForgetpasswordView());
                        },
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
                    Expanded(
                      child: CustomeTextButton(
                        color: Themes.lightSalesolor,
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
                    ),
                    SizedBox(width: Defaults.defaultPadding),
                    Expanded(
                      child: CustomeTextButton(
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
                      ),
                    )
                  ],
                ),
                SizedBox(height: Defaults.defaultfontsize / 2),
                Row(
                  children: [
                    Expanded(
                        child: Divider(
                      color: Colors.white,
                    )),
                    SizedBox(width: Defaults.defaultfontsize / 2),
                    Text(
                      'OR',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: Defaults.defaultfontsize / 2),
                    Expanded(
                        child: Divider(
                      color: Colors.white,
                    )),
                  ],
                ),
                SizedBox(height: Defaults.defaultPadding / 2),
                if (authController.googleSignIn.value)
                  Container(
                      width: 40,
                      height: 40,
                      margin: EdgeInsets.all(Defaults.defaultPadding / 2),
                      child: CircularProgressIndicator()),
                CustomeTextButton(
                  icon: FontAwesomeIcons.google,
                  color: Theme.of(context).primaryColor,
                  fcolor: Theme.of(context).backgroundColor,
                  label: 'Sign in With Google',
                  onPressed: () {
                    authController.SignIngoogle();
                  },
                ),
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
