//@dart=2.9
import 'dart:ffi';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/controller/apiFB.dart';

class body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<body> {
  ApiFB api = ApiFB();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: CarouselSlider(
        options: CarouselOptions(
          height: 400.0,
          aspectRatio: 16 / 9,
          viewportFraction: 0.8,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
        items: <Widget>[
          FutureBuilder<Widget>(
              future: getImages(),
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);
                return snapshot.hasData
                    ? snapshot.data
                    : Container(child: Text('paila'));
              })
        ],
      ),
    );
  }

  Future<Widget> getImages() async {
    var imagenes = await api.descuentos.getImagenesDescuentos();
    return ListView(children: [
      for (var i = 0; i < imagenes.length; i++)
        Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(imagenes.elementAt(i)),
                  fit: BoxFit.cover),
            ))
    ]);
  }
}
