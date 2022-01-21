import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:fluttertoast/fluttertoast.dart';

class categoryfetchList extends StatefulWidget {
  const categoryfetchList({Key? key}) : super(key: key);

  @override
  _categoryfetchListState createState() => _categoryfetchListState();
}

class _categoryfetchListState extends State<categoryfetchList> {
  List data = ["bcxhxg","bdchdh","hdjdj"];
  List cat_name = [];
 // List email = [];
  //List username = [];
  List image = [];

  bool _progressbar = true;

  @override
  void initState() {
    super.initState();
    fetchlist();
  }

  Future<String> fetchlist() async {
    var jsonData = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/allcategorydata'),
        headers: {"Accept": "application/json"});
    var fetchData = jsonDecode(jsonData.body);
    setState(() {
      data = fetchData;

      data.forEach((element) {
        cat_name.add(element['name']);
       // username.add(element['username']);
        image.add(element['image']);
      });
    });
    return "Success";
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:Center(child: new Text("2nd Page"),
        ),
      ),
      body: Column(
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: cat_name.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    leading: Text("Name is ${cat_name[index]}"),

                    title: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,



                          children: [

                            // Container(
                            //   height: 20,
                            //   width: 200,
                            //   child: Text(
                            //     "Roll No is ${rollno[index]}",
                            //     style: TextStyle(color: Colors.green, fontSize: 15),
                            //   ),
                            // ),
                            Container(
                              width: double.infinity,
                              height: 700.0,


                              child: Image(
                                image:
                                NetworkImage(image[index]),

                              )
                              ,
                            ),
                            // Text("Email:-${email[index]}")
                          ],
                        ),
                      ),
                    ));
              })
        ],
      ),

    );
  }
}


