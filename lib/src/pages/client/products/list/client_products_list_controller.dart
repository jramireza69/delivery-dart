import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled1/src/pages/client/products/detail/client_products_detail_page.dart';
import 'package:untitled1/src/pages/client/products/list/client_products_list_page.dart';
import 'package:untitled1/src/providers/categories_provider.dart';
import 'package:untitled1/src/models/category.dart';
import 'package:untitled1/src/providers/products_provider.dart';

import '../../../../models/product.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ClientProductsListController extends GetxController {


  CategoriesProvider categoriesProvider = CategoriesProvider();
  ProductsProvider productsProvider = ProductsProvider();

  List<Category> categories = <Category>[].obs;
  var items = 0.obs;

  var productName = ''.obs;
  Timer? searchOnStoppedTyping;

  ClientProductsListController(){
    getCategories();
  }

  void getCategories() async {
    var result = await categoriesProvider.getAll();
    categories.clear();
    categories.addAll(result);
  }




  void goToOrderCreate(){
    Get.toNamed('/client/orders/create');
  }

  Future<List<Product>> getProducts(String idCategory) async {
    return await  productsProvider.findByCategory(idCategory);
  }

  void modalBottomSheet(BuildContext context,  Product product){
           showMaterialModalBottomSheet(
               context: context,
               builder: (builder) => ClientProductsDetailPage(product: product)
           );
  }

}



void onChangeText (){}