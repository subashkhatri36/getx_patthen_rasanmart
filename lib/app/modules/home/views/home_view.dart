import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rasan_mart/app/Widgets/Gridview_categories.dart';
import 'package:rasan_mart/app/Widgets/app_drawer.dart';
import 'package:rasan_mart/app/Widgets/appbar/custome_appbar.dart';
import 'package:rasan_mart/app/Widgets/bottom_navigationbar.dart';
import 'package:rasan_mart/app/modules/customeproductpage/controllers/customeproductpage_controller.dart';
import 'package:rasan_mart/app/modules/customeproductpage/views/customeproductpage_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final homecontroller = Get.put(HomeController());
  int _selectedIndex = 0;

  final productcontianerContorller = Get.put(CustomeproductpageController());

  Widget returnScreenValue(int _index) {
    switch (_index) {
      case 0:
        productcontianerContorller.changeCategories('Home');
        return CustomeproductpageView();
        break;
      case 1:
        return CategoriesGridView(true);
        break;
      case 2:
        return Text('Account');
        break;
      default:
        return Container();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      drawer: AppDrawer(),
      body: returnScreenValue(_selectedIndex),
      // drawer: AppDrawer(),
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }

  BottomNavigationBar buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      items: navItemsList,
      currentIndex: _selectedIndex,
      selectedItemColor: Theme.of(context).backgroundColor,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex != 0) homecontroller.showSearchBar(false);
    });
  }
}
