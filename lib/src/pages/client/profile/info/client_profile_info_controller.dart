

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled1/src/models/user.dart';

class ClientProfileInfoController extends GetxController{
var user = User.fromJson(GetStorage().read('user') ?? {}).obs;

void signOut(){
  GetStorage().remove('address');
  GetStorage().remove('shoping_bag');
  GetStorage().remove('user');
  Get.offNamedUntil('/', (route) => false);
}
void goToProfileUpdate(){
  Get.toNamed('/client/profile/update');
}
void goToRoles(){
  //eliminar todo el historial de pantallas
  Get.offNamedUntil('/roles', (route) => false);
}

}