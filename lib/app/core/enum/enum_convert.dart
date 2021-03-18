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
}
