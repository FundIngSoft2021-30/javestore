//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/Pages/resenas/body.dart';

void main() => runApp(resenas());

class resenas extends StatefulWidget {
  final String Idproduct;

  resenas({
    Key key,
    this.Idproduct,
  }) : super(key: key);

  @override
  _resenasState createState() => _resenasState();
}

class _resenasState extends State<resenas> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Text('Reseñas'),
          backgroundColor: Colors.blue,
        ),
        body: body(Idproduct: widget.Idproduct),
      ),
    );
  }
}
