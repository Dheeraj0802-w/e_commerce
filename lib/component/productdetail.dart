
import 'package:fluttertoast/fluttertoast.dart';
import 'package:e_commerce/component/appbar.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:getwidget/getwidget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:e_commerce/component/showcart.dart';
import 'package:e_commerce/component/brand.dart';
//import 'package:fluttertoast/fluttertoast.dart';

class productdetail extends StatefulWidget {
 // final String Subcatname;
  final int brand_id;
  const productdetail({Key? key ,required this.brand_id}) : super(key: key);

  @override
  _productdetailState createState() => _productdetailState();
}

class _productdetailState extends State<productdetail> {
  var userdata = new Map();
  List data = [];
  List photos=[];
  List id=[];
  //List product_id = [];
  List cat_id = [];
  late String brand_name;
  late String offer_price;
  late String Price;
  late String discription;
  List image = [];
  bool _progressBarActive=true;


  @override
  void initState() {
    super.initState();
    fetchlist();
  }

  Future<String> fetchlist() async {
    var brand_id=widget.brand_id;
    var jsonData = await http.get(Uri.parse('http://127.0.0.1:8000/api/allproduct/${brand_id.toString()} '),
        // Uri.parse(' '+brand_id.toString()),
        headers: {"Accept": "application/json"});
    var fetchData = jsonDecode(jsonData.body);
    setState(() {
      data = fetchData['Data'];
      photos=fetchData['images'];

      data.forEach((element) {

        brand_name=element['brand_name'];
        offer_price=element['offer_price'].toString();
        Price=element['Price'];
        discription=element['discription'];
        id.add(element['id']);
        image.add(element['image']);
      });

      photos.forEach((element) {

        image.add(element['img']);
      });



      _progressBarActive=false;
    });
    return "Success";
  }




  MakePostRequest(int pid,int qty) async {

    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('userid');


    print("hello world");
    final uri = Uri.parse('http://127.0.0.1:8000/api/addcart');
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      'pid': pid,
      'sessionid': userid,
      'quantity':qty,
      // 'phone_no':phone_no.text,
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    http.Response response = await http.post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;
    print(responseBody);

  }



  // var jsonData = await http.get("http://api.pmmart.co.in/api/product/${widget.id}");
  // var fetchData = jsonDecode(jsonData.body);
  // setState(() {
  // data = fetchData['Data'];
  // data.forEach((element) {
  // imagesUrl.add(element['image']);
  // productname = element['name'];
  // productdiscription = element['Product_details'];
  // features=element['feature_point'];
  // productprice=element['price'].toString();
  // selectedprice=element['selling_price'].toString();
  // pricelist.add( element['selling_price'].toString());
  // productunit.add(element['unit']);
  // selectedvarient=element['unit'];
  // productstock.add(element['stock'].toString());
  // element['stock']==0?outofstock=true:null;
  // returnavailable=element['return_available'];
  // returndays=element['return_days'];
  // });
  // imagesmap = fetchData['images'];
  // imagesmap.forEach((element) {
  // imagesUrl.add(element['image']);
  // });
  // varients = fetchData['product_varient'];
  // varients.forEach((element) {
  // productunit.add(element['unit']);
  // pricelist.add(element['price'].toString());
  // productstock.add(element['stock'].toString());
  // });
  //
  //









  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: appbarwidget(),
        // drawer: DrawerWidget(),
        body: Scaffold(
          // appBar: WishListLogo(),
          body: Container(
              color: Colors.white,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: _progressBarActive == true?
                Container(

                  height: size.height,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey,
                          highlightColor: Colors.white,
                          enabled: _progressBarActive,
                          child: SingleChildScrollView(
                            physics: ScrollPhysics(),
                            child: Column(
                              children: [


                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Container(
                                    width: size.width ,
                                    height: size.width,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Loading Details...',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight:
                                    FontWeight.bold,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4.0),
                                ),
                                Row(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: Container(
                                      width: size.width/2.3,
                                      height: 19.0,
                                      color: Colors.white,
                                    ),
                                  ),

                                  Spacer(),

                                ],),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 14.0),
                                ),
                                Row(
                                  children: [
                                    Expanded(child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(

                                        height: 19.0,
                                        color: Colors.white,
                                      ),
                                    ),),
                                    Expanded(child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(

                                        height: 19.0,
                                        color: Colors.white,
                                      ),
                                    ),),
                                    Expanded(child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(

                                        height: 19.0,
                                        color: Colors.white,
                                      ),
                                    ),),
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 24.0),
                                ),
                                Row(
                                  children: [
                                    Expanded(child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: size.width/8,
                                        height: 19.0,
                                        color: Colors.white,
                                      ),
                                    ),),
                                    Spacer(),
                                    Expanded(child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: size.width/8,
                                        height: 19.0,
                                        color: Colors.white,
                                      ),
                                    ),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: size.width/8,
                                        height: 19.0,
                                        color: Colors.white,
                                      ),
                                    ),),
                                    Spacer(),
                                    Expanded(child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: size.width/8,
                                        height: 19.0,
                                        color: Colors.white,
                                      ),
                                    ),),
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 24.0),
                                ),
                                Card(
                                    clipBehavior: Clip.antiAlias,
                                    color: Colors.white,
                                    child: Column(
                                      children: [



                                        Padding(
                                            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                  "Offer Price :",
                                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                                                ),
                                                Spacer(),
                                                Text(
                                                  "nnnnnn",
                                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.green),
                                                )
                                              ],
                                            )),
                                        Padding(
                                            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                  "MRP :",
                                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                                ),
                                                Spacer(),
                                                Text(
                                                  "nnn",
                                                  style: TextStyle(fontSize: 14,color: Colors.red, fontWeight: FontWeight.w500,decoration:
                                                  TextDecoration
                                                      .lineThrough),
                                                )
                                              ],
                                            )),
                                        SizedBox(height: 15,)


                                      ],
                                    )),




                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ):Column(
                  children: [


                    InteractiveViewer(
                      panEnabled: false, // Set it to false to prevent panning.
                      boundaryMargin: EdgeInsets.all(80),
                      minScale: 1,
                      maxScale: 4,

                      child: GFCarousel(
                        pagination: true,
                        enableInfiniteScroll: false,
                        height: MediaQuery.of(context).size.width,
                        items: image.map(
                              (url) {
                            return Container(


                              margin: EdgeInsets.all(0.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                child: Image.network(
                                    url,
                                    // fit: BoxFit.cover,
                                    width: 1000.0
                                ),
                              ),
                            );
                          },
                        ).toList(),
                        onPageChanged: (index) {
                          setState(() {
                            index;
                          });
                        },
                      ),
                    ),



                    // GFCarousel(
                    //   pagination: true,
                    //   enableInfiniteScroll: false,
                    //   height: MediaQuery.of(context).size.width,
                    //   items: imagesUrl.map(
                    //         (url) {
                    //       return Container(
                    //
                    //
                    //         margin: EdgeInsets.all(0.0),
                    //         child: ClipRRect(
                    //           borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    //           child: Image.network(
                    //               url,
                    //               // fit: BoxFit.cover,
                    //               width: 1000.0
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //   ).toList(),
                    //   onPageChanged: (index) {
                    //     setState(() {
                    //       index;
                    //     });
                    //   },
                    // ),



                    Card(
                        clipBehavior: Clip.antiAlias,
                        color: Colors.white,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left:18.0),
                              child: ListTile(

                                title: Text(brand_name,style: TextStyle(fontWeight: FontWeight.bold),),
                                // subtitle: Text(
                                //   "subtitle",
                                //   style:
                                //   TextStyle(color: Colors.black.withOpacity(0.6)),
                                // )
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                //color: Colors.green,
                                width: MediaQuery.of(context).size.width,
                                //margin: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    // CustomRadioButton(
                                    //   enableShape: true,
                                    //   elevation: 0,
                                    //   defaultSelected: productunit[0],
                                    //   enableButtonWrap: true,
                                    //   width: 80,
                                    //   autoWidth: false,
                                    //   unSelectedColor: Theme.of(context).canvasColor,
                                    //   buttonLables: productunit,
                                    //   buttonValues: productunit,
                                    //   radioButtonValue: (value) {
                                    //     int index=productunit.indexOf(value);
                                    //     setState(() {
                                    //       selectedvarient=productunit[index];
                                    //       selectedstock=productstock[index];
                                    //       selectedprice=pricelist[index];
                                    //       if(int.parse(selectedstock)>0){
                                    //         outofstock=false;
                                    //         if(int.parse(selectedstock)<=5){
                                    //           stockwarning=true;
                                    //         }
                                    //         else{
                                    //           stockwarning=false;
                                    //         }
                                    //       }
                                    //       else{
                                    //         outofstock=true;
                                    //       }
                                    //
                                    //
                                    //     });
                                    //     quantity_varient=value.toString();
                                    //     print("Value:$value");
                                    //     print("radioButtonItem:$quantity_varient");
                                    //   },
                                    //   selectedColor: Theme.of(context).accentColor,
                                    // ),

                                  ],
                                ),
                              ),
                            ),
                            // stockwarning==true||outofstock==true?
                            // outofstock==true?
                            // Padding(
                            //     padding: const EdgeInsets.only(top: 8.0,bottom: 8),
                            //     child: Text(
                            //       "Out Of Stock",
                            //       style:
                            //       TextStyle(color: Colors.red),
                            //     )):

                            // Padding(
                            //     padding: const EdgeInsets.only(top: 8.0,bottom: 8),
                            //     child: Text(
                            //       "Hurry Up,Only ${selectedstock} qty Left",
                            //       style:
                            //       TextStyle(color: Colors.red),
                            //     )):

                            SizedBox(height: 32,),


                          ],
                        )),

                    Card(
                        clipBehavior: Clip.antiAlias,
                        color: Colors.white,
                        child: Column(
                          children: [

                            Padding(
                                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "Offer Price :",
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                                    ),
                                    Spacer(),
                                    Text(

                                      "Rs. $offer_price",
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.green),
                                    )
                                  ],
                                )),
                            Padding(
                                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "MRP :",
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                    ),
                                    Spacer(),
                                    Text(

                                      "Rs. $Price",
                                      style: TextStyle(fontSize: 14,color: Colors.red, fontWeight: FontWeight.w500,decoration:
                                      TextDecoration
                                          .lineThrough),
                                    )
                                  ],
                                )),
                            SizedBox(height: 15,)


                          ],
                        )),




                    // feature_points.length!=0?
                    // Card(
                    //     clipBehavior: Clip.antiAlias,
                    //     color: Colors.white,
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         ListTile(
                    //           leading: Icon(Icons.featured_play_list),
                    //           title: Text("Key Features",style: TextStyle(fontWeight: FontWeight.bold),),
                    //         ),
                    //
                    //
                    //         for(var i = 0; i < feature_points.length; i++)
                    //           Padding(
                    //             padding: const EdgeInsets.only(left:68.0),
                    //             child: Text("•  ${feature_points[i]}",style: TextStyle(),),
                    //           ),
                    //         SizedBox(height: 10,)
                    //
                    //       ],
                    //     )):Container(),


                    Card(
                        clipBehavior: Clip.antiAlias,
                        color: Colors.white,
                        child: Column(
                          children: [
                            ListTile(
                                leading: Icon(Icons.speaker_notes_rounded),
                                title: Text("Discription",style: TextStyle(fontWeight: FontWeight.bold),),
                                subtitle: Text(
                                  discription,
                                  style:
                                  TextStyle(color: Colors.black.withOpacity(0.6)),
                                )),



                          ],
                        )),
                    Card(
                        clipBehavior: Clip.antiAlias,
                        color: Colors.white,
                        child: Column(
                          children: [


                            // Padding(
                            //     padding: const EdgeInsets.only(top: 16.0),
                            //     child: Text(
                            //       "Book A Timing Slot",
                            //       style:
                            //       TextStyle(color: Colors.black.withOpacity(0.6),fontWeight: FontWeight.w500),
                            //     )),



                          ],
                        )),




                  ],
                ),


              )),
        ),
        bottomNavigationBar:
        // outofstock==true?SizedBox(
        //   height: 60,
        //   child: ElevatedButton(onPressed: (){
        //     Fluttertoast.showToast(
        //         msg: "Out Of Stock",
        //         toastLength: Toast.LENGTH_SHORT,
        //         gravity: ToastGravity.BOTTOM,
        //         timeInSecForIosWeb: 1,
        //         backgroundColor: Colors.red,
        //         textColor: Colors.white,
        //         fontSize: 16.0
        //     );
        //
        //
        //   }, child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Icon(Icons.shopping_cart),
        //       Text("Out Of Stock")
        //     ],
        //   ),
        //     style: ElevatedButton.styleFrom(primary: Colors.grey),),
        // ):
        SizedBox(
          height: 60,
          child: ElevatedButton(onPressed: (){
            Fluttertoast.showToast(
                msg: "Successfully Added To Cart",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0
            );
            MakePostRequest(widget.brand_id, 1);

          }, child: Row(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_cart),



            ],

          ),
            style: ElevatedButton.styleFrom(primary: Colors.green),),
        )

    );

  }




  // Widget build(BuildContext context) {
  //
  //
  //
  //   return  Scaffold(
  //     appBar: AppBar(
  //       title:Center(child: new Text("2nd Page"),
  //       ),
  //     ),
  //
  //     body: SingleChildScrollView(
  //       child: GridView.builder(
  //           shrinkWrap: true,
  //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //             crossAxisCount: 4,
  //           ),
  //           itemCount: brand_name.length,
  //           itemBuilder: (BuildContext context, int index) {
  //             return Card(
  //               color: Colors.amber,
  //
  //               child: Center(child: Column(
  //                 children: [
  //                   Expanded(
  //                     flex: 5,
  //                     // child: GestureDetector(
  //                     child: Image(
  //                       image:
  //                       NetworkImage(image[index],
  //
  //                       ),
  //
  //                     ),
  //                     // onTap: () {
  //                     //   Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
  //                     //       brand(cat_id: widget.id, sub_cat_id: brand_id[index])));
  //                     // }
  //                     // )
  //                   ),
  //                   Expanded(flex:1,child: Text("  ${brand_name[index]}")),
  //                   // Expanded(flex:1,child: Text(widget.Subcatname)),
  //                 //  Expanded(flex:1,child: Text(widget.brand_id.toString()))
  //                 ],
  //               )),
  //             );
  //           }
  //       ),
  //       // Column(
  //       //   children: [
  //       //     ListView.builder(
  //       //         shrinkWrap: true,
  //       //         itemCount: cat_name.length,
  //       //         itemBuilder: (BuildContext context, int index) {
  //       //           return ListTile(
  //       //               leading: Text("Name is ${cat_name[index]}"),
  //       //
  //       //               title: SingleChildScrollView(
  //       //                 child: Padding(
  //       //                   padding: const EdgeInsets.all(8.0),
  //       //                   child: Column(
  //       //                     crossAxisAlignment: CrossAxisAlignment.start,
  //       //
  //       //
  //       //
  //       //                     children: [
  //       //
  //       //                       Container(
  //       //                       height: 20,
  //       //                       width: 200,
  //       //                       child: Text(
  //       //                           "Roll No is ${cat_name[index]}",
  //       //                            style: TextStyle(color: Colors.green, fontSize: 15),
  //       //                          ),
  //       //                       ),
  //       //
  //       //                       Container(
  //       //                         width: double.infinity,
  //       //                         height: 700.0,
  //       //
  //       //
  //       //                         child: Image(
  //       //                           image:
  //       //                           NetworkImage(image[index]),
  //       //
  //       //                         )
  //       //                         ,
  //       //                       ),
  //       //                       // Text("Email:-${email[index]}")
  //       //                     ],
  //       //                   ),
  //       //                 ),
  //       //               ));
  //       //         }),
  //       //
  //       //
  //       //     GridView.builder(
  //       //         shrinkWrap: true,
  //       //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //       //           crossAxisCount: 3,
  //       //         ),
  //       //         itemCount: 300,
  //       //         itemBuilder: (BuildContext context, int index) {
  //       //           return Card(
  //       //             color: Colors.amber,
  //       //             child: Center(child: Column(
  //       //               children: [
  //       //                 Expanded(
  //       //                     flex: 2,
  //       //                     child: Image(
  //       //                       image:
  //       //                       NetworkImage(image[index]),
  //       //
  //       //                     )),
  //       //                 Expanded(flex:1,child: Text("Name is ${cat_name[index]}"))
  //       //               ],
  //       //             )),
  //       //           );
  //       //         }
  //       //     ),
  //       //
  //       //   ],
  //       // ),
  //     ),
  //
  //   );
  // }



}
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// // void main() {
// //   runApp(const productdetail());
// // }
//
// // class productdetail extends StatelessWidget {
// //   const productdetail({Key? key,}) : super(key: key);
// //
// //   // This widget is the root of your application.
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Flutter Demo',
// //       theme: ThemeData(
// //         // This is the theme of your application.
// //         //
// //         // Try running your application with "flutter run". You'll see the
// //         // application has a blue toolbar. Then, without quitting the app, try
// //         // changing the primarySwatch below to Colors.green and then invoke
// //         // "hot reload" (press "r" in the console where you ran "flutter run",
// //         // or simply save your changes to "hot reload" in a Flutter IDE).
// //         // Notice that the counter didn't reset back to zero; the application
// //         // is not restarted.
// //         primarySwatch: Colors.blue,
// //       ),
// //       home: const MyHomePage(title: 'Flutter Demo Home Page'),
// //     );
// //   }
// // }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//
//   final int title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   List data = ["bcxhxg","bdchdh","hdjdj"];
//   // List name = [];
//   // List email = [];
//   // List username = [];
//   List id = [];
//   List cat_id = [];
//   List brand_name = [];
//   List image = [];
//
//   bool _progressbar = true;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchlist();
//   }
//
//   Future<String> fetchlist() async {
//     var title=widget.title;
//     var jsonData = await http.get(
//         Uri.parse('http://127.0.0.1:8000/api/allproduct/'+title.toString()),
//         headers: {"Accept": "application/json"});
//     var fetchData = jsonDecode(jsonData.body);
//     setState(() {
//       data = fetchData;
//
//       data.forEach((element) {
//         id.add(element['id']);
//         cat_id.add(element['cat_id']);
//         brand_name.add(element['brand_name']);
//         image.add(element['image']);
//         // username.add(element['username']);
//         // email.add(element['email']);
//
//       });
//     });
//     return "Success";
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Fetch Data From API"),
//       ),
//       body: Column(
//         children: [
//           ListView.builder(
//               shrinkWrap: true,
//               itemCount: brand_name.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return ListTile(
//                     leading: Text("brand is ${brand_name[index]}"),
//
//                     title: Column(
//
//                         children: [
//                           Image(
//                             image:
//                             NetworkImage(image[index]
//
//                             ),
//
//                           ),
//                         ],
//                     //     Text(
//                     //       "User name is ${id[index]}",
//                     //       style: TextStyle(color: Colors.green, fontSize: 15),
//                     //     ),
//                     //     Text("Email:-${cat_id[index]}")
//
//                      )
//                 );
//               })
//         ],
//       ),
//     );
//   }
// }
