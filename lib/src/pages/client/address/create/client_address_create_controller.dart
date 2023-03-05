import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:untitled1/src/models/address.dart';
import 'package:untitled1/src/models/response_api.dart';
import 'package:untitled1/src/models/user.dart';
import 'package:untitled1/src/pages/client/address/list/client_address_list_controller.dart';
import 'package:untitled1/src/providers/address_provider.dart';

import '../map/client_address_map_page.dart';

class ClientAddressCreateController extends GetxController {
  TextEditingController addressController = TextEditingController();
  TextEditingController neighborhoodController = TextEditingController();
  TextEditingController refPointController = TextEditingController();

  double latRefPoint = 0;
  double lngRefPoint = 0;

  User user = User.fromJson(GetStorage().read('user') ?? {});

  AddressProvider addressProvider = AddressProvider();

  ClientAddressListController clientAddressListController  = Get.find();
  void openGoogleMaps(BuildContext context) async {
    Map<String, dynamic> refPointMap = await showMaterialModalBottomSheet(
        context: context,
        builder: (context) => ClientAddressMapPage(),
        isDismissible: false,
        enableDrag: false);
    refPointController.text = refPointMap['address'];
    latRefPoint = refPointMap['lat'];
    lngRefPoint = refPointMap['lng'];
    print('Ref Point Map ${refPointMap}');
  }

  void createAddress() async {
    String addressName = addressController.text;
    String neighborhood = neighborhoodController.text;
    if (isValidForm(addressName, neighborhood)) {
      Address address = Address(
          address: addressName,
          neighborhood: neighborhood,
          lat: latRefPoint,
          lng: lngRefPoint,
          idUser: user.id);

      ResponseApi responseApi = await addressProvider.create(address);
      Fluttertoast.showToast(msg: responseApi.message ?? '', toastLength: Toast.LENGTH_LONG);

      if(responseApi.success == true) {
        address.id = responseApi.data;
        GetStorage().write('address', address.toJson());
        clientAddressListController.update();
         Get.back();

      }
    }
  }

  bool isValidForm(String address, String neighborhood) {
    if (address.isEmpty) {
      Get.snackbar('formulario no valido', 'ingresa el nombre de la direccion');
      return false;
    }
    if (neighborhood.isEmpty) {
      Get.snackbar('formulario no valido', 'ingresa el nombrel barrio');
      return false;
    }
    if (latRefPoint == 0) {
      Get.snackbar('formulario no valido', 'selecciona el punto de referencia');
      return false;
    }
    if (lngRefPoint == 0) {
      Get.snackbar('formulario no valido', 'selecciona el punto de referencia');
      return false;
    }
    return true;
  }
}
