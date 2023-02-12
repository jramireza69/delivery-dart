import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled1/src/widgets/no_data_widget.dart';

import '../../../../models/category.dart';
import '../../../../models/product.dart';
import 'client_products_list_controller.dart';

class ClientProductsListPage extends StatelessWidget {

  ClientProductsListController con = Get.put(ClientProductsListController());

  @override
  Widget build(BuildContext context) {

    return Obx(() =>  DefaultTabController(
      length: con.categories.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: AppBar(
            flexibleSpace: Container(
              margin: EdgeInsets.only(top: 5),
              alignment: Alignment.topCenter,
              child: Wrap(
                direction: Axis.horizontal,//recibe una fila para ubicar un elemento al lado del otro
                children: [
                  _textFielSearch(context),
                  _iconShoppingBag()
                ],
              ),
            ),
            bottom: TabBar(
              isScrollable: true,
              indicatorColor: Colors.amber,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey[600] ,
              tabs: List<Widget>.generate(con.categories.length, (index) {
                return Tab(
                  child: Text(
                    con.categories[index].name ?? ''
                  ),
                );
              }),
            ),
          ),
        ),
        body: TabBarView(
          children: con.categories.map((Category category) {
            return FutureBuilder(
              future: con.getProducts(category.id ?? '1' ),
                builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                if(snapshot.hasData) {
                  if (snapshot.data!.length > 0) {
                    return ListView.builder(
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (_, index) {
                          return _cardProduct(context, snapshot.data![index]);
                        }
                    );
                   } else {
                    return NoDataWidget(text: 'No hay productos');
                  }
                }
                else {
                  return NoDataWidget(text: 'No hay productos');
                }
                }
            );
          }).toList(),
        ),
      ),
    ));
  }
Widget _iconShoppingBag(){
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(left: 10),
        child: IconButton(
            onPressed: () => con.goToOrderCreate(),
            icon: Icon(
              Icons.shopping_bag_outlined,
              size: 30,
            )
        ),
      ),
    );
}
  Widget _textFielSearch(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: SafeArea(
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Buscar Producto',
            suffixIcon: Icon(Icons.search, color: Colors.grey,),
            hintStyle: TextStyle(
              fontSize: 17,
              color: Colors.grey
            ),
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Colors.grey,
              )
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Colors.grey,
              )
            ),
            contentPadding: EdgeInsets.all(15)
          ),
        ),
      ),
    );
  }
  Widget _cardProduct(BuildContext context ,Product product){
    return GestureDetector(
      onTap: () => con.modalBottomSheet(context, product),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 15, left: 20, right: 20),
            child: ListTile(
              title: Text(product.name ?? ''),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5,),
                  Text(
                      product.description ?? '',
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 13
                    ),
                  ),

                    SizedBox(height: 10,),
                  Text(

                    '\$  ${product.price.toString()}',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                  SizedBox(height: 20,),
                ],
              ),
              trailing: Container(  //border redondeado imagenes
                height: 70,
                width: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: FadeInImage(
                    image: product.image1 != null
                         ?NetworkImage(product.image1!)
                         :AssetImage('assets/img/no-image.png') as ImageProvider,
                    fit: BoxFit.cover,
                    fadeInDuration: Duration(milliseconds: 50),
                    placeholder: AssetImage('assets/img/no-image.png') ,
                  ),
                ),
              ),
            ),
          ),
          Divider(height: 1, color:  Colors.grey[300], indent: 40, endIndent: 40,)
        ],
      ),
    );
  }




}
