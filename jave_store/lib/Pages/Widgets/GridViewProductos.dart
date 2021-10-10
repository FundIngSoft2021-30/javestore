//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GridViewProductos extends StatefulWidget {
  @override
  _GridViewProductos createState() => _GridViewProductos();
}

class _GridViewProductos extends State<GridViewProductos> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 40,
      mainAxisSpacing: 40,
      crossAxisCount: 3,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            print("Container clicked");
          },
          child: Stack(children: <Widget>[
            Container(
              height: 140,
              width: 164,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.teal[100],
                image: new DecorationImage(
                  image: ExactAssetImage('images/background.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
                alignment: Alignment.bottomCenter,
                height: 7,
                width: 164,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.blueAccent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text('Your widget at the end'))
          ]),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: const Text('Heed not the rabble'),
          color: Colors.teal[200],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: const Text('Sound of screams but the'),
          color: Colors.teal[300],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: const Text('Who scream'),
          color: Colors.teal[400],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: const Text('Revolution is coming...'),
          color: Colors.teal[500],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: const Text('Revolution, they...'),
          color: Colors.teal[600],
        ),
      ],
    ));
  }
}
