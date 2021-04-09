import 'package:flutter/material.dart';
import 'package:rasan_mart/app/Widgets/Product/product_widget.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';
import 'package:rasan_mart/app/core/constant/strings.dart';
import 'package:rasan_mart/app/core/enum/enums.dart';
import 'package:rasan_mart/app/modules/customeproductpage/controllers/gridview_controller.dart';
import 'package:rasan_mart/app/modules/customeproductpage/product_model.dart';
import 'package:get/get.dart';
import 'package:rasan_mart/app/modules/productview/views/productview_view.dart';

class GridViewProduct extends StatefulWidget {
  final String containerTitle;
  final List<String> productIdList;
  final Color backgroundColor;
  final int index;

  const GridViewProduct({
    Key key,
    @required this.containerTitle,
    @required this.productIdList,
    @required this.backgroundColor,
    @required this.index,
  }) : super(key: key);
  @override
  _GridViewProductState createState() => _GridViewProductState();
}

class _GridViewProductState extends State<GridViewProduct> {
  //final gridController = Get.put(GridviewController());
  final productController = Get.find<GridviewController>();
  //List<Product> productlist;
  Future<List<Product>> loadData() async {
    return await productController.loadproduct(productId: widget.productIdList);
    //print(productlist);
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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

                          horizental: false,
                          title: widget.containerTitle,
                        ),arguments: productController.productList,);
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
            alignment: Alignment.center,
            height: 490,
            padding:
                EdgeInsets.symmetric(horizontal: Defaults.defaultfontsize / 2),
            child: Column(
              children: [
                Expanded(
                  child: FutureBuilder(
                    builder: (context, snapshot) {
                      return snapshot.data != null
                          ? GridViewProductData(newProduct: snapshot.data)
                          : Center(
                              child: CircularProgressIndicator(),
                            );
                    },
                    future: loadData(),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class GridViewProductData extends StatelessWidget {
  const GridViewProductData({
    Key key,
    @required this.newProduct,
  }) : super(key: key);

  final List<Product> newProduct;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        childAspectRatio: .8,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisSpacing: 2,
        mainAxisSpacing: 3,
        crossAxisCount: 2,
        children: List.generate(
          newProduct.length > 4 ? 4 : newProduct.length,
          (index) {
            Product oneproduct = newProduct[index];

            return ProductWidget(
              product: oneproduct,
              contianerType: ContianerType.GridviewLayout,
            );
          },
        ));
  }
}
