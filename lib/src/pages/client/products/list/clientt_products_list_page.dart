import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled1/src/pages/client/products/list/client_products_list_controller.dart';

class ClientProductsListPage extends StatelessWidget {

  ClientProductsListController con = Get.put(ClientProductsListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Client Products List'),
            ElevatedButton(
              onPressed: () => con.signOut(),
              child: Column(
                children: [
                  Text(
                    'Cerrar sesion',

                    style: TextStyle(
                        color: Colors.black
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
