//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTop extends StatefulWidget {
  @override
  _AppTop createState() => _AppTop();
}

class _AppTop extends State<AppTop> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Icon(Icons.align_vertical_top_sharp),
      title: Text('Page title'),
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue,
    );
  }
}
