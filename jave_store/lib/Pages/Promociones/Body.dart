//@dart=2.9
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/Pages/Catalogo/categorias.dart';
import 'package:jave_store/Pages/Widgets/AppBarBottom.dart';
import 'package:jave_store/controller/apiFB.dart';

class body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<body> {
  ApiFB api = ApiFB();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Container>(
        future: getImages(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData ? Center(child: snapshot.data) : Container();
        });
  }

  Future<Container> getImages() async {
    var imagenes = await api.descuentos.getImagenesDescuentos();
    print(imagenes[0]);
    return Container(
        child: CarouselSlider.builder(
      itemCount: imagenes.length,
      options: CarouselOptions(
        height: 480.0,
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
      itemBuilder: (context, index, realIdx) {
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(imagenes[index]), fit: BoxFit.cover),
          ),
          child: InkWell(
              splashColor: Colors.red,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AppBarBottom()),
                );
              }),
        );
      },
    ));
  }
}
