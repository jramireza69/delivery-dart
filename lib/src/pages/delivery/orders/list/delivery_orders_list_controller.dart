import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled1/src/models/Order.dart';
import 'package:untitled1/src/models/user.dart';
import 'package:untitled1/src/providers/orders_provider.dart';

class DeliveryOrdersListController extends GetxController {
  OrdersProvider ordersProvider = OrdersProvider();
  List<String> status = <String>[ 'DESPACHADO', 'EN CAMINO', 'ENTREGADO'].obs;

  User user = User.fromJson(GetStorage().read('user') ?? {});
  
  Future<List<Order>> getOrders(String status) async {
    return await ordersProvider.findByDeliveryAndStatus(user.id ?? '0',status);
  }

  void goToOrderDetail (Order order) {
    Get.toNamed('/delivery/orders/detail', arguments: {
      'order': order.toJson()
    });
  }
}