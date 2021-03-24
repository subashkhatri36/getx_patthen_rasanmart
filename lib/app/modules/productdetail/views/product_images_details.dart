import 'package:flutter/material.dart';
import 'package:rasan_mart/app/Widgets/image_container.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';
import 'package:rasan_mart/app/core/utils/styles.dart';
import 'package:rasan_mart/app/modules/customeproductpage/product_model.dart';

class ProductImageDetails extends StatefulWidget {
  final Product product;

  const ProductImageDetails({
    Key key,
    @required this.product,
  }) : super(key: key);

  @override
  _ProductImageDetailsState createState() => _ProductImageDetailsState();
}

class _ProductImageDetailsState extends State<ProductImageDetails> {
  int _selectedImageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: Defaults.defaultfontsize),
          padding: EdgeInsets.all(Defaults.defaultfontsize) / 2,
          child: Column(children: [
            Hero(
                tag: widget.product.productId,
                key: ValueKey(widget.product.productId),
                child: imageContainer(
                  path: widget.product.productImages[_selectedImageIndex],
                  context: context,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .3,
                  fit: BoxFit.fitHeight,
                )),
            SizedBox(height: 10),
            Container(
              alignment: Alignment.centerLeft,
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: widget.product.productImages
                    .map((path) => GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedImageIndex =
                                  widget.product.productImages.indexOf(path);
                            });
                          },
                          child: Container(
                              margin: EdgeInsets.only(left: 10),
                              decoration: buildBoxDecoration(
                                  bgcolor: Colors.transparent,
                                  shadow: false,
                                  round: false),
                              child: imageContainer(
                                path: path,
                                width: 80,
                                height: 80,
                                context: context,
                                fit: BoxFit.fitHeight,
                              )),
                        ))
                    .toList(),
              ),
            )
          ])),
    );
  }
}
