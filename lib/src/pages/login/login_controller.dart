




import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled1/src/models/response_api.dart';
import 'package:untitled1/src/providers/users_providers.dart';




class LoginController extends GetxController{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UsersProviders usersProviders = UsersProviders();

  void goToRegisterPage(){
    Get.toNamed('/register');
  }

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
   
    if (isValidForm(email, password)) {
      ResponseApi responseApi = await usersProviders.login(email, password);
      print('Response api:  ${responseApi.toJson()}');
      if(responseApi.success == true ) {
        GetStorage().write('user', responseApi.data);  //si todo esta bien almacenamos aca los datos del usuario
        goToHomePage();
       // Get.snackbar(
         //   'Login Exitoso', responseApi.message ?? '');  //validar el string por si viene nullo
      }else{
        Get.snackbar('Login fallido',  responseApi.message ?? '');
      }
    }
  }

  void goToHomePage(){
    Get.offNamedUntil('/home', (route) => false);
  }
  bool isValidForm(String email, String password) {

    if (email.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar el email');
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Formulario no valido', 'El email no es valido');
      return false;
    }

    if (password.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar el password');
      return false;
    }

    return true;
  }
}