//@dart=2.9
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/Pages/Widgets/ButtonOption.dart';
import 'package:jave_store/Pages/Widgets/LabelText.dart';
import 'package:jave_store/Pages/Widgets/Button.dart';

class body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<body> {
  String passCamp = "";
  var _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.all(15),
      child: CarouselSlider.builder(
        itemCount: 1,
        options: CarouselOptions(
          enlargeCenterPage: true,
          height: 300,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          reverse: false,
          aspectRatio: 5.0,
        ),
        itemBuilder: (context, i, id) {
          //for onTap to redirect to another screen
          return GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.white,
                  )),
              //ClipRRect for image border radius
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Icon(Icons.ac_unit_sharp)),
              /*
                child: Image.network(
                  imageList[0],
                  width: 500,
                  fit: BoxFit.cover,
                ),
                */
            ),
            onTap: () {
              /*
              var url = imageList[i];
              print(url.toString());
              */
            },
          );
        },
      ),
    );
  }
}
