import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:rasan_mart/app/modules/customeproductpage/scroll_banner_model.dart';

abstract class BannerRepo {
  Future<Either<String, List<ScrollBanner>>> fetchScrollBanner();
}

class ScrollBannerRepository implements BannerRepo {
  @override
  Future<Either<String, List<ScrollBanner>>> fetchScrollBanner() async {
    List<ScrollBanner> banner = [];
    try {
      await FirebaseFirestore.instance
          .collection("Banner")
          .orderBy("index", descending: false)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          banner.add(
            ScrollBanner(
                imagepath: element['imagepath'].toString(),
                index: element['index'] as int),
          );
        });
      });
      return right(banner);
    } catch (error) {
      return left("Error on Banner");
    }
  }
}
