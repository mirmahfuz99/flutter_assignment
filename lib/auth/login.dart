import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/model/user_data.dart';
import 'package:flutter_assignment/network/api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../const.dart';
import '../home_page.dart';

class LoginPage extends StatelessWidget {
  var usernameController = new TextEditingController();
  var passwordController = new TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Container(
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                    ),
                    Text("Login",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28.0)),
                    itemCard("User Name", usernameController),
                    itemCard("Password", passwordController),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(30.0),
                      child: RaisedButton(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        color: Colors.pink,
                        onPressed: () {
                          if (validate()) {
                            doLogin(context);
                          }
                        },
                        elevation: 11,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40.0))),
                        child: Text("Login",
                            style: TextStyle(color: Colors.white70)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget itemCard(String hintText, TextEditingController controller) {
    return Card(
      margin: EdgeInsets.only(left: 30, right: 30, top: 30),
      elevation: 11,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(40))),
      child: TextField(
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
        controller: controller,
      ),
    );
  }

  ///validation for userName , Email and For Password
  bool validate() {
    if (usernameController.text == null) {
      Const.showMessage("Enter Username");
      return false;
    } else if (passwordController.text == null) {
      Const.showMessage("Enter Password");
      return false;
    } else {
      return true;
    }
  }

  ///SignUp Function
  void doLogin(context) async {
    isLoading = true;
    Const.showLoader(context);
    var response = await ApiService.userLogin(
        usernameController.text, passwordController.text);
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
        MaterialPageRoute(builder: (context) => HomePage(name: usernameController.text,)),
      );
    } else {
      if (isLoading) {
        Navigator.pop(context);
      }
      Const.showMessage("Something went wrong!");
    }
  }
}
