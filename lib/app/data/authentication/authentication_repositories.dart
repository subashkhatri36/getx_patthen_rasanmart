import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rasan_mart/app/data/local_data/get_storage.dart';
import 'package:rasan_mart/app/modules/authentication/views/user_model.dart';

abstract class AuthRepositories {
  Future<Either<String, String>> userLogIn(UserAuth user);
  Future<Either<String, String>> userRegister(UserAuth user);
  Future<Either<String, String>> userGoogleSignIn();
  Future<Either<String, String>> userForgetPassword();
}

class UserAuthenticationRepositories implements AuthRepositories {
  LocalDB local = new LocalDB();

  @override
  Future<Either<String, String>> userGoogleSignIn() {
    // TODO: implement userGoogleSignIn
    throw UnimplementedError();
  }

  @override
  Future<Either<String, String>> userLogIn(UserAuth user) async {
    bool userMsg = false;
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      )
          .then((value) {
        // splash.userId.value = splash.userCredential.user.uid;

        local.writeToDB(value.user.uid);
        userMsg = true;
        // return null;
      }).onError((error, stackTrace) {
        userMsg = false;
      });
      if (userMsg) {
        return right('Success');
      } else {
        return left("Authentication Failed !");
      }
    } on FirebaseAuthException {
      return left("Authentication Failed !\n Wrong Email and Password");
    }
  }

  @override
  Future<Either<String, String>> userRegister(UserAuth user) async {
    bool userMsg = false;
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      )
          .then((value) {
        // splash.userId.value = splash.userCredential.user.uid;
        savingData(value.user.uid, value.user.email);

        local.writeToDB(value.user.uid);
        userMsg = true;
        //return null;
      }).onError((error, stackTrace) {
        userMsg = false;
      });
      if (userMsg) {
        return right('Success');
      } else {
        return left("Authentication Failed !");
      }

      //.user;
    } on FirebaseAuthException {
      return left(
          "Registration Failed !\n Please Try again with valid email and password !");
    }
  }

  void savingData(String userId, String userEmail) async {
    Map<String, String> userdata = {
      'phone': "",
      'email': userEmail,
      'photo': '',
      'name': '',
    };
    try {
      await FirebaseFirestore.instance
          .collection('User')
          .doc(userId)
          .set(userdata)
          .then((value) => print('Saved User'));
    } catch (error) {
      print(error);
    }
  }

  @override
  Future<Either<String, String>> userForgetPassword() {
    throw UnimplementedError();
  }
}
