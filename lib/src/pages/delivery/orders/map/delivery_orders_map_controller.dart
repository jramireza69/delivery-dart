import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location;
import 'package:untitled1/src/models/Order.dart';
import 'package:untitled1/src/providers/orders_provider.dart';

class DeliveryOrdersMapController extends GetxController {

  Order order = Order.fromJson(Get.arguments['order'] ?? {});
  OrdersProvider ordersProvider = OrdersProvider();
  CameraPosition initialPosition =
      CameraPosition(target: LatLng(6.2292512, -75.5629398), zoom: 14);

  LatLng? addressLatLng;
  var addressName = ''.obs;

  Completer<GoogleMapController> mapController = Completer();
  Position? position;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{}.obs;
  BitmapDescriptor? deliveryMarker;
  BitmapDescriptor? homeMarker;

  StreamSubscription? positionSubscribe;

  DeliveryOrdersMapController() {
    print('ORder: ${order.toJson()}');
    checkGPS(); //INICIE VERIFICANDO SI EL GPS ESTA ACTIVO Y REQUERIR LOS SERVICIOS
    print('variable home marker  ${deliveryMarker}');
  }

  void saveLocation() async {
    if(position != null ){

      order.lat = position!.latitude;
      order.lng = position!.longitude;

      await ordersProvider.updateLatLng(order);



    }

  }
  Future animateCameraPosition(double lat, double lng) async {
    GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 13, bearing: 0)));
  }

  Future setLocationDraggableInfo() async {
    double lat = initialPosition.target.latitude;
    double lng = initialPosition.target.longitude;

    List<Placemark> address = await placemarkFromCoordinates(lat, lng);

    if (address.isNotEmpty) {
      String direction = address[0].thoroughfare ?? '';
      String street = address[0].subThoroughfare ?? '';
      String city = address[0].locality ?? '';
      String department = address[0].administrativeArea ?? '';
      String country = address[0].country ?? '';
      addressName.value = '$direction #$street, $city, $department';
      addressLatLng = LatLng(lat, lng);
      print(
          'LAT Y LNG: ${addressLatLng?.latitude ?? 0} ${addressLatLng?.longitude ?? 0}');
    }
  }

  void checkGPS() async {
    deliveryMarker = await createMarkerFromAssets('assets/img/delivery_little.png');
    homeMarker     = await createMarkerFromAssets('assets/img/home.png');
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if (isLocationEnabled == true) {
      updateLocation();
    } else {
      bool locationGPS = await location.Location().requestService();
      if (locationGPS == true) {
        updateLocation();
      }
    }
  }

  void updateLocation() async {
    try {
      await _determinePosition();
      position = await Geolocator.getLastKnownPosition(); //LAT Y LNG MY ACTUAL POSITION
      saveLocation();
      animateCameraPosition(position?.latitude ?? 6.2292512, position?.longitude ?? -75.5629398);
      addMarker('Delivery',
          position?.latitude ?? 6.236189 ,
          position?.longitude ?? -75.589022,
          'Tu posicion',
          '',
          deliveryMarker!);
      addMarker('Home',
          order.address?.lat ?? 6.2292512 ,
          order.address?.lng ?? -75.5629398,
          'lugar de entrega',
          '',
          homeMarker!);

      LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.best,
          distanceFilter: 1
      );

      positionSubscribe = Geolocator.getPositionStream(locationSettings: locationSettings ).listen((Position positionRealTime)
      {
        position = positionRealTime;
        addMarker('Delivery',
            position?.latitude ?? 6.236189 ,
            position?.longitude ?? -75.589022,
            'Tu posicion',
            '',
            deliveryMarker!);
        animateCameraPosition(position?.latitude ?? 6.2292512, position?.longitude ?? -75.5629398);
      });
    } catch (e) {
      print('Error ${e}');
    }
  }

  void selectRefPoint(BuildContext context) {
    if (addressLatLng != null) {
      Map<String, dynamic> dataDir = {
        'address': addressName.value,
        'lat': addressLatLng!.latitude,
        'lng': addressLatLng!.longitude
      };
      Navigator.pop(context, dataDir); //permite volver atraz
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  void onMapCreate(GoogleMapController controller) {
    controller.setMapStyle(
        '[{"elementType":"geometry","stylers":[{"color":"#212121"}]},{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#212121"}]},{"featureType":"administrative","elementType":"geometry","stylers":[{"color":"#757575"}]},{"featureType":"administrative.country","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"administrative.land_parcel","stylers":[{"visibility":"off"}]},{"featureType":"administrative.locality","elementType":"labels.text.fill","stylers":[{"color":"#bdbdbd"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#181818"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"poi.park","elementType":"labels.text.stroke","stylers":[{"color":"#1b1b1b"}]},{"featureType":"road","elementType":"geometry.fill","stylers":[{"color":"#2c2c2c"}]},{"featureType":"road","elementType":"labels.text.fill","stylers":[{"color":"#8a8a8a"}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#373737"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#3c3c3c"}]},{"featureType":"road.highway.controlled_access","elementType":"geometry","stylers":[{"color":"#4e4e4e"}]},{"featureType":"road.local","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"transit","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#000000"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#3d3d3d"}]}]');
    mapController.complete(controller);
  }

  centerPosition() {}

  Future<BitmapDescriptor> createMarkerFromAssets(String path) async {
          ImageConfiguration configuration = ImageConfiguration();
          BitmapDescriptor descriptor = await BitmapDescriptor.fromAssetImage(
              configuration, path
          );
          return descriptor;
  }
  void addMarker(
      String markerId,
      double lat,
      double lng,
      String title,
      String content,
      BitmapDescriptor iconMarker
      ){
    MarkerId id = MarkerId(markerId);
    Marker marker = Marker(
        markerId: id,
        icon: iconMarker,
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: title, snippet: content)
    );
    markers[id] = marker;
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    positionSubscribe?.cancel();
  }
}
