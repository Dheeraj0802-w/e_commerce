import 'package:e_commerce/component/appbar.dart';
import 'package:flutter/material.dart';

class Trending extends StatefulWidget {
  const Trending({Key? key}) : super(key: key);

  @override
  _TrendingState createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body:  Container(
        child: GridView.count(
            crossAxisCount:2,
            children: List.generate(8, (index) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  //color: Colors.amberAccent,
                  // decoration: BoxDecoration(
                  //   image: new DecorationImage(image: NetworkImage('https://images.pexels.com/photos/110854/pexels-photo-110854.jpeg'), fit: BoxFit.cover),
                  //   borderRadius: BorderRadius.all(Radius.circular(100))
                  //   ),
                    child: Image.network('https://images.pexels.com/photos/110854/pexels-photo-110854.jpeg', fit: BoxFit.cover,)
                  // Text(
                  //   'Item $index',
                  //   style: TextStyle(fontSize: 20),
                  // )
                ),
              );
            })),
      ),
    );
  }
}