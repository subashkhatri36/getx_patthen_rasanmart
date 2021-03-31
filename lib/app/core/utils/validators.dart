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

String checkPhone(value) {
  if (value.length != 10) {
    return 'Phone no is too short.';
  } else
    return null;
}

String checkPlace(value) {
  if (value.length > 3) {
    return null;
  } else
    return 'Data must be at least of  3 character.';
}

String checkCode(value) {
  if (value.length > 3 && value.length < 7) {
    return null;
  } else {
    return 'zipcode must be greater than 3 character.';
  }
}
