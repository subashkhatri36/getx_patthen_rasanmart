import 'package:get/get_utils/src/get_utils/get_utils.dart';

String checkpassword(String value) {
  if (value.length < 5) {
    return 'Password too short.';
  }
  return null;
}

String checkEmail(String value) {
  if (!GetUtils.isEmail(value)) {
    return 'Invalid Email Address.';
  }
  return null;
}
