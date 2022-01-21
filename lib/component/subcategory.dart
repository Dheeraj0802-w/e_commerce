import 'dart:convert';

import 'package:e_commerce/component/appbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:e_commerce/component/brand.dart';
//import 'package:fluttertoast/fluttertoast.dart';

class subcategory extends StatefulWidget {
  final String Subcatname;
  final int id;
  const subcategory({Key? key ,required this.Subcatname,required this.id}) : super(key: key);

  @override
  _subcategoryState createState() => _subcategoryState();
}

class _subcategoryState extends State<subcategory> {
  var userdata = new Map();
  List data = [];
  List sub_cat_id = [];
  List cat_id = [];git
  List sub_cat_name = [];

  List image = [];

  bool _progressbar = true;

  @override
  void initState() {
    super.initState();
    fetchlist();
  }

  Future<String> fetchlist() async {
    var id=widget.id;
    var jsonData = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/allsubcategorydata/'+id.toString()),
        headers: {"Accept": "application/json"});
    var fetchData = jsonDecode(jsonData.body);
    setState(() {
      data = fetchData;

      data.forEach((element) {

        sub_cat_name.add(element['sub_cat_name']);
        sub_cat_id.add(element['id']);
        image.add(element['image']);
      });
    });
    return "Success";
  }
  @override
  Widget build(BuildContext context) {



    return  Scaffold(
      appBar: appbarwidget(),

      body: SingleChildScrollView(
        child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
            ),
            itemCount: sub_cat_name.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color: Colors.white,

                child: Center(child: Column(
                  children: [
                    Expanded(
                        flex: 4,
                        child: GestureDetector(
                            child: Image(
                              image:
                              NetworkImage(image[index]

                              ),

                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                                  brand(cat_id: widget.id, sub_cat_id: sub_cat_id[index])));
                            } )
                    ),
                    //Expanded(flex:1,child: Text(widget.Subcatname)),
                    Expanded(flex:1,child: Text("  ${sub_cat_name[index]}")),

                   // Expanded(flex:1,child: Text(widget.id.toString()))
                  ],
                )),
              );
            }
        ),
        // Column(
        //   children: [
        //     ListView.builder(
        //         shrinkWrap: true,
        //         itemCount: cat_name.length,
        //         itemBuilder: (BuildContext context, int index) {
        //           return ListTile(
        //               leading: Text("Name is ${cat_name[index]}"),
        //
        //               title: SingleChildScrollView(
        //                 child: Padding(
        //                   padding: const EdgeInsets.all(8.0),
        //                   child: Column(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //
        //
        //
        //                     children: [
        //
        //                       Container(
        //                       height: 20,
        //                       width: 200,
        //                       child: Text(
        //                           "Roll No is ${cat_name[index]}",
        //                            style: TextStyle(color: Colors.green, fontSize: 15),
        //                          ),
        //                       ),
        //
        //                       Container(
        //                         width: double.infinity,
        //                         height: 700.0,
        //
        //
        //                         child: Image(
        //                           image:
        //                           NetworkImage(image[index]),
        //
        //                         )
        //                         ,
        //                       ),
        //                       // Text("Email:-${email[index]}")
        //                     ],
        //                   ),
        //                 ),
        //               ));
        //         }),
        //
        //
        //     GridView.builder(
        //         shrinkWrap: true,
        //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //           crossAxisCount: 3,
        //         ),
        //         itemCount: 300,
        //         itemBuilder: (BuildContext context, int index) {
        //           return Card(
        //             color: Colors.amber,
        //             child: Center(child: Column(
        //               children: [
        //                 Expanded(
        //                     flex: 2,
        //                     child: Image(
        //                       image:
        //                       NetworkImage(image[index]),
        //
        //                     )),
        //                 Expanded(flex:1,child: Text("Name is ${cat_name[index]}"))
        //               ],
        //             )),
        //           );
        //         }
        //     ),
        //
        //   ],
        // ),
      ),

    );
  }
}

