import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String name;
//  final String email;

  HomePage({@required this.name});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page"),),
      body: Center(
        child: new Column(
          children: <Widget>[
            Text(widget.name),
//            Text(widget.email),
          ],
        ),
      ),
    );
  }
}
