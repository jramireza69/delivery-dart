import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled1/src/models/address.dart';
import 'package:untitled1/src/models/user.dart';
import 'package:untitled1/src/providers/address_provider.dart';

class ClientAddressListController  extends GetxController {

    List<Address>  address = [];
    AddressProvider addressProvider = AddressProvider();

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

}