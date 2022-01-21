import 'package:e_commerce/component/showcart.dart';
import 'package:flutter/material.dart';
class appbarwidget extends StatelessWidget implements PreferredSizeWidget{
  const appbarwidget({Key? key}) : super(key: key);
  Size get preferredSize =>const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.1,
      backgroundColor: Colors.red.shade900,
      title: Center(child:
      Text('DAILY~SHOPING',)),

      actions: <Widget>[
        new IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {}),
        new IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,

            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => mycart()),
              );
            })
      ],

    );
  }
}