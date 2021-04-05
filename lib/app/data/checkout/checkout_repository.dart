import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rasan_mart/app/modules/cart/views/cart_model.dart';
import 'package:rasan_mart/app/modules/cart/views/product_total_model.dart';
import 'package:rasan_mart/app/modules/checkout/delivery_model.dart';
import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';
import 'package:rasan_mart/app/modules/checkout/providers/checkout_provider.dart';

class CheckoutRepository implements CheckoutProvider {
  @override
  Future<Either<String, String>> deleteFromDelivery(
      String userId, String derliveryId) {
    // TODO: implement deleteFromDelivery
    throw UnimplementedError();
  }

  @override
  Future<Either<String, List<DeliveryTotalModel>>> fetchFromDelivery(
      String userId) {
    // TODO: implement fetchFromDelivery
    throw UnimplementedError();
  }

  @override
  Future<Either<String, DeliveryTotalModel>> saveToDelivery(
      String userId,
      List<CartModel> model,
      ProductPriceCalculation calculation,
      String paymentType,
      String paymentStatus) async {
    try {
      List<DeliveryModel> deliveryModel = [];
      bool complete = false;
      String id = '';
      DateTime now = DateTime.now();
      DateFormat formatter = DateFormat('yyyy-MM-dd');

      Map<String, dynamic> pricing = {
        'totalitems': calculation.totalItems,
        'totalprice': calculation.totalprice,
        'totaldiscount': calculation.totaldiscount,
        'totaldiscountprice': calculation.totaldiscountprice,
        'deliverycharge': calculation.deliverycharge,
        'grandtotal': calculation.grandTotal,
        'coupen': calculation.coupen,
        'orderStatus': 'Ordered',
        'orderDate': formatter.format(now),
        'paymentMode': paymentType,
        'paymentStatus': paymentStatus,
        'shippingDate': '',
        'deliveryDate': '',
      };

      await FirebaseFirestore.instance
          .collection('Delivery')
          .doc(userId)
          .collection('userOrder')
          .add(pricing)
          .then((value) async {
        for (CartModel element in model) {
          deliveryModel.add(DeliveryModel(
              id: value.id,
              productId: element.product.productId,
              productName: element.product.productName,
              rate: element.product.productPrice,
              price: element.product.price,
              qty: element.product.qty));

          id = value.id;

          Map<String, dynamic> data = {
            'Id': value.id,
            'productId': element.product.productId,
            'productName': element.product.productName,
            'rate': element.product.productPrice,
            'qty': element.product.qty,
            'price': element.product.price,
          };
          await FirebaseFirestore.instance
              .collection('Delivery')
              .doc(userId)
              .collection('userOrder')
              .doc(value.id)
              .collection('Orders')
              .add(data)
              .then((value) async {
            for (CartModel mod in model) {
              await FirebaseFirestore.instance
                  .collection(userId)
                  .doc(mod.cartId)
                  .delete();
            }
          });
        }
      }).whenComplete(() => complete = true);

      if (complete) {
        return right(DeliveryTotalModel(
            id: id,
            deliverymodel: deliveryModel,
            totalprice: calculation.totalprice,
            grandtotal: calculation.grandTotal,
            totalproduct: calculation.totalItems,
            discount: calculation.totaldiscountprice,
            deliveryCharge: calculation.deliverycharge,
            paymentMode: paymentType,
            paymentStatus: paymentStatus,
            orderData: formatter.format(now),
            orderStatus: 'Ordered',
            shippingDate: '',
            deliveryDate: ''));
      } else {
        return left('Error while Ordering please try again!');
      }
    } catch (error) {
      return left('Error on performing Transaction.');
    }
  }
}
