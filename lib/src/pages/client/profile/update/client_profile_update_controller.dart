

import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:untitled1/src/models/response_api.dart';
import 'package:untitled1/src/models/user.dart';
import 'package:untitled1/src/providers/users_providers.dart';

import '../info/client_profile_info_controller.dart';

class ClientProfileUpdateController extends  GetxController {

  User user = User.fromJson(GetStorage().read('user'));



  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  ImagePicker picker = ImagePicker();
  File? imageFile;

  UsersProviders usersProviders = UsersProviders();
  ClientProfileInfoController clientProfileInfoController = Get.find();


  ClientProfileUpdateController(){
    nameController.text = user.name ?? '';
    lastnameController.text = user.lastname ?? '';
    phoneController.text = user.phone ?? '';
  }

  void updateInfo(BuildContext context) async {
    String name = nameController.text;
    String lastname = lastnameController.text;
    String phone = phoneController.text;

    if (isValidForm( name, lastname, phone)) {

      ProgressDialog progressDialog = ProgressDialog(context: context);
      progressDialog.show(max: 100, msg: 'Actualizando datos....');

      User myUser = User(

          id: user.id,
          name: name,
          lastname: lastname,
          phone: phone,
          sessionToken: user.sessionToken
      );

      if( imageFile == null) {
      ResponseApi responseApi = await usersProviders.update(myUser);

      print('ResponseApi sin imagen: ${responseApi.data}');
      Get.snackbar('Proceso terminado', responseApi.message ?? '');

      progressDialog.close();
           if(responseApi.success == true ) {
             GetStorage().write('user', responseApi.data);
             clientProfileInfoController.user.value = User.fromJson(GetStorage().read('user') ?? {});

           }
      }
      else{
        Stream stream = await  usersProviders.updateWithImage(myUser, imageFile !); //esta validado en la parte inferior
        stream.listen((res) {

          progressDialog.close();
          ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
          print('ResponseApi: ${responseApi.data}');
          Get.snackbar('Proceso terminado', responseApi.message ?? '');


          if(responseApi.success == true) {
            GetStorage().write('user', responseApi.data);
            clientProfileInfoController.user.value = User.fromJson(GetStorage().read('user') ?? {});


          }else{
            Get.snackbar('Registro fallido', responseApi.message ?? '');
          }
        });
      }




      /*Stream stream = await  usersProviders.createWithImage(user, imageFile !); //esta validado en la parte inferior
      stream.listen((res) {

        progressDialog.close();
        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));

        if(responseApi.success == true) {
          GetStorage().write('user', responseApi.data);  //si todo esta bien almacenamos aca los datos del usuario
          goToHomePage();
        }else{
          Get.snackbar('Registro fallido', responseApi.message ?? '');
        }
      });*/
    }
  }

  bool isValidForm(
      String name,
      String lastname,
      String phone
      ) {



    if (name.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar tu nombre');
      return false;
    }

    if (lastname.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar tu apellido');
      return false;
    }

    if (phone.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar tu numero telefonico');
      return false;
    }



    return true;
  }

  Future selectImage(ImageSource imageSource) async {
    XFile? image = await picker.pickImage(source: imageSource);
    if (image != null) {
      imageFile = File(image.path);

      update();
    }
  }

  void showAlerDialog(BuildContext context){
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.gallery);

        }, child: Text(
      'GALERIA',
      style: TextStyle(
          color: Colors.black
      ),
    )
    );
    Widget cameraButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.camera);
        }, child: Text(
      'CAMARA',
      style: TextStyle(
          color: Colors.black
      ),
    )
    );
    AlertDialog alertDialog= AlertDialog(
      title: Text('SELECCIONA UNA OPCION'),
      actions: [
        galleryButton,
        cameraButton
      ],
    );
    showDialog(context: context, builder: (BuildContext contex){
      return alertDialog;

    });
  }
}