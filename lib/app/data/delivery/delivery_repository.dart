import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rasan_mart/app/modules/checkout/delivery_model.dart';
import 'package:dartz/dartz.dart';
import 'package:rasan_mart/app/modules/checkout/providers/delivery_provider.dart';

class DeliveryRepository implements DeliveryProvider {
  @override
  Future<Either<String, String>> cancelOrder(
      String userId, DeliveryTotalModel model, String docId) async {
    try {
      bool complete = false;
      bool alreadyshiped = false;

      await FirebaseFirestore.instance
          .collection('Delivery')
          .doc(userId)
          .collection('userOrder')
          .doc(docId)
          .get()
          .then((value) {
        if (value['OrderStatus'] == 'Ordered') {
          alreadyshiped = true;
        }
      });
      if (alreadyshiped) {
        return left(
            'The product You order already shipped to your location. We are unable to cancel your Order. For more Info please read our policy.');
      } else {
        await FirebaseFirestore.instance
            .collection('Delivery')
            .doc(userId)
            .collection('userOrder')
            .doc(docId)
            .delete()
            .whenComplete(() => complete = true);
        if (complete) {
          return right('Successfully Cancelled your Order');
        } else {
          return left('Sorry Something went wrong while cancelling your Order');
        }
      }
    } catch (error) {
      return left('An Error Occured while performing transaction.');
    }
  }

  @override
  Future<Either<String, List<DeliveryTotalModel>>> fetchDeliveryOrder(
      String userId) async {
    try {
      List<DeliveryTotalModel> userOrders = [];
      bool complete = false;

      await FirebaseFirestore.instance
          .collection('Delivery')
          .doc(userId)
          .collection('userOrder')
          .where(
            'orderStatus',
            isNotEqualTo: 'Completed',
          )
          .get()
          .then((value) async {
        for (QueryDocumentSnapshot element in value.docs) {
          List<DeliveryModel> deliveryMode = [];
          await FirebaseFirestore.instance
              .collection('Delivery')
              .doc(userId)
              .collection('userOrder')
              .doc(element.id)
              .collection('Orders')
              .get()
              .then((value) {
            value.docs.forEach((model) {
              deliveryMode.add(DeliveryModel(
                id: model.id,
                price: model['price'],
                productId: model['productId'],
                productName: model['productName'],
                qty: model['qty'],
                rate: model['rate'],
              ));
            });

            userOrders.add(DeliveryTotalModel(
              deliverymodel: deliveryMode,
              deliveryDate: element['dekuvertDate'],
              deliveryCharge: element['deliverycharge'],
              shippingDate: element['shippingDate'],
              grandtotal: element['grandtotal'],
              orderStatus: element['orderStatus'],
              orderData: element['orderDate'],
              paymentStatus: element['paymentStatus'],
              paymentMode: element['paymentMode'],
              totalprice: element['totalprice'],
              totalproduct: element['totalitems'],
              discount: element['totaldiscountprice'],
              id: element.id,
              coupen: element['coupen'],
            ));
          });
        }
      }).whenComplete(() => complete = true);
      if (complete) {
        return right(userOrders);
      } else {
        return left('Error while Fetching data');
      }
    } catch (error) {
      return left('An Error Occured while fetching transaction.');
    }
  }
}
