import 'dart:convert';
import 'package:e_commerce/component/appbar.dart';
import 'package:e_commerce/component/productdetail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:fluttertoast/fluttertoast.dart';

class brand extends StatefulWidget {
  //final String Subcatname;
  final int cat_id;
  final int sub_cat_id;
  const brand({Key? key ,required this.cat_id,required this.sub_cat_id}) : super(key: key);

  @override
  _brandState createState() => _brandState();
}

class _brandState extends State<brand> {
  var userdata = new Map();
  List data = [];
  //List id = [];
  List id = [];
  List cat_id = [];
  List sub_cat_id=[];
 List brand_name = [];
  List Price=[];
  List image = [];


  bool _progressbar = true;

  @override
  void initState() {
    super.initState();
    fetchlist();
  }

  Future<String> fetchlist() async {
    var fd =widget.cat_id;
    var sub_cat_id =widget.sub_cat_id;

    var jsonData = await http.get(Uri.parse('http://127.0.0.1:8000/api/allbrand/'+fd.toString()+'/'+sub_cat_id.toString()),
        // Uri.parse('http://127.0.0.1:8000/api/allbrand/'+cat_id.toString()+'/'+cat_id.toString()+'/'+sub_cat_id.toString()),
       //Uri.parse('http://127.0.0.1:8000/api/allbrand/1/1'

        headers: {"Accept": "application/json"});
    var fetchData = jsonDecode(jsonData.body);
    setState(() {
      data = fetchData;

      data.forEach((element) {
        id.add(element['id']);
        brand_name.add(element['brand_name']);
        Price.add(element['Price']);
        // username.add(element['username']);
        image.add(element['image']);
      });
    });
    return "Success";
  }
  @override
  Widget build(BuildContext context) {


    var size = MediaQuery.of(context).size;
    return  Scaffold(
      appBar: appbarwidget(),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // GridView.builder(
            //     shrinkWrap: true,
            //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 3,
            //     ),
            //     itemCount: brand_name.length,
            //     itemBuilder: (BuildContext context, int index) {
            //       return Card(
            //         color: Colors.amber,
            //         child: Center(child: Column(
            //           children: [
            //             Expanded(
            //                 flex: 5,
            //               child: GestureDetector(
            //                   child: Image(
            //                     image:
            //                     NetworkImage(image[index]),
            //
            //                   ),
            //                   onTap: () {
            //                     Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
            //                         productdetail(brand_id: id[index])));
            //                   } )
            //             ),
            //             // Expanded(
            //             //     flex: 1,
            //             //    child: Text(price[index]),
            //             //
            //             //     ),
            //             Expanded(flex:1,child: Text("   ${brand_name[index]}")),
            //              Expanded(flex:1,child: Text("Price  ₹ ${Price[index]}")),
            //             //
            //             //Expanded(flex:1,child: Text(widget.sub_cat_id.toString())),
            //              //Expanded(flex:1,child: Text(id.toString())),
            //             //Expanded(flex:1,child: Text(widget.cat_id.toString()))
            //           ],
            //         )),
            //       );
            //     }
            // ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: brand_name.length,
              itemBuilder:
                  (BuildContext context, int index) {
                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                          productdetail(brand_id: id[index])));
                    },
                    child: Container(
                      child: Column(children: [
                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    Image.network(
                                      image[index],
                                      width: size.width / 2,
                                      height:
                                      size.height / 4.6,
                                      // fit: BoxFit.cover,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Text(
                                        brand_name[index],
                                        maxLines: 1,
                                        overflow:
                                        TextOverflow
                                            .ellipsis,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight:
                                            FontWeight
                                                .bold),
                                      ),
                                      // Text(
                                      //   products[index][
                                      //   "productdiscription"],
                                      //   maxLines: 2,
                                      //   overflow:
                                      //   TextOverflow
                                      //       .ellipsis,
                                      //   style: TextStyle(
                                      //       color: Colors
                                      //           .grey[400]),
                                      // ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Offer Price : ${Price[index]}",
                                        style: TextStyle(
                                            color: Colors
                                                .green,
                                            fontSize: 15,
                                            fontWeight:
                                            FontWeight
                                                .bold),
                                      ),
                                      Text(
                                          "MRP : 1000",
                                          style: TextStyle(
                                              decoration:
                                              TextDecoration
                                                  .lineThrough)),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        " 13 % off" // discount calculation(product price - selling price)
                                            .toUpperCase(),
                                        style: TextStyle(
                                          color: Colors
                                              .pinkAccent,
                                          fontSize: 15,
                                          fontWeight:
                                          FontWeight
                                              .bold,
                                        ),
                                      ),
                                      // Text(
                                      //   " ${((int.parse(products[index]["productprice"]) - int.parse(products[index]["productsellingprice"])) * 100 / int.parse(products[index]["productprice"])).round()} % off" // discount calculation(product price - selling price)
                                      //       .toUpperCase(),
                                      //   style: TextStyle(
                                      //     color: Colors
                                      //         .pinkAccent,
                                      //     fontSize: 15,
                                      //     fontWeight:
                                      //     FontWeight
                                      //         .bold,
                                      //   ),
                                      // ),
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
                                      alignment: Alignment
                                          .bottomCenter,
                                      child: Text(
                                        "₹ 3 off" // discount calculation(product price - selling price)
                                            .toUpperCase(),
                                        style: TextStyle(
                                          color:
                                          Colors.pinkAccent,
                                          fontSize: 15,
                                        ),
                                      ),
                                    )),
                                // int.parse(products[index]["productstock"])!=0?Expanded(
                                //     flex: 1,
                                //     child: Padding(
                                //       padding:
                                //       const EdgeInsets.all(
                                //           8.0),
                                //       child:
                                //       NumberInputPrefabbed
                                //           .roundedButtons(
                                //         incDecBgColor:
                                //         Colors.greenAccent,
                                //         controller:
                                //         TextEditingController(),
                                //         max: int.parse(products[index]["productstock"]),
                                //
                                //         initialValue:
                                //         products[index]["productqtyincart"] !=
                                //             "null"
                                //             ? int.parse(
                                //             products[index]["productqtyincart"])
                                //             : 0,
                                //         buttonArrangement:
                                //         ButtonArrangement
                                //             .incRightDecLeft,
                                //         incIcon:
                                //         FontAwesomeIcons
                                //             .plusCircle,
                                //         onIncrement: (num
                                //         newlyIncrementedValue) {
                                //           var qty =
                                //           newlyIncrementedValue
                                //               .toString();
                                //           if(newlyIncrementedValue<int.parse(products[index]["productstock"])){
                                //             print("making request${int.parse(products[index]["productstock"])}");
                                //             makePostRequest(
                                //                 products[index]["productid"],
                                //                 qty,
                                //                 products[index]["productsellingprice"],
                                //                 products[index]["productunit"]);
                                //           }
                                //           else if(newlyIncrementedValue==int.parse(products[index]["productstock"])){
                                //             print("maximum limit reached" );
                                //             final snackBar = SnackBar(
                                //               content: const Text('maximum limit reached!'),
                                //
                                //             );
                                //
                                //             ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                //             if(int.parse(products[index]["productstock"])!=0){
                                //               makePostRequest(
                                //                   products[index]["productid"],
                                //                   qty,
                                //                   products[index]["productsellingprice"],
                                //                   products[index]["productunit"]);
                                //             }
                                //
                                //
                                //           }
                                //           else{
                                //             print("stock limit request${int.parse(products[index]["productstock"])}");
                                //           }
                                //
                                //           //fetchtotalprice();
                                //         },
                                //         onDecrement: (num
                                //         newlyDecrementedValue) {
                                //           print(
                                //               'Newly decremented value is $newlyDecrementedValue');
                                //           var qty =
                                //           newlyDecrementedValue
                                //               .toString();
                                //           if (newlyDecrementedValue>0){
                                //             makePostRequest(
                                //                 products[index]["productid"],
                                //                 qty,
                                //                 products[index]["productsellingprice"],
                                //                 products[index]["productunit"]);
                                //           }
                                //           else{
                                //             deleteformcart(products[index]["productid"],products[index]["productunit"]);
                                //             final snackBar = SnackBar(
                                //               content: const Text('Removed from cart'),
                                //
                                //             );
                                //
                                //             ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                //
                                //             fetchtotalprice();
                                //
                                //           }
                                //
                                //           // fetchtotalprice();// product id index is product id
                                //         },
                                //         decIcon:
                                //         FontAwesomeIcons
                                //             .minusCircle,
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
            )
          ],
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
// child: Image(
// image:
// NetworkImage(image[index]),
//
// )),