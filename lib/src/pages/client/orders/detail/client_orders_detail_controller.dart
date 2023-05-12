import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:untitled1/src/models/Order.dart';
import 'package:untitled1/src/models/response_api.dart';
import 'package:untitled1/src/models/user.dart';
import 'package:untitled1/src/providers/orders_provider.dart';
import 'package:untitled1/src/providers/users_providers.dart';

class ClientOrdersDetailController extends GetxController {

  Order order = Order.fromJson(Get.arguments['order']);

    var total = 0.0.obs;
    var idDelivery = ''.obs;

    UsersProviders usersProviders = UsersProviders();
    OrdersProvider ordersProvider = OrdersProvider();
    List<User> users = <User>[].obs;
  ClientOrdersDetailController(){
       print('Order: ${order.toJson()}');
       getTotal();
       }

     void goToOrderMap(){
       Get.toNamed('/client/orders/map' , arguments: {
         'order': order.toJson()
       }) ;
     }

  void getTotal() {
    total.value = 0.0;
    order.products!.forEach((product) {
      total.value = total.value + (product.quantity! * product.price!);
    });
  }

}