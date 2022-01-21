import 'package:e_commerce/widget/homepage.dart';
//import 'package:e_commerce/widget/login.dart';
import 'package:flutter/material.dart';

import 'component/splashscreen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primaryColor: Colors.red.shade900
    ),
    //home:homepage()
    home:Splassscreen(),
  ));
}