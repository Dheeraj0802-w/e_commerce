import 'package:e_commerce/component/Search.dart';
import 'package:e_commerce/component/brand.dart';
import 'package:e_commerce/component/drawer.dart';
import 'package:e_commerce/component/productdetail.dart';
import 'package:e_commerce/component/subcategory.dart';
import 'package:e_commerce/component/category.dart';
import 'package:e_commerce/component/appbar.dart';
import 'package:e_commerce/component/drawer.dart';
import 'package:e_commerce/component/products.dart';
import 'package:e_commerce/component/products.dart';
import 'package:e_commerce/component/Tranding.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:convert';

//import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  List data = [];
  List id = [];
  List productid = [];
  List image = [];
  List cat_id = [];
  List images = [];

  List searchtag = [];
  List sub_cat_name = [];

  void initState() {
    super.initState();
    fetchlist();
    fetchlistrecent();
    fetchlistoffer();

  }

  Future<String> fetchlist() async {
    print("hello");
    var jsonData = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/banner'),
        headers: {"Accept": "application/json"});
    var fetchData = jsonDecode(jsonData.body);
    setState(() {
      data = fetchData;

      data.forEach((element) {
        images.add(element['imges']);
        searchtag.add(element['searchtag']);
      });
    });
    return "Success";
  }
  Future<String> fetchlistrecent() async {
    print("hello");
    var jsonData = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/recent'),
        headers: {"Accept": "application/json"});
    var fetchData = jsonDecode(jsonData.body);
    setState(() {
      data = fetchData;

      data.forEach((element) {
        images.add(element['image']);
        productid.add(element['pid']);
      });
    });
    return "Success";
  }
  Future<String> fetchlistoffer() async {
    print("hello");
    var jsonData = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/recent'),
        headers: {"Accept": "application/json"});
    var fetchData = jsonDecode(jsonData.body);
    setState(() {
      data = fetchData;

      data.forEach((element) {
        images.add(element['image']);
        productid.add(element['pid']);
      });
    });
    return "Success";
  }
  @override
  Widget build(BuildContext context) {
    // Carousel image_carousel;
    // Container(
    //   child: image_carousel = Carousel(
    //
    //     //   child: Widget(),
    //
    //     // autoPlay: true,
    //     // pauseAutoPlayOnTouch: Duration(seconds: 5),
    //     // height: MediaQuery.of(context).size.height * 0.60,
    //     images: <Widget>[
    //       for (var i = 0; i < images.length; i++)
    //         Container(
    //           margin: const EdgeInsets.only(top: 20.0, left: 20.0),
    //           decoration: BoxDecoration(
    //             image: DecorationImage(
    //               image: NetworkImage(images[i]),
    //               fit: BoxFit.fitHeight,
    //             ),
    //             // border:
    //             //     Border.all(color: Theme.of(context).accentColor),
    //             borderRadius: BorderRadius.circular(32.0),
    //           ),
    //         ),
    //     ],
    //
    //   ),
    // );
    return Scaffold(
      appBar: appbarwidget(),
      drawer: newDrawer(),
      body:
      Column(
        children: <Widget>[
          //image carousel begins here


          Container(
            height: MediaQuery.of(context).size.height / 11,
            color: Colors.red,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  print("search $value");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => searchpage(
                        text: '$value',
                      ),
                    ),
                  );
                },
                autocorrect: true,
                decoration: InputDecoration(
                  hintText: 'Search Products',
                  prefixIcon: Icon(Icons.search),
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    // borderSide: BorderSide(color: Colors.green, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.green, width: 2),
                  ),
                ),
              ),
            ),
          ),
          CarouselSlider.builder(
            itemCount: images.length,
            itemBuilder: (BuildContext context, int index, int realIdx) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 2.0),
                  child: GestureDetector(
                    onTap: () {
                      if (searchtag[index] == "welcome") {
                        print(searchtag[index]);
                      } else if (searchtag[index] == null) {
                        print(searchtag[index]);
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => searchpage(text:
                            '${searchtag[index]}'),
                          ),
                        );

                      }
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      elevation: 4,
                      child: Container(
                        margin: EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: NetworkImage(images[index]
                              // imagesUrl[int.parse(i)].toString()
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ));
            },
            options: new CarouselOptions(
              height: 180.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
          ),

      //  child:SingleChildScrollView(
          //padding widget
          new Padding(padding: const EdgeInsets.all(4.0),
            child: SizedBox(
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: new Text('Categories')
              ),
            ),
          ),

          //Horizontal list view begins here
          category(),

          //padding widget
              new Padding(padding: const EdgeInsets.all(8.0),
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: new Text('Recent products')
                ),
              ),
          SingleChildScrollView(
   child: GridView.builder(
    shrinkWrap: true,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
    ),
    itemCount: image.length,
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
        productdetail(brand_id: productid[index],),),);
    } )
    ),
 //   Expanded(flex:1,child: Text(widget.productid[index])),
    //Expanded(flex:1,child: Text("  ${sub_cat_name[index]}")),

     //Expanded(flex:1,child: Text(widget.id.toString()))
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




            //subcategory(Subcatname: '',id:2 ),
       // )
          //     //grid view
          //     //  Flexible(child:productdetail(brand_id: brand_id)),
          //
          //
              //padding widget
              // new Padding(padding: const EdgeInsets.all(4.0),
              //   child: Container(
              //       alignment: Alignment.centerLeft,
              //       child: new Text('Trending Offers')
              //   ),
              // ),
              // Flexible(child: Trending()),
              //
              // //padding widget
              // new Padding(padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //       alignment: Alignment.centerLeft,
              //       child: new Text('Recent products')
              //   ),
              // ),

          ),
          new Padding(padding: const EdgeInsets.all(8.0),
            child: Container(
                alignment: Alignment.centerLeft,
                child: new Text('best deal')
            ),
          ),
          SingleChildScrollView(
            child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: image.length,
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
                                      productdetail(brand_id: productid[index],),),);
                                } )
                        ),
                        //   Expanded(flex:1,child: Text(widget.productid[index])),
                        //Expanded(flex:1,child: Text("  ${sub_cat_name[index]}")),

                        //Expanded(flex:1,child: Text(widget.id.toString()))
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




            //subcategory(Subcatname: '',id:2 ),
            // )
            //     //grid view
            //     //  Flexible(child:productdetail(brand_id: brand_id)),
            //
            //
            //padding widget
            // new Padding(padding: const EdgeInsets.all(4.0),
            //   child: Container(
            //       alignment: Alignment.centerLeft,
            //       child: new Text('Trending Offers')
            //   ),
            // ),
            // Flexible(child: Trending()),
            //
            // //padding widget
            // new Padding(padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //       alignment: Alignment.centerLeft,
            //       child: new Text('Recent products')
            //   ),
            // ),

          ),
          //grid view
           //   Flexible(child:bottomnav()),
        ],

      ),
    );
  }
}