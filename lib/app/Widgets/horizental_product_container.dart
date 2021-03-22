import 'package:flutter/material.dart';
import 'package:rasan_mart/app/Widgets/product_widget.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';
import 'package:rasan_mart/app/core/constant/strings.dart';
import 'package:rasan_mart/app/core/enum/enums.dart';
import 'package:rasan_mart/app/modules/customeproductpage/controllers/product_controller.dart';
import 'package:rasan_mart/app/modules/customeproductpage/product_model.dart';
import 'package:get/get.dart';

class HorizentalProductContainer extends StatefulWidget {
  final String containerTitle;
  final List<String> productIdList;
  final Color backgroundColor;
  final int index;

  const HorizentalProductContainer({
    Key key,
    @required this.containerTitle,
    @required this.productIdList,
    @required this.backgroundColor,
    @required this.index,
  }) : super(key: key);

  @override
  _HorizentalProductContainerState createState() =>
      _HorizentalProductContainerState();
}

class _HorizentalProductContainerState
    extends State<HorizentalProductContainer> {
  final productController = Get.put(ProductController());
  @override
  void initState() {
    productController.loadproduct(productId: widget.productIdList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Defaults.defaultfontsize / 4),
      padding: EdgeInsets.all(Defaults.defaultfontsize / 4),
      width: MediaQuery.of(context).size.width,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(Defaults.defaultfontsize / 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.containerTitle,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Defaults.defaultfontsize * 1.5),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Colors.transparent,
                  onPrimary: Theme.of(context).primaryColor,
                ),
                onPressed: () {},
                child: Text(
                  Strings.btnview,
                  style: TextStyle(color: Theme.of(context).backgroundColor),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: Defaults.defaultfontsize / 4),
        Container(
            height: MediaQuery.of(context).size.height * 0.33,
            child: Obx(() => productController.isProductLoading.isTrue
                ? Container(
                    child: Column(
                    children: [CircularProgressIndicator(), Text('Loading...')],
                  ))
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount:
                        productController.productlist[widget.index].length,
                    itemBuilder: (context, _index) {
                      Product oneproduct =
                          productController.productlist[widget.index][_index];

                      ProductWidget(
                        product: oneproduct,
                        contianerType: ContianerType.HorizentalLayout,
                        mainIndex: widget.index,
                        index: _index,
                      );
                    })))
      ]),
    );
  }
}
