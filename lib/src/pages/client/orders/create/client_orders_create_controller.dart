import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../models/product.dart';

class ClientOrdersCreateController extends GetxController {


  List<Product> selectedProducts = <Product>[].obs;
  var total = 0.0.obs;

  ClientOrdersCreateController(){
    if(GetStorage().read('shoping_bag') != null ){

      if(GetStorage().read('shoping_bag') is List<Product>){
        var result = GetStorage().read('shoping_bag');
        selectedProducts.clear();
        selectedProducts.addAll(result);
      }else{
        var result = Product.fromJsonList(GetStorage().read('shoping_bag'));
        selectedProducts.clear();
        selectedProducts.addAll(result);
        }
            getTotal();
      }
    }

    void getTotal(){
      total.value = 0.0;
      selectedProducts.forEach((product) {
        total.value = total.value + ( product.quantity! * product.price!);
      });
    }
    void deleteItem(Product product){
       selectedProducts.remove(product);
       GetStorage().write('shoping_bag', selectedProducts);
       getTotal();
    }
    void addItem(Product product){
    //requiero saber el indice donde se encuentra el producto
      int index = selectedProducts.indexWhere((prod) => prod.id == product!.id);
      selectedProducts.remove(product);
      product.quantity = product.quantity! + 1 ;
      selectedProducts.insert(index, product);
      GetStorage().write('shoping_bag', selectedProducts);
      getTotal();
    }
    void removeItem(Product product){

      if(product.quantity! > 1){
        //requiero saber el indice donde se encuentra el producto
        int index = selectedProducts.indexWhere((prod) => prod.id == product!.id);
        selectedProducts.remove(product);
        product.quantity = product.quantity! - 1 ;
        selectedProducts.insert(index, product);
        GetStorage().write('shoping_bag', selectedProducts);
        getTotal();
    }
    }
}