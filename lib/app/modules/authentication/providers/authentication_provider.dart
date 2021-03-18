import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:rasan_mart/app/core/enum/enums.dart';
import 'package:rasan_mart/app/data/authentication/authentication_repositories.dart';
import 'package:rasan_mart/app/modules/authentication/views/user_model.dart';

class AuthenticationProvider extends GetConnect {
  AuthRepositories _authRepositories = UserAuthenticationRepositories();
  @override
  void onInit() {
    //httpClient.baseUrl = 'YOUR-API-URL';
  }
  Future<Either<String, String>> logIn(
      UserAuth user, AuthenticateType authenticateType) {
    switch (authenticateType) {
      case AuthenticateType.LogIn:
        return _authRepositories.userLogIn(user);
        break;
      case AuthenticateType.Register:
        return _authRepositories.userRegister(user);
        break;
      case AuthenticateType.GoogleSignIn:
        break;
      default:
        return null;
        break;
    }
  }
}
