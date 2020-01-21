import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_assignment/model/user_data.dart';
import 'package:flutter_assignment/network/api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../const.dart';
import 'login.dart';

class RegistrationPage extends StatelessWidget {
  static final String path = "lib/src/pages/login/login3.dart";

  var usernameController = new TextEditingController();
  var emailController = new TextEditingController();
  var passwordController = new TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 25,
                ),
                Text("User Registration",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0)),
                SizedBox(
                  height: 20,
                ),
                itemCard("User Name", usernameController),
                itemCard("Email", emailController),
                itemCard("Password", passwordController),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(30.0),
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    color: Colors.pink,
                    onPressed: () {
                      if (validate()) {
                        doSignUp(context);
                      }
                    },
                    elevation: 11,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40.0))),
                    child: Text("Sign Up",
                        style: TextStyle(color: Colors.white70)),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Already have an account?"),
                    FlatButton(
                      child: Text("Login"),
                      textColor: Colors.pink,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  ///This widget is used for userName , email and For Password
  Widget itemCard(String hintText, TextEditingController controller) {
    return Card(
      margin: EdgeInsets.only(left: 30, right: 30, top: 30),
      elevation: 11,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(40))),
      child: TextField(
        controller: controller, //added controller
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.person,
              color: Colors.black26,
            ),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.black26),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(40.0)),
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0)),
      ),
    );
  }

  ///validation for userName , Email and For Password
  bool validate() {
    if (usernameController.text == null) {
      Const.showMessage("Enter Username");
      return false;
    } else if (emailController.text == null) {
      Const.showMessage("Enter Email");
      return false;
    }else if (passwordController.text == null) {
      Const.showMessage("Enter Password");
      return false;
    } else {
      return true;
    }
  }

  ///SignUp Function
  void doSignUp(context) async {
    isLoading = true;
    Const.showLoader(context);
    Map<String, dynamic> map = {
      'username': usernameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'insecure': 'cool'
    };
    print(map);
    var response = await ApiService.userSignUp(map);
    print(response.data);

    if (response.data['status'] == "ok") {
      var userData = UserData.fromJson(response.data["user"]);
      final storage = new FlutterSecureStorage();
      await storage.write(
          key: Const.user, value: json.encode(userData.toJson()));
      await storage.write(key: Const.isLogin, value: Const.TRUE);
      await storage.write(key: Const.cookie, value: response.data['cookie']);
      if (isLoading) {
        Navigator.pop(context);
      }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
      if (isLoading) {
        Navigator.pop(context);
      }
      Const.showMessage("Something went wrong!");
    }
  }
}
