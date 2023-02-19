import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:untitled1/src/pages/client/address/map/client_address_map_controller.dart';

class ClientAddressMapPage extends StatelessWidget {

  ClientAddressMapController con = Get.put( ClientAddressMapController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
            color: Colors.black
        ),
        title: Text(
            'Ubica tu direccion en el mapa',
          style: TextStyle(
            color: Colors.black
          ),
        ),
      ),
      body: Stack(
        children: [
          _googleMap(),
          _iconMyLocation(),
          _cardAddress(),
          Spacer(),
          _buttonAccept(context)
        ],
      ),
    );
  }

  Widget _googleMap(){
    return GoogleMap(
      initialCameraPosition: con.initialPosition,
      mapType: MapType.normal,
      onMapCreated: con.onMapCreate,
      myLocationButtonEnabled: false,
      myLocationEnabled: false,
      onCameraMove: (position) {
        con.initialPosition = position;
      },
    );
  }
  Widget _iconMyLocation() {
    return Container(
      margin: EdgeInsets.only(bottom: 60),
      child: Center(
        child: Image.asset(
          'assets/img/my_location.png',
          width: 65,
          height: 65,
        ),
      ),
    );
  }
  Widget _cardAddress() {
    return Container(
      width: double.infinity,
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.symmetric(vertical: 30),
      child: Card(
        color: Colors.grey[800],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: const Text(
            'con.addressName.value',
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
  Widget _buttonAccept(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 30),
      child: ElevatedButton(
        onPressed: () {},
        child: Text(
          'SELECCIONAR ESTE PUNTO',
          style: TextStyle(color: Colors.black),
        ),
        style: ElevatedButton.styleFrom(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: EdgeInsets.all(15)),
      ),
    );
  }
}
