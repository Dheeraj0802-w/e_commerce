import 'package:e_commerce/component/allcategory.dart';
import 'package:e_commerce/component/subcategory.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class category extends StatefulWidget {
  @override
  State<category> createState() => _categoryState();
}
class _categoryState extends State<category> {
  List data = [];
  List cat_name = ["all category"];
  List id=[0];
  // List email = [];
  //List username = [];
  List image = ["https://thumbs.dreamstime.com/b/categories-icon-vector-ecommerce-user-interface-concept-thin-line-illustration-editable-stroke-linear-sign-use-web-193469458.jpg"];

  void initState() {
    super.initState();
    fetchlist();
  }

  Future<String> fetchlist() async {
    print("hello");
    var jsonData = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/allcategorydata'),
        headers: {"Accept": "application/json"});
    var fetchData = jsonDecode(jsonData.body);
    setState(() {
      data = fetchData;

      data.forEach((element) {

        cat_name.add(element['cat_name']);
        id.add(element['id']);
        // username.add(element['username']);
        image.add(element['image']);
      });
    });
    return "Success";
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      child:

      ListView.builder(
            scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: cat_name.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: (){
                if(id[index]==0){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => allcategory()));
                }
                else{
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => subcategory(Subcatname: cat_name[index],id:id[index])));
                }

              },
              child: Category(
                image_location: image[index],
                image_caption: cat_name[index],
              ),
            );
          }),
    );
  }
}
class Category extends StatelessWidget {
  final String image_location;
  final String image_caption;

  Category({required this.image_location, required this.image_caption});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: 100.0,
        child: ListTile(
            title: Image(
              image:
              NetworkImage(image_location),

            ),
            subtitle: Container(
              alignment: Alignment.topCenter,
              child: Text(image_caption, style: new TextStyle(fontSize: 10.0),),
            )
        ),
      ),
    );
  }
}

//
//
// ListView(
// scrollDirection: Axis.horizontal,
// children: <Widget>[
// Category(
// image_location: 'assets/cats/tshirt.png',
// image_caption: 'fashion',
//
// ),
//
// Category(
// image_location: 'assets/cats/dress.png',
// image_caption: 'electronic',
// ),
//
// Category(
// image_location: 'assets/cats/jeans.png',
// image_caption: 'grocery',
// ),
// Category(
// image_location: 'assets/cats/jeans.png',
// image_caption: 'mobile',
// ),
// Category(
// image_location: 'assets/cats/jeans.png',
// image_caption: 'shoe',
// ),
// Category(
// image_location: 'assets/cats/jeans.png',
// image_caption: 'pants',
// ),
// Category(
// image_location: 'assets/cats/jeans.png',
// image_caption: 'pants',
// ),
// Category(
// image_location: 'assets/cats/jeans.png',
// image_caption: 'pants',
// ),
//
// Category(
// image_location: 'assets/cats/formal.png',
// image_caption: 'formal',
// ),
//
// Category(
// image_location: 'assets/cats/informal.png',
// image_caption: 'formal',
// ),
// ],
// ),



