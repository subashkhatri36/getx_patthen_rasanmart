import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rasan_mart/app/modules/account/address_model.dart';
import 'package:dartz/dartz.dart';
import 'package:rasan_mart/app/modules/account/providers/userdata_provider.dart';

class AccountRepositiories implements UserdataProvider {
  final _firebaseStorage = FirebaseStorage.instance;

  @override
  Future<Either<String, List<AddressModel>>> fetchAddress(String userId) {
    // TODO: implement fetchAddress
    throw UnimplementedError();
  }

  @override
  Future<Either<String, AddressModel>> savedAddress(
      AddressModel address, String userId) {
    // TODO: implement savedAddress
    throw UnimplementedError();
  }

  @override
  Future<Either<String, String>> uploadImage(File path, String userId) async {
    try {
      bool complete = false;
      var downloadUrl = '';
      var snapshot = _firebaseStorage.ref().child('profile/$userId');
      UploadTask uploadTask = snapshot.putFile(path);
      await uploadTask.whenComplete(() async {
        complete = true;
      });
      if (complete) {
        await snapshot.getDownloadURL().then((value) {
          downloadUrl = value;
          saved(value, userId);
        });
      }

      return right(downloadUrl);
    } catch (error) {
      return left(error);
    }
  }

  Future<bool> saved(String path, String userId) async {
    bool comp = false;
    Map<String, String> image = {"photo": path};
    try {
      await FirebaseFirestore.instance
          .collection('User')
          .doc(userId)
          .update(image)
          .then((value) => comp = true);
    } catch (error) {
      await FirebaseFirestore.instance
          .collection('User')
          .doc(userId)
          .set(image)
          .then((value) => comp = true);
    }

    return comp;
  }

  @override
  Future<Either<String, UserDetail>> fetchUserData(String userId) async {
    UserDetail userDetail;
    try {
      await FirebaseFirestore.instance
          .collection('User')
          .doc(userId)
          .get()
          .then((value) {
        if (value != null) {
          userDetail = new UserDetail(
              phone: value['phone'],
              userEmail: value['email'],
              photo: value['photo'],
              userName: value['name']);
        }
      });
      if (userDetail != null) {
        return right(userDetail);
      } else {
        return left('Error While Updating');
      }
    } catch (error) {
      return left('Error While Updating');
    }
  }

  @override
  Future<Either<String, String>> saveandUpdateUserData(
      UserDetail userDetail, String userId) async {
    bool comp = false;
    Map<String, String> userdata = {
      'phone': userDetail.phone,
      'email': userDetail.userEmail,
      'photo': userDetail.photo,
      'name': userDetail.userName,
    };
    try {
      await FirebaseFirestore.instance
          .collection('User')
          .doc(userId)
          .set(userdata)
          .then((value) {
        comp = true;
      });
      if (comp) {
        return right('Success');
      } else {
        return left('Failed Saving data');
      }
    } catch (error) {
      return left('Error While Updating');
    }
  }

  @override
  Future<Either<String, String>> updateUserData(
      UserDetail userDetail, String userId) async {
    bool comp = false;
    Map<String, String> userdata = {
      'phone': userDetail.phone,
      'email': userDetail.userEmail,
      'photo': userDetail.photo,
      'name': userDetail.userName,
    };
    try {
      await FirebaseFirestore.instance
          .collection('User')
          .doc(userId)
          .update(userdata)
          .then((value) {
        comp = true;
      });
      if (comp) {
        return right('Success');
      } else {
        return left('Failed Saving data');
      }
    } catch (error) {
      return left('Error While Updating');
    }
  }

  @override
  Future<Either<String, List<AddressModel>>> getUserAddress(
      String userId) async {
    List<AddressModel> addresses = [];
    print(userId);
    try {
      await FirebaseFirestore.instance
          .collection('User')
          .doc(userId)
          .collection('address')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          addresses.add(AddressModel(
            city: element['city'].toString(),
            isSelected: element['isSelected'] as bool,
            landmark: element['landmark']?.toString() ?? '',
            muncipalit: element['muncipalit'].toString(),
            phoneno: element['phoneno'].toString(),
            place: element['place'].toString(),
            state: element['state'].toString(),
            tol: element['tol'].toString(),
            zipcode: element['zipcode'].toString(),
            id: element.id,
          ));
        });
      });
      return right(addresses);
    } catch (error) {
      return left('Error while getting Address');
    }
  }

  @override
  Future<Either<String, String>> insertUserAddress(
      AddressModel address, String userId) async {
    bool comp = false;
    try {
      if (address.id == null && address.id.isEmpty) address.id = '';

      await FirebaseFirestore.instance
          .collection('User')
          .doc(userId)
          .collection('address')
          .add(address.toMap())
          .then((value) => {comp = true});
      if (comp) {
        return right('Successfully Updated');
      } else {
        return left('Failed to add Addresses');
      }
    } catch (error) {
      return left('Error happend while adding data');
    }
  }

  @override
  Future<Either<String, String>> updateUserAddress(
      AddressModel address, String userId, String docId) async {
    bool comp = false;
    try {
      await FirebaseFirestore.instance
          .collection('User')
          .doc(userId)
          .collection('address')
          .doc(docId)
          .update(address.toMap())
          .then((value) => {comp = true});
      if (comp) {
        return right('Successfully Updated');
      } else {
        return left('Failed to add Addresses');
      }
    } catch (error) {
      return left('Error happend while adding data');
    }
  }
  //DocumentReference sightingRef = Firestore.instance.collection(“sightings”).doc();

}
