import 'package:get/get.dart';
import 'package:untitled1/src/models/Order.dart';
import 'package:untitled1/src/providers/orders_provider.dart';

class RestaurantOrdersListController extends GetxController {
  OrdersProvider ordersProvider = OrdersProvider();
  List<String> status = <String>['PAGADO', 'DESPACHADO', 'EN CAMINO', 'ENTREGADO'].obs;

  Future<List<Order>> getOrders(String status) async {
    return await ordersProvider.findByStatus(status);
  }

  void goToOrderDetail (Order order) {
    Get.toNamed('/restaurant/orders/detail', arguments: {
      'order': order.toJson()
    });
  }
}