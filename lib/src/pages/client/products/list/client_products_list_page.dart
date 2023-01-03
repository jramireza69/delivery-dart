import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled1/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:untitled1/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:untitled1/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:untitled1/src/pages/restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:untitled1/src/utils/custom_animated_bottom_bar.dart';



class ClientProductsListPage extends StatelessWidget {

  ClientProductsListController con = Get.put(ClientProductsListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottonBar(),
      body: Obx(() =>  IndexedStack(
        index: con.indexTab.value,
        children: [
          RestaurantOrdersListPage(),
          DeliveryOrdersListPage(),
          ClientProfileInfoPage()
        ],
      ))
    );
  }

  Widget _bottonBar(){
    return  Obx(() =>  CustomAnimatedBottomBar(
      containerHeight: 70,
        backgroundColor: Colors.amber,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        selectedIndex: con.indexTab.value,
      onItemSelected: (index) => con.changeTab(index),
        items: [
          BottomNavyBarItem(
              icon: Icon(Icons.apps),
              title: Text('HOME'),
            activeColor: Colors.white,
            inactiveColor: Colors.white

          ),
          BottomNavyBarItem(
              icon: Icon(Icons.list),
              title: Text('Mis Pedidos'),
              activeColor: Colors.white,
              inactiveColor: Colors.white
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.person),
              title: Text('Perfil'),
              activeColor: Colors.white,
              inactiveColor: Colors.white
          ),
        ],
        ));
  }
}
