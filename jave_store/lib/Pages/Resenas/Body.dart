//@dart=2.9
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          items: [
            'https://images.unsplash.com/photo-1547721064-da6cfb341d50',
            'https://unsplash.com/photos/JKjBsuKpatU/download?ixid=MnwxMjA3fDB8MXxzZWFyY2h8MTd8fHNhbGVzfHwwfHx8fDE2MzU2Mjc4NDU&force=true&w=640',
            'https://unsplash.com/photos/pPzQP35zh4o/download?ixid=MnwxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNjM1NjQ4MTYw&force=true&w=640',
            'https://images.unsplash.com/photo-1547721064-da6cfb341d50',
            'https://images.unsplash.com/photo-1547721064-da6cfb341d50'
          ].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(i), fit: BoxFit.cover),
                    ));
              },
            );
          }).toList(),
        ));
  }
}
