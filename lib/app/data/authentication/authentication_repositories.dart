import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Future<Either<String, String>> userGoogleSignIn() async {
    try {
      bool valueexist = false;

      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      await FirebaseFirestore.instance
          .collection('User')
          .doc(authResult.user.uid)
          .get()
          .then((value) {
        if (value.exists) {
          valueexist = true;
          print(valueexist);
        }
      }).whenComplete(() => null);
      if (!valueexist) {
        Map<String, String> userdata = {
          'phone': "",
          'email': authResult.user.email,
          'photo': '',
          'name': '',
        };

        await FirebaseFirestore.instance
            .collection('User')
            .doc(authResult.user.uid)
            .set(userdata)
            .then((value) => print('Saved User'));
        return right('Successfully Register');
      } else {
        return right('Successfully Login');
      }
    } catch (error) {
      return left('Error during google sing in.');
    }
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
