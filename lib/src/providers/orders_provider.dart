

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled1/src/environment/environment.dart';
import 'package:untitled1/src/models/Order.dart';
import 'package:untitled1/src/models/category.dart';
import 'package:untitled1/src/models/response_api.dart';
import 'package:untitled1/src/models/user.dart';

class OrdersProvider extends GetConnect {

  String url = '${Environment.API_URL}api/orders';

  User userSession = User.fromJson(GetStorage().read('user') ?? {});

  Future<List<Order>> findByStatus(String status) async {
    Response response = await get(
        '$url/findByStatus/$status',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': userSession.sessionToken ?? ''
        }
    ); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    if (response.statusCode == 401) {
      Get.snackbar('Peticion denegada', 'Tu usuario no tiene permitido leer esta informacion');
      return [];
    }
    List<Order> orders = Order.fromJsonList(response.body);
    return orders;
  }
  Future<List<Order>> findByDeliveryAndStatus(String idDelivery,String status) async {
    Response response = await get(
        '$url/findByDeliveryAndStatus/$idDelivery/$status',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': userSession.sessionToken ?? ''
        }
    ); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    if (response.statusCode == 401) {
      Get.snackbar('Peticion denegada', 'Tu usuario no tiene permitido leer esta informacion');
      return [];
    }
    List<Order> orders = Order.fromJsonList(response.body);
    return orders;
  }

  Future<ResponseApi> create(Order order) async {
    Response response= await post(
        '$url/create',
        order.toJson(),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': userSession.sessionToken ?? ''
        }
    ); //ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }

  Future<ResponseApi> updateToDispatched(Order order) async {
    Response response = await put(
        '$url/updateToDispatched',
        order.toJson(),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': userSession.sessionToken ?? ''
        }
    ); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }
  Future<ResponseApi> updateToOnTheWay(Order order) async {
    Response response = await put(
        '$url/updateToOnTheWay',
        order.toJson(),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': userSession.sessionToken ?? ''
        }
    ); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }

}