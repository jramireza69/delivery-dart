import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled1/src/models/user.dart';

class HomeController extends GetxController{
User user = User.fromJson(GetStorage().read('user') ?? {});

HomeController(){
print('usuario de seccion: ${user.toJson()}');
}
void signOut(){
  GetStorage().remove('user');
  Get.offNamedUntil('/', (route) => false);
}
}