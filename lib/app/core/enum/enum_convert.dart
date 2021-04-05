import 'package:rasan_mart/app/core/enum/enums.dart';

class EnumConvertor {
  ContianerType containerConvert(int value) {
    switch (value) {
      case 0:
        return ContianerType.SearchBar;
        break;
      case 1:
        return ContianerType.Category;
        break;
      case 2:
        return ContianerType.BannerLayout;
        break;
      case 3:
        return ContianerType.HorizentalLayout;
        break;
      case 4:
        return ContianerType.GridviewLayout;
        break;
      default:
        return ContianerType.Category;
        break;
    }
  }

  DiscountType discountConvert(String value) {
    switch (value) {
      case 'Flat':
        return DiscountType.Flat;
        break;
      default:
        return DiscountType.Percentage;
        break;
    }
  }

  PaymentMode paymentMode(int val) {
    switch (val) {
      case 1:
        return PaymentMode.Khalti;
        break;
      case 2:
        return PaymentMode.ImePay;
        break;
      case 3:
        return PaymentMode.Esewa;
        break;
      case 4:
        return PaymentMode.PayPal;
        break;
      case 5:
        return PaymentMode.MasterCard;
        break;
      default:
        return PaymentMode.CashOnDelivery;
        break;
    }
  }

  String paymentString(PaymentMode paymentMode) {
    switch (paymentMode) {
      case PaymentMode.Khalti:
        return 'Khalti';
        break;
      case PaymentMode.ImePay:
        return 'Ime Pay';
        break;
      case PaymentMode.Esewa:
        return 'Esewa';
        break;
      case PaymentMode.PayPal:
        return 'Paypal';
        break;
      case PaymentMode.MasterCard:
        return 'Master or Visa Card';
        break;
      default:
        return 'Cash On Delivery';
        break;
    }
  }
}
