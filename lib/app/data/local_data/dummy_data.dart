import 'package:flutter/material.dart';
import 'package:rasan_mart/app/modules/customeproductpage/categories_model.dart';
import 'package:rasan_mart/app/modules/customeproductpage/product_contianer_model.dart';
import 'package:rasan_mart/app/modules/customeproductpage/product_model.dart';
import 'package:rasan_mart/app/modules/customeproductpage/scroll_banner_model.dart';

List<Product> productlist = [
  Product(
      productOnDiscount: false,
      productName: 'Almonds Almonds AlmondsA lmondsAl mond  sAlmondsAlmonds',
      productImages: [
        'https://images.indianexpress.com/2015/04/biscuit-main.jpg',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSptLHALWW_lkrl4AbHF9peot3RxC81RRzUKQ&usqp=CAU',
        'https://images.indianexpress.com/2015/04/biscuit-main.jpg',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSptLHALWW_lkrl4AbHF9peot3RxC81RRzUKQ&usqp=CAU',
        'https://images.indianexpress.com/2015/04/biscuit-main.jpg',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSptLHALWW_lkrl4AbHF9peot3RxC81RRzUKQ&usqp=CAU',
      ],
      productCuttedPrice: 260,
      productOnSale: false,
      productDiscount: 23.1,
      productDiscountType: 'Percentage',
      productPrice: 200,
      productDescription: [
        'It typically includes the product features and benefits, highlighting why a visitor should consider making a purchase.',
        'A good product description also includes specifications like shape, size, dimensions and other relevant parameters that can help the online shopper visualise the product better.',
        'The definition of a description is a statement that gives details about someone or something.',
      ],
      productId: '01',
      backgroundColor: ''),
  Product(
    productOnDiscount: true,
    productName: 'Makhana',
    productImages: [
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlDqUJfS4Pjql3SF9XzAsbZglCj29x0exKbw&usqp=CAU'
    ],
    productCuttedPrice: 260,
    productOnSale: true,
    productDiscount: 23.1,
    productDiscountType: 'Percentage',
    productPrice: 201,
    productDescription: [
      'It typically includes the product features and benefits, highlighting why a visitor should consider making a purchase.',
      'A good product description also includes specifications like shape, size, dimensions and other relevant parameters that can help the online shopper visualise the product better.',
      'The definition of a description is a statement that gives details about someone or something.',
    ],
    productId: '02',
    backgroundColor: '',
  ),
  Product(
    productOnDiscount: true,
    productName: 'Nariwal',
    productImages: [
      'https://www.nextbigbrand.in/wp-content/uploads/2020/03/parle-agencies.jpg'
    ],
    productCuttedPrice: 260,
    productOnSale: true,
    productDiscount: 23,
    productDiscountType: 'Percentage',
    productPrice: 202,
    productDescription: [
      'It typically includes the product features and benefits, highlighting why a visitor should consider making a purchase.',
      'A good product description also includes specifications like shape, size, dimensions and other relevant parameters that can help the online shopper visualise the product better.',
      'The definition of a description is a statement that gives details about someone or something.',
    ],
    productId: '03',
    backgroundColor: '',
  ),
  Product(
    productOnDiscount: true,
    productName: 'Misri',
    productImages: ['https://content.etilize.com/images/900/1022643061.jpg'],
    productCuttedPrice: 260,
    productOnSale: true,
    productDiscount: 23.1,
    productDiscountType: 'Percentage',
    productPrice: 203,
    productDescription: [
      'It typically includes the product features and benefits, highlighting why a visitor should consider making a purchase.',
      'A good product description also includes specifications like shape, size, dimensions and other relevant parameters that can help the online shopper visualise the product better.',
      'The definition of a description is a statement that gives details about someone or something.',
    ],
    productId: '04',
    backgroundColor: '',
  ),
];

List<ProductContianer> get productContainerdata => [
      //for search its alwys in top
      new ProductContianer(
        layoutindex: 0,
        layoutType: 0,
        backgroundColor: Color(0xfff2f2f2),
        containerTitle: '',
        productIdList: null,
      ),
      //for categories
      new ProductContianer(
        layoutindex: 2,
        layoutType: 3,
        backgroundColor: Color(0xfff2f2f2),
        containerTitle: '',
        productIdList: null,
      ),
      //for banner
      new ProductContianer(
        layoutindex: 1,
        layoutType: 4,
        backgroundColor: Color(0xfff2f2f2),
        containerTitle: '',
        productIdList: null,
      ),
      //for horizental product
      new ProductContianer(
        layoutindex: 3,
        layoutType: 1,
        backgroundColor: Color(0xfff2f2f2),
        containerTitle: 'Latest Products',
        productIdList: ['01', '03', '04'],
      ),

      //for gridview product
      new ProductContianer(
        layoutindex: 4,
        layoutType: 2,
        backgroundColor: Color(0xfff2f2f2),
        containerTitle: 'GridView Products',
        productIdList: ['02', '03', '04', '01'],
      ),
      //for horizental product
      new ProductContianer(
        layoutindex: 5,
        layoutType: 1,
        backgroundColor: Color(0xfff2f2f2),
        containerTitle: 'Hori Products',
        productIdList: ['04', '02', '01'],
      ),
    ];

List<ScrollBanner> scrollbanner = [
  new ScrollBanner(
    imagepath:
        'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/45b7de97376281.5ec3ca8c1d324.jpg',
    index: 1,
  ),
  new ScrollBanner(
    imagepath:
        'https://cdn.dribbble.com/users/3270761/screenshots/14551267/media/72eb19bdc168197233d791b0c05f2e46.png?compress=1&resize=400x300',
    index: 2,
  ),
  new ScrollBanner(
    imagepath:
        'https://img.freepik.com/free-psd/restaurant-banner-template_23-2148466832.jpg?size=626&ext=jpg',
    index: 3,
  ),
  new ScrollBanner(
    imagepath:
        'https://i.pinimg.com/originals/92/bb/f4/92bbf4d43c8764a36e8568b9fbfbc5bf.jpg',
    index: 4,
  ),
];
List<Categories> get categoriesList => [
      new Categories(
        categoryName: 'GROCERY'.toUpperCase(),
        categoryPath: 'assets/images/logo.PNG',
      ),
    ];
