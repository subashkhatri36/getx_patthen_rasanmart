import 'package:flutter/material.dart';
import 'package:rasan_mart/app/Widgets/Product/product_widget.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';
import 'package:rasan_mart/app/core/constant/strings.dart';
import 'package:rasan_mart/app/core/enum/enums.dart';
import 'package:rasan_mart/app/modules/customeproductpage/controllers/product_controller.dart';
import 'package:rasan_mart/app/modules/customeproductpage/product_model.dart';
import 'package:get/get.dart';
import 'package:rasan_mart/app/modules/productview/views/productview_view.dart';

class HorizentalProductContainer extends StatefulWidget {
  final String containerTitle;
  final List<String> productIdList;
  final Color backgroundColor;
  //final int index;

  const HorizentalProductContainer({
    Key key,
    @required this.containerTitle,
    @required this.productIdList,
    @required this.backgroundColor,
  }) : super(key: key);

  @override
  _HorizentalProductContainerState createState() =>
      _HorizentalProductContainerState();
}

class _HorizentalProductContainerState
    extends State<HorizentalProductContainer> {
  final productController = Get.find<ProductController>();
  //List<Product> productlist;
  Future<List<Product>> loadData() async {
    return await productController.loadproduct(productId: widget.productIdList);
    //print(productlist);
  }

  @override
  void initState() {
    //print(widget.index);
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      margin: EdgeInsets.symmetric(
          vertical: Defaults.defaultfontsize / 4, horizontal: 0.0),
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
                onPressed: () {
                  Get.to(() => ProductviewView(
                        productList: productController.productlist,
                        title: widget.containerTitle,
                      ));
                },
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
            height: 250,
            child: FutureBuilder(
              builder: (context, snapshot) {
                return snapshot.data != null
                    ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (context, _index) {
                          Product oneproduct = snapshot.data[_index];
                          return ProductWidget(
                            product: oneproduct,
                            contianerType: ContianerType.HorizentalLayout,
                          );
                        })
                    : Container(
                        child: Column(
                        children: [
                          CircularProgressIndicator(),
                          Text('Loading...')
                        ],
                      ));
              },
              future: loadData(),
            ))
      ]),
    );
  }
}
