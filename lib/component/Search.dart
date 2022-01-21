import 'dart:convert';


import 'package:e_commerce/component/appbar.dart';
import 'package:e_commerce/component/productdetail.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class searchpage extends StatefulWidget {
  final String text;

  searchpage({Key? key, required this.text,}) : super(key: key);

  @override
  _searchpageState createState() => _searchpageState();
}

class _searchpageState extends State<searchpage> {
  late List data;
  var cartqty;
  String totalqty = '0';
  
  List imagesUrl = [];
  List productname = [];
  List productdiscription = [];
  List productprice = [];
  List productsellingprice = [];
  // List productvarient=[];
  // List productunit = [];
  // List productstock = [];
  List productid = [];
  bool _progressBarActive =true;
  bool _noproduct=false;

  @override
  void initState() {
    super.initState();
    fetchDataFromApi();
  }


  Future<String> fetchDataFromApi() async {
    var jsonData = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/search/${widget.text}'),
        headers: {"Accept": "application/json"});
    // var jsonData = await http.get("http://api.pmmart.co.in/api/search/${widget.text}");
    var fetchData = jsonDecode(jsonData.body);
    setState(() {
      data = fetchData['Data'];
      var pitem=data.length;
      if(pitem != 0 ){
        print("yes");
      }
      else{
        print("no");
        setState(() {
          _progressBarActive=false;
          _noproduct=true;
        });
      }
      print(data);
      data.forEach((element) {
        imagesUrl.add(element['image']);
        productname.add(element['brand_name']);
        // productvarient.add(element['unit']);
        productdiscription.add(element['discription']);
        productprice.add(element['Price'].toString());
        // productstock.add(element['stock'].toString());
        productsellingprice.add(element['offer_price'].toString());
        productid.add(element['id']);
        _progressBarActive=false;
      });
    });
    return "Success";
  }

//   makePostRequest(var pid, var qty,var priceperqty, var selectedvarient) async {
//     SharedPreferences prefs;
//     prefs = await SharedPreferences.getInstance();
//     String session_id = prefs.getString('sessionid');
//     final uri = Uri.parse('http://api.pmmart.co.in/api/Addtocart');
//
//     final headers = {'Content-Type': 'application/json'};
//     Map<String, dynamic> body = {
//       'pid': pid,                        // product id
//       'sessionid': session_id,
//       'qty': qty,
//       'rateperqty':priceperqty,
//       'product_varient': selectedvarient
//     };
//     String jsonBody = json.encode(body);
//     final encoding = Encoding.getByName('utf-8');
//
//     Response response = await post(
//       uri,
//       headers: headers,
//       body: jsonBody,
//       encoding: encoding,
//     );
//     fetchtotalprice();
//     // Navigator.push(context, MaterialPageRoute(builder: (context) => productlist(catid: widget.catid, subcatid: widget.subcatid)));
// //    Navigator.pushReplacement(context,
// //        MaterialPageRoute(builder: (BuildContext context) => super.widget));
//   }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appbarwidget(),

      // drawer: Drawer(
      //   child: Drawerfile(),
      // ),
      body: Scaffold(
        appBar: AppBar(centerTitle: true,backgroundColor:Colors.white,title: Text("${widget.text}",style: TextStyle(color:Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),leading:Container() ),
        body: _progressBarActive == true?Container(child:Center(child: const CircularProgressIndicator())):
        _noproduct==true?Container(child:Center(child: new Text("no product found"))):ListView.builder(
          itemCount: imagesUrl.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              clipBehavior: Clip.antiAlias,
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => productdetail(brand_id: productid[index],),),);
                },
                child: Container(
                  child: Column(
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,

                                  child: GestureDetector(
                                      child: Image(
                                        image:
                                        NetworkImage(imagesUrl[index]

                                        ),

                                      ),
                                     // onTap: () {
                                      //  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                                         //   productdetail(Subcatname: productname[index],brand_id: productid[index],)));
                                            //Subcatname: productname[index],
                                     // }
                                      )
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Text(
                                        productname[index],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        productdiscription[index],
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(color: Colors.grey[400]),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Offer Price : ${productsellingprice[index]}",
                                        style: TextStyle(
                                            color: Colors.green, fontSize: 15,fontWeight: FontWeight.bold),
                                      ),
                                      Text("MRP : ${productprice[index]}",
                                          style: TextStyle(
                                              decoration:
                                              TextDecoration.lineThrough)),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        " ${((int.parse(productprice[index]) - int.parse(productsellingprice[index]))*100/int.parse(productprice[index])).round()} % off"   // discount calculation(product price - selling price)
                                            .toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.pinkAccent,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                        Container(
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                        "₹ ${(int.parse(productprice[index]) - int.parse(productsellingprice[index]))}  off" ,// discount calculation(product price - selling price)
                                        style: TextStyle(
                                          color: Colors.pinkAccent,
                                          fontSize: 15,
                                        ),
                                      ),
                                    )),
                                // productstock[index]!="0"?Expanded(
                                //     flex: 1,
                                //     child: Padding(
                                //       padding: const EdgeInsets.all(8.0),
                                //       child: NumberInputPrefabbed.roundedButtons(
                                //         incDecBgColor: Colors.greenAccent,
                                //         controller: TextEditingController(),
                                //         initialValue: 0,
                                //         max: int.parse(productstock[index]),
                                //         buttonArrangement: ButtonArrangement.incRightDecLeft,
                                //         incIcon: FontAwesomeIcons.plusCircle,
                                //         onIncrement: (num newlyIncrementedValue) {
                                //           var qty = newlyIncrementedValue.toString();
                                //
                                //           if(newlyIncrementedValue<int.parse(productstock[index])){
                                //             Fluttertoast.showToast(
                                //                 msg: "Successfully Added To Cart",
                                //                 toastLength: Toast.LENGTH_SHORT,
                                //                 gravity: ToastGravity.BOTTOM,
                                //                 timeInSecForIosWeb: 1,
                                //                 backgroundColor: Colors.green,
                                //                 textColor: Colors.white,
                                //                 fontSize: 16.0
                                //             );
                                //             makePostRequest(
                                //                 productid[index],
                                //                 qty,
                                //                 productsellingprice[index],
                                //                 productvarient[index]);
                                //
                                //
                                //           }
                                //           else if(newlyIncrementedValue==int.parse(productstock[index])){
                                //             print("maximum limit reached" );
                                //             final snackBar = SnackBar(
                                //               content: const Text('maximum limit reached!'),
                                //
                                //             );
                                //
                                //             ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                //
                                //             makePostRequest(
                                //                 productid[index],
                                //                 qty,
                                //                 productsellingprice[index],
                                //                 productvarient[index]);
                                //
                                //
                                //           }
                                //           else{
                                //             print("stock limit request${int.parse(productstock[index])}");
                                //           }
                                //
                                //
                                //         },
                                //         onDecrement: (num newlyDecrementedValue) {
                                //           print(
                                //               'Newly decremented value is $newlyDecrementedValue');
                                //           var qty = newlyDecrementedValue.toString();
                                //           Fluttertoast.showToast(
                                //               msg: "Successfully Added To Cart",
                                //               toastLength: Toast.LENGTH_SHORT,
                                //               gravity: ToastGravity.BOTTOM,
                                //               timeInSecForIosWeb: 1,
                                //               backgroundColor: Colors.green,
                                //               textColor: Colors.white,
                                //               fontSize: 16.0
                                //           );
                                //           makePostRequest(productid[index], qty,productsellingprice[index],productvarient[index]);
                                //           fetchtotalprice();// product id index is product id
                                //
                                //         },
                                //         decIcon: FontAwesomeIcons.minusCircle,
                                //       ),
                                //     )):
                                // Expanded(
                                //     flex: 1,
                                //     child: Align(
                                //       alignment: Alignment
                                //           .bottomCenter,
                                //       child: FlatButton(
                                //         color: Colors.grey,
                                //         shape: RoundedRectangleBorder(
                                //             borderRadius: BorderRadius.circular(50)),
                                //         onPressed:() async {
                                //
                                //
                                //         },
                                //         child: Text("Out Of Stock".toUpperCase(),style: TextStyle(color: Colors.white),),
                                //       ),
                                //     )),
                              ],
                            )),
                      ]),
                ),
              ),

            );
          },
        ),

      )
      , backgroundColor: Colors.grey[100],


    );
  }
}