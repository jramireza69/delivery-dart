import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled1/src/models/product.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ClientProductsDetailController extends GetxController {

  List<Product> selectedProducts = [];

  ClientProductsDetailController (){
  }
  void checkIfProductWasAdded(Product product, var price, var counter){
    price.value = product.price ?? 0.0;
    //obtenemos los productos almacenados en seccion

    if(GetStorage().read('shoping_bag') != null ){

      if(GetStorage().read('shoping_bag') is List<Product>){
        selectedProducts = GetStorage().read('shoping_bag');
      }else{
        selectedProducts = Product.fromJsonList(GetStorage().read('shoping_bag'));
      }
      int index = selectedProducts.indexWhere((prod) => prod.id == product!.id);

      if(index != -1){  //el producto ya fue agregado
        counter.value = selectedProducts[index].quantity!;
        price.value = product.price! * counter.value;

        selectedProducts.forEach((element) {
          print('Producto: ${element.toJson()}');
        });
      }
    }
  }
  void addToBag(Product product, var price, var counter){
    if(counter.value > 0){
      //VALIDO SI EL PRODUCTO YA FUE AGREGADO CON GETSTORAGE A LA SECCION DEL DISPOSITIVO
      int index = selectedProducts.indexWhere((prod) => prod.id == product.id);

      if( index == -1 ) { //EL PROD NO HA SIDO AGREGADO
        if (product.quantity == null){
          if(counter.value > 0 ){
          product.quantity = counter.value;
          }else {

          product.quantity = 1;
          }
        }
        selectedProducts.add(product);
      }else {   // validacion del index   ha ha sido agregado en storage
        selectedProducts[index].quantity = counter.value;
      }
      GetStorage().write('shoping_bag', selectedProducts);
      Fluttertoast.showToast(msg: 'Producto agregado');
    }else {
      Fluttertoast.showToast(msg: 'Debes seleccionar al menos un item');
    }
  }
  void addItem (Product product, var price, var counter){
    counter.value = counter.value + 1;
    print('PRODUCTO AGREGADO : ${product.toJson()}');
    price.value = product.price! * counter.value;
  }
  void removeItem (Product product, var price, var counter){
    if (counter.value > 0) {
      counter.value = counter.value - 1;
      price.value = product.price! * counter.value;
    }
  }
}


