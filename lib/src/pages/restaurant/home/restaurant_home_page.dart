import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled1/src/pages/client/home/client_home_controller.dart';
import 'package:untitled1/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:untitled1/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:untitled1/src/pages/restaurant/categories/create/restaurant_categories_create_page.dart';
import 'package:untitled1/src/pages/restaurant/home/restaurant_home_controller.dart';
import 'package:untitled1/src/pages/restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:untitled1/src/pages/restaurant/products/restaurant_products_create_page.dart';
import 'package:untitled1/src/utils/custom_animated_bottom_bar.dart';

class RestaurantHomePage extends StatelessWidget {

  RestaurantHomeController con = Get.put(RestaurantHomeController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        bottomNavigationBar: _bottomBar(),
        body: Obx(() => IndexedStack(
          index: con.indexTab.value,
          children: [
            RestaurantOrdersListPage(),
            RestaurantCategoriesCreatePage(),
            RestaurantProductsCreatePage(),
            ClientProfileInfoPage()

          ],
        ))
    );
  }Widget _bottomBar() {
    return Obx(() => CustomAnimatedBottomBar(
      containerHeight: 70,
      backgroundColor: Colors.amber,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      selectedIndex: con.indexTab.value,
      onItemSelected: (index) => con.changeTab(index),
      items: [
        BottomNavyBarItem(
            icon: Icon(Icons.list),
            title: Text('Pedidos'),
            activeColor: Colors.white,
            inactiveColor: Colors.black
        ),
        BottomNavyBarItem(
            icon: Icon(Icons.category),
            title: Text('Categoria'),
            activeColor: Colors.white,
            inactiveColor: Colors.black
        ),
        BottomNavyBarItem(
            icon: Icon(Icons.restaurant),
            title: Text('Productos'),
            activeColor: Colors.white,
            inactiveColor: Colors.black
        ),BottomNavyBarItem(
            icon: Icon(Icons.person),
            title: Text('Perfil'),
            activeColor: Colors.white,
            inactiveColor: Colors.black
        ),
      ],
    ));
  }
}
