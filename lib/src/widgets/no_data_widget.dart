import 'package:flutter/material.dart';


class NoDataWidget extends StatelessWidget {
String text = '';

NoDataWidget({this.text = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
              'assets/img/no_items.png',
            height: 300,
            width: 300,

          ),
          SizedBox(height: 15,),
          Text(
              text,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    );
  }
}
