import 'package:flutter/material.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';
import 'package:rasan_mart/app/core/theme/app_theme.dart';
import 'package:rasan_mart/app/modules/checkout/controllers/delivery_controller.dart';
import 'package:rasan_mart/app/modules/checkout/delivery_model.dart';
import 'package:get/get.dart';

class OrderContiainer extends StatelessWidget {
  OrderContiainer(this.model);
  final DeliveryTotalModel model;
  final deliveryController = Get.find<DeliveryController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: Defaults.defaultPadding * 7.5,
        decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
        margin: EdgeInsets.all(Defaults.defaultfontsize / 3),
        padding: EdgeInsets.symmetric(
            horizontal: Defaults.defaultfontsize / 2,
            vertical: Defaults.defaultPadding / 2),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Expanded(
            child: Container(
                alignment: Alignment.center,
                child: ImageContainerStack(model: model.deliverymodel)),
          ),
          SizedBox(height: Defaults.defaultfontsize / 2),
          Column(
            children: [
              RichText(
                text: TextSpan(
                  text: 'Order Date : ',
                  children: [
                    TextSpan(
                      text: model.orderData,
                      style: TextStyle(
                          fontSize: Defaults.defaultfontsize - 4,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )
                  ],
                  style: TextStyle(
                      fontSize: Defaults.defaultfontsize - 4,
                      color: Colors.black87),
                ),
              ),
              SizedBox(height: 2),
              RichText(
                text: TextSpan(
                  text: 'Order Status : ',
                  children: [
                    TextSpan(
                      text: model.orderStatus,
                      style: TextStyle(
                          fontSize: Defaults.defaultfontsize - 2,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )
                  ],
                  style: TextStyle(
                      fontSize: Defaults.defaultfontsize - 2,
                      color: Colors.black87),
                ),
              ),
              SizedBox(height: 2),
              RichText(
                text: TextSpan(
                  text: 'Total Price(${model.totalproduct}) : ',
                  children: [
                    TextSpan(
                      text: model.totalprice.toString() + '/-',
                      style: TextStyle(
                          fontSize: Defaults.defaultfontsize - 4,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )
                  ],
                  style: TextStyle(
                      fontSize: Defaults.defaultfontsize - 4,
                      color: Colors.black87),
                ),
              ),
            ],
          ),
          SizedBox(height: Defaults.defaultfontsize / 2),
          if (model.orderStatus.toUpperCase() == 'Ordered'.toUpperCase())
            SizedBox(
              height: Defaults.defaultPadding * 1.5,
              width: Defaults.defaultPadding * 6,
              child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).backgroundColor,
                    primary: Theme.of(context).primaryColor),
                onPressed: () {
                  showDialog(
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Deletion Warning'),
                          content: Text('Are You Sure to Cancel this Order?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text('Close'),
                            ),
                            TextButton(
                              onPressed: () {
                                deliveryController.deleteDeliveryItems(
                                    model.id, model);
                                Get.back();
                              },
                              child: Text('Cancel Order'),
                            ),
                          ],
                        );
                      },
                      context: context);
                },
                child: Text(
                  'Cancel Order',
                  style: TextStyle(
                    fontSize: Defaults.defaultfontsize - 4,
                  ),
                ),
              ),
            )
          else
            SizedBox(
              height: Defaults.defaultPadding * 1.5,
              width: Defaults.defaultPadding * 6,
              child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Themes.lightSalesolor,
                    primary: Theme.of(context).primaryColor),
                onPressed: () {},
                child: Text(
                  'Shipped',
                  style: TextStyle(
                    fontSize: Defaults.defaultfontsize - 4,
                  ),
                ),
              ),
            )
        ]),
      ),
    );
  }
}

class ImageContainerStack extends StatelessWidget {
  const ImageContainerStack({
    Key key,
    @required this.model,
  }) : super(key: key);

  final List<DeliveryModel> model;

  @override
  Widget build(BuildContext context) {
    //model.deliverymodel.length
    switch (model.length) {
      case 0:
        return Center(child: Text('No Image'));
        break;
      case 1:
        return ImageCircle(
            imagelink: model[0].image, topmargin: 0, leftmargin: 0);
        break;
      case 2:
        return Stack(alignment: Alignment.topLeft, children: [
          ImageCircle(
            imagelink: model[0].image,
            topmargin: 0,
            leftmargin: 0,
            borderradius: 16,
            sizeraidus: 15,
          ),
          ImageCircle(
            imagelink: model[1].image,
            topmargin: 0,
            leftmargin: Defaults.defaultPadding,
            borderradius: 16,
            sizeraidus: 15,
            borderColor: Colors.black26,
          ),
        ]);
        break;
      case 3:
        return Stack(alignment: Alignment.topLeft, children: [
          ImageCircle(
            imagelink: model[0].image,
            topmargin: 0,
            leftmargin: 0,
            borderradius: 16,
            sizeraidus: 15,
          ),
          ImageCircle(
            imagelink: model[1].image,
            topmargin: 0,
            leftmargin: Defaults.defaultPadding,
            borderradius: 16,
            sizeraidus: 15,
            borderColor: Colors.black26,
          ),
          ImageCircle(
            imagelink: model[2].image,
            topmargin: Defaults.defaultPadding / 2,
            leftmargin: Defaults.defaultPadding / 2,
            borderradius: 16,
            sizeraidus: 15,
            borderColor: Colors.black26,
          ),
        ]);
        break;
      case 4:
        return ForthWidget(model: model);
        break;

      default:
        return ForthWidget(model: model);
        break;
    }
  }
}

class ForthWidget extends StatelessWidget {
  const ForthWidget({
    Key key,
    @required this.model,
  }) : super(key: key);

  final List<DeliveryModel> model;

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.topLeft, children: [
      ImageCircle(
        imagelink: model[0].image,
        topmargin: 0,
        leftmargin: Defaults.defaultPadding / 2,
        borderradius: 16,
        sizeraidus: 15,
        borderColor: Colors.black26,
      ),
      ImageCircle(
        imagelink: model[1].image,
        topmargin: Defaults.defaultfontsize - 5,
        leftmargin: 0,
        borderradius: 16,
        sizeraidus: 15,
      ),
      ImageCircle(
        imagelink: model[2].image,
        topmargin: Defaults.defaultfontsize - 5,
        leftmargin: Defaults.defaultPadding + 3,
        borderradius: 16,
        sizeraidus: 15,
        borderColor: Colors.black26,
      ),
      ImageCircle(
        imagelink: model[3].image,
        topmargin: Defaults.defaultPadding,
        leftmargin: Defaults.defaultPadding / 2,
        borderradius: 16,
        sizeraidus: 15,
        borderColor: Colors.black54,
      ),
    ]);
  }
}

class ImageCircle extends StatelessWidget {
  const ImageCircle({
    Key key,
    @required this.imagelink,
    @required this.topmargin,
    @required this.leftmargin,
    this.borderradius = 21,
    this.sizeraidus = 20,
    this.borderColor = Colors.black12,
  }) : super(key: key);

  final String imagelink;
  final double topmargin;
  final double leftmargin;
  final double borderradius;
  final double sizeraidus;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: leftmargin, top: topmargin),
      child: CircleAvatar(
        backgroundColor: borderColor,
        radius: borderradius,
        child: CircleAvatar(
          foregroundColor: Theme.of(context).primaryColor,
          backgroundColor: Colors.white,
          radius: sizeraidus,
          backgroundImage: NetworkImage(imagelink),
        ),
      ),
    );
  }
}
