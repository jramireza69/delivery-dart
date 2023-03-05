import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'client_address_create_controller.dart';

class ClientAddressCreatePage extends StatelessWidget {
  ClientAddressCreateController con = Get.put(ClientAddressCreateController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _backgroundCover(context),
          _boxForm(context),
        ],
      ),
    );
  }

  Widget _backgroundCover(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.35,
      color: Colors.amber,
    );
  }

  Widget _boxForm(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.3, left: 50, right: 50),
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black54, blurRadius: 15, offset: Offset(0, 0.75))
          ]),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _textYourInfo(),
            _textFieldAddress(),
            _textFieldNeighbordhood(),
            _textFieldRefPoint(context),
            const SizedBox(
              height: 20,
            ),
            _buttonCreate(context)
          ],
        ),
      ),
    );
  }

  Widget _textFieldAddress() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: con.addressController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
            hintText: 'Direccion', prefixIcon: Icon(Icons.category)),
      ),
    );
  }

  Widget _textFieldNeighbordhood() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: con.neighborhoodController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
            hintText: 'Barrio', prefixIcon: Icon(Icons.location_city)),
      ),
    );
  }

  Widget _textFieldRefPoint(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        onTap: () => con.openGoogleMaps(context),
        controller: con.refPointController,
        autofocus: false,
        focusNode: AlwaysDisabledFocusNode(),
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
            hintText: 'Referencia', prefixIcon: Icon(Icons.map)),
      ),
    );
  }

  Widget _buttonCreate(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: ElevatedButton(
          onPressed: () {
            con.createAddress();
          },
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15)),
          child: Text(
            'CREAR DIRECCION',
            style: TextStyle(color: Colors.black),
          )),
    );
  }

  Widget _textNewAddress(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        alignment: Alignment.topCenter,
        child: Column(
          children: const [
            Icon(Icons.location_on, size: 100),
            Text(
              'NUEVA DIRECCION',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textYourInfo() {
    return Container(
      margin: const EdgeInsets.only(top: 40, bottom: 30),
      child: const Text(
        'INGRESA ESTA INFORMACION',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
