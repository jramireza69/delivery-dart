import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled1/src/models/Order.dart';
import 'package:untitled1/src/models/address.dart';
import 'package:untitled1/src/models/product.dart';
import 'package:untitled1/src/models/response_api.dart';
import 'package:untitled1/src/models/user.dart';
import 'package:untitled1/src/providers/address_provider.dart';
import 'package:untitled1/src/providers/orders_provider.dart';

class ClientAddressListController  extends GetxController {

    List<Address>  address = [];
    AddressProvider addressProvider = AddressProvider();
    OrdersProvider ordersProvider = OrdersProvider();

    User user = User.fromJson(GetStorage().read('user') ?? {});
    var radioValue = 0.obs;

    ClientAddressListController() {
      print('LA DIRECCION DE SESSION ES ${GetStorage().read('address')} ');
    }

    Future<List<Address>> getAddress() async {
      address = await addressProvider.findByUser(user.id ?? '');

      Address a = Address.fromJson(GetStorage().read('address') ?? {}) ; // DIRECCION SELECCIONADA POR EL USUARIO

      int index = address.indexWhere((ad) => ad.id == a.id);

      if (index != -1) { // LA DIRECCION DE SESION COINCIDE CON UN DATOS DE LA LISTA DE DIRECCIONES
        radioValue.value = index;
      }
      return address;
    }

    void handleRadioValueChange(int? value) {
      radioValue.value = value!;
      print('VALOR SELECCIONADO ${value}');
      GetStorage().write('address', address[value].toJson());
      update();
    }
    void goToAddressCreate() {
      Get.toNamed('/client/address/create');
  }

    void createOrder() async {
      Address a = Address.fromJson(GetStorage().read('address') ?? {}) ;
      List<Product> products = [];
      if(GetStorage().read('shoping_bag') is List<Product>) {
        products = GetStorage().read('shoping_bag');
      }else {

       products = Product.fromJsonList(GetStorage().read('shoping_bag'));
      }

         Order order = Order(
           idClient: user.id,
           idAddress: a.id,
           products: products
         );
         ResponseApi responseApi = await ordersProvider.create(order);
            Fluttertoast.showToast(msg: responseApi.message ?? '', toastLength: Toast.LENGTH_SHORT);
         if(responseApi.success == true ){
           GetStorage().remove('shoping_bag');
           Get.toNamed('/client/payments/create');
         }
    }

}