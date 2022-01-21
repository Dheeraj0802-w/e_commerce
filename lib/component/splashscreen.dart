import 'package:e_commerce/widget/homepage.dart';
//import 'package:e_commerce/widget/login.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';



void main() { runApp(Splassscreen());}

class Splassscreen extends StatefulWidget {
  const Splassscreen({Key? key}) : super(key: key);

  @override
  _SplassscreenState createState() => _SplassscreenState();
}

class _SplassscreenState extends State<Splassscreen> {
  void initState() {
    super.initState();
    Timer(Duration(seconds:1),
            () async {

          SharedPreferences prefs;
          prefs = await SharedPreferences.getInstance();
          var userid = prefs.getString('userid');
          print("fffffffffffffffffff$userid");

          if(userid==null || userid=="null"){
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder:
                    (context) =>loginpage(),
                )
            );
          }
          else{
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder:
                    (context) =>homepage(),
                )
            );
          }

        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.yellow,

        child:FlutterLogo(size:MediaQuery.of(context).size.height,)

    );
  }
}