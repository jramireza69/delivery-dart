import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:untitled1/src/models/Order.dart';
import 'package:untitled1/src/models/response_api.dart';
import 'package:untitled1/src/models/user.dart';
import 'package:untitled1/src/providers/orders_provider.dart';
import 'package:untitled1/src/providers/users_providers.dart';

class RestaurantOrdersDetailController extends GetxController {

  Order order = Order.fromJson(Get.arguments['order']);

    var total = 0.0.obs;
    var idDelivery = ''.obs;

    UsersProviders usersProviders = UsersProviders();
    OrdersProvider ordersProvider = OrdersProvider();
    List<User> users = <User>[].obs;
     RestaurantOrdersDetailController(){
       print('Order: ${order.toJson()}');
       getDeliveryMen();
       getTotal();
       }

  void updateOrder() async {
    if (idDelivery.value != '') { // SI SELECCIONO EL DELIVERY
      order.idDelivery = idDelivery.value;
      ResponseApi responseApi = await ordersProvider.updateToDispatched(order);
      Fluttertoast.showToast(msg: responseApi.message ?? '', toastLength: Toast.LENGTH_LONG);
      if (responseApi.success == true) {
        Get.offNamedUntil('/restaurant/home', (route) => false);
      }
    }
    else {
      Get.snackbar('Peticion denegada', 'Debes asignar el repartidor');
        }
     }

    void getDeliveryMen() async {
      var result = await usersProviders.findDeliveryMen();
      users.clear();
      users.addAll(result);
    }

  void getTotal() {
    total.value = 0.0;
    order.products!.forEach((product) {
      total.value = total.value + (product.quantity! * product.price!);
    });
  }

}