//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarBottom extends StatefulWidget {
  @override
  _AppBarBottom createState() => _AppBarBottom();
}

class _AppBarBottom extends State<AppBarBottom> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: AppBar(
      leading: Icon(Icons.align_vertical_top_sharp),
      title: Text('Page title'),
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue,
    ));
  }
}
