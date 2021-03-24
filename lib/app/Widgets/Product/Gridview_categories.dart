import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';
import 'package:rasan_mart/app/modules/customeproductpage/categories_model.dart';
import 'package:rasan_mart/app/modules/customeproductpage/controllers/category_controller.dart';

class CategoriesGridView extends GetView {
  final bool istabclick;

  CategoriesGridView(this.istabclick); // = widget.istabclick;
  // final _controller = Get.find<MainProductContainerController>();
  final categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Defaults.defaultfontsize),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!istabclick)
              Container(
                margin: EdgeInsets.only(left: Defaults.defaultfontsize),
                child: Text(
                  'Categories',
                  style: TextStyle(
                      fontSize: Defaults.defaultfontsize + 5,
                      fontWeight: FontWeight.bold),
                ),
              ),
            SizedBox(height: Defaults.defaultfontsize),
            Obx(() => Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Defaults.defaultfontsize / 2),
                child: categoryController.isCategoryLoading.isTrue
                    ? Center(
                        child: Column(
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: Defaults.defaultPadding),
                            Text('Loading...')
                          ],
                        ),
                      )
                    : istabclick
                        ? buildListView(
                            categories: categoryController.categories)
                        : buildGridView(
                            context: context,
                            categories: categoryController.categories))),
          ],
        ),
      ),
    );
  }

//creating listview for the categories tabs
  ListView buildListView({List<Categories> categories}) => ListView.separated(
      separatorBuilder: (context, index) {
        return Divider();
      },
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: categories?.length ?? 0,
      itemBuilder: (context, index) {
        return Container(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              CachedNetworkImage(
                imageUrl: categories[index].categoryPath,
                fadeInDuration: Duration(milliseconds: 1),
                imageBuilder: (context, imageProvider) => Container(
                  height: Defaults.defaultPadding * 2.5,
                  width: Defaults.defaultPadding * 2.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => CircularProgressIndicator(
                  strokeWidth: 0.5,
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              SizedBox(width: Defaults.defaultPadding),
              Text(
                categories[index].categoryName,
                overflow: TextOverflow.fade,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Defaults.defaultfontsize),
                maxLines: 2,
              ),
            ]),
            Icon(Icons.arrow_forward_ios),
          ]),
        );
      });

  GridView buildGridView({BuildContext context, List<Categories> categories}) {
    return GridView.count(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisSpacing: 4,
        mainAxisSpacing: 1,
        crossAxisCount: istabclick ? 3 : 4,
        children: List.generate(
          categories.length > 8 ? 8 : categories?.length,
          (index) {
            // print(categories[index].categoryPath);
            return Container(
              width: MediaQuery.of(context).size.width * 0.10,
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: categories[index].categoryPath,
                    fadeInDuration: Duration(milliseconds: 1),
                    imageBuilder: (context, imageProvider) => Container(
                      height: Defaults.defaultPadding * 2,
                      width: Defaults.defaultPadding * 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => CircularProgressIndicator(
                      strokeWidth: 0.5,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  SizedBox(height: Defaults.defaultfontsize / 3),
                  Text(
                    categories[index].categoryName,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Defaults.defaultfontsize / 1.2),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ],
              ),
            );
          },
        ));
  }
}
