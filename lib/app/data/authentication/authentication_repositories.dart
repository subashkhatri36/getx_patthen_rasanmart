import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rasan_mart/app/modules/authentication/views/user_model.dart';
import 'package:get/get.dart';
import 'package:rasan_mart/app/modules/splash/controllers/splash_controller.dart';

abstract class AuthRepositories {
  Future<Either<String, String>> userLogIn(UserAuth user);
  Future<Either<String, String>> userRegister(UserAuth user);
  Future<Either<String, String>> userGoogleSignIn();
  Future<Either<String, String>> userForgetPassword();
}

class UserAuthenticationRepositories implements AuthRepositories {
  var splash = Get.put(SplashController());

  @override
  Future<Either<String, String>> userGoogleSignIn() {
    // TODO: implement userGoogleSignIn
    throw UnimplementedError();
  }

  @override
  Future<Either<String, String>> userLogIn(UserAuth user) async {
    try {
      splash.userCredential =
          await splash.firebaseAuth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      if (splash.userCredential != null) {
        splash.userId = splash.userCredential.user.uid;

        return right('Success');
      } else {
        return left("Authentication Failed !");
      }
      //
    } on FirebaseAuthException {
      return left("Authentication Failed !\n Wrong Email and Password");
    }
  }

  @override
  Future<Either<String, String>> userRegister(UserAuth user) async {
    try {
      await splash.firebaseAuth
          .createUserWithEmailAndPassword(
            email: user.email,
            password: user.password,
          )
          .then((value) {})
          .catchError((e) {
        return left(e.toString());
      });
      if (splash.userCredential.user != null) {
        splash.userId = splash.userCredential.user.uid;

        return right('Success');
      } else {
        return left("Registration Failed !");
      }

      //.user;
    } on FirebaseAuthException {
      return left(
          "Registration Failed !\n Please Try again with valid email and password !");
    }
  }

  @override
  Future<Either<String, String>> userForgetPassword() {
    // TODO: implement userForgetPassword
    throw UnimplementedError();
  }
}
