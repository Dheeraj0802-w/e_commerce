import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart';
import 'dart:convert';
void main() {
  runApp(const signup());
}
class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  MakePostRequest() async {
    print("hello world");
    final uri = Uri.parse('http://127.0.0.1:8000/api/signup');
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      'username': name.text,
      'Email': Email.text,
      'Password':Password.text,
      'phone_no':phone_no.text,
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;
    print(responseBody);

  }

  final name=TextEditingController();
  final Email=TextEditingController();
  final Password=TextEditingController();
  final phone_no=TextEditingController();
  //final im=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title:Center(child: new Text("Api"),
          ),
        ),
        body: Column(
          children: [
            Container(
                child: TextField(controller:name,decoration: InputDecoration(labelText: "name",),

                )
            ),
            Container(
                child: TextField(controller:Email,decoration: InputDecoration(labelText: "Email",),

                )
            ),
            Container(
                child: TextField(controller:Password,decoration: InputDecoration(labelText: "Password ",),

                )
            ),
            Container(
                child: TextField(controller:phone_no,decoration: InputDecoration(labelText: "phone_no",),

                )
            ),

            Container(
              child: FlatButton(
                child: Text('Submit', style: TextStyle(fontSize: 20.0),
                ),
                onPressed: MakePostRequest,
              ),
            ),
            // Container(
            //   child: FlatButton(
            //     child: Text('Show Data', style: TextStyle(fontSize: 20.0),),
            //     onPressed: (){
            //       Navigator.push(context, MaterialPageRoute(builder: (context)=> fetchlist()));
            //
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );

  }
}