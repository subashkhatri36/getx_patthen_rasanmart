import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rasan_mart/app/Widgets/snakbar.dart';
import 'package:rasan_mart/app/core/enum/enums.dart';
import 'package:rasan_mart/app/core/theme/app_theme.dart';
import 'package:rasan_mart/app/modules/authentication/providers/authentication_provider.dart';
import 'package:rasan_mart/app/modules/authentication/views/user_model.dart';
import 'package:rasan_mart/app/modules/home/views/home_view.dart';

class AuthenticationController extends GetxController {
  final RxBool isLoading = false.obs;

  final TextEditingController emailtextEditingController =
      TextEditingController();
  final TextEditingController passwordtextEditingController =
      TextEditingController();

  AuthenticationProvider _authenticationProvider = new AuthenticationProvider();

  @override
  void onInit() {
    super.onInit();
  }

  void onSubmit(AuthenticateType authenticateType) async {
    //login
    Either<String, String> response = await _authenticationProvider.logIn(
        UserAuth(
          email: emailtextEditingController.text,
          password: passwordtextEditingController.text,
        ),
        authenticateType);
    response.fold(
        (l) => CustomeSnackbar(
              title: 'Authentication Failed !',
              icon: Icon(Icons.warning),
              message: 'Incorrect Email and Password!',
            ),
        (r) => Get.off(() => HomeView()));
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
