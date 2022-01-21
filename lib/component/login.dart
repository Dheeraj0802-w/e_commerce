import 'dart:convert';
import 'package:e_commerce/component/signup.dart';
import 'package:e_commerce/widget/homepage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  _loginpageState createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  Future<void> addsess(userid) async {
    print("hello function run");
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();

    prefs.setString('userid', userid);
  }
  Future<void> add() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('userid');
    print(userid);
  }
  MakePostRequest() async {

    print("hello world");
    final uri = Uri.parse('http://127.0.0.1:8000/api/Login');
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      'username':nameController.text.toString(),
      'password':passwordController.text.toString(),
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

    var fetchData = jsonDecode(response.body);

    if(fetchData["Message"]==200){
      addsess(nameController.text);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder:
              (context) =>homepage(),
          )
      );
      Fluttertoast.showToast(msg: "Welcome to Daily Shopping");
    }
    else{
      Fluttertoast.showToast(msg: "Wrong id or password");
    }

    // addsess(nameController.text.toString());





  }
  final userid=TextEditingController();
  final nameController=TextEditingController();
  final passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Center( child: new Text("Login form with Api"),
              ),
            ),

            body: Padding(
              padding: EdgeInsets.all(10),
              child: ListView(
                  children: <Widget>[
                    Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text('Login App',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w500,fontSize: 30),
                        )
                    ),
                    Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Sign in',
                          style: TextStyle(fontSize: 20),
                        )),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'User Name',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: (){
                        //forgot password screen
                      },
                      textColor: Colors.blue,
                      child: Text('Forgot Password'),
                    ),
                    Container(
                        height: 50,
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: RaisedButton(
                            textColor: Colors.white,
                            color: Colors.blue,
                            child: Text('Login'),
                            onPressed: MakePostRequest
                          // onPressed: (){
                          //     if(nameController.text=="dheeraj" && passwordController.text=="1111"){
                          //       addsess(nameController.text);
                          //       Navigator.pushReplacement(context,
                          //           MaterialPageRoute(builder:
                          //               (context) =>homepage(),
                          //           )
                          //       );
                          //     }
                          //     else{
                          //       Fluttertoast.showToast(msg: "Wrong id or password");
                          //     }
                          // },
                        )),
                    Container(
                        child: Row(
                          children: <Widget>[
                            Text('Does not have account?'),
                            FlatButton(
                                textColor: Colors.blue,
                                child: Text(
                                  'Sign UP',
                                  style: TextStyle(fontSize: 20),
                                ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>signup()));
                              },
                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        )
                    )

                  ]
              ),
            )
        )
    );
  }
}