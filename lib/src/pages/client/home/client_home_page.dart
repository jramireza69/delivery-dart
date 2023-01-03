import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled1/src/pages/client/home/home_controller.dart';

class HomePage extends StatelessWidget {

  ClientHomeController con = Get.put(ClientHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => con.signOut(),
          child: Text(
            'Cerrar sesion',
            style: TextStyle(
                color: Colors.black
            ),
          ),
        ),
      ),
    );
  }
}
