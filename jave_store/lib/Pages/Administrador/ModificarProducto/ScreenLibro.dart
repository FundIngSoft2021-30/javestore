//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/Entidades/Producto.dart';
import 'package:jave_store/Pages/Administrador/ModificarProducto/ItemCard.dart';
import 'package:jave_store/controller/apiFB.dart';

class ScreenLibro extends StatelessWidget {
  final ApiFB api = new ApiFB();
  final int data;
  ScreenLibro({this.data});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.topCenter,
      height: size.height / 1.2,
      width: size.width,
      child: FutureBuilder<List<Producto>>(
          future: api.getProductsByCategory(data),
          builder: (context, AsyncSnapshot<List<Producto>> snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: GridView.builder(
                      padding: EdgeInsets.only(top: 20, bottom: 20, left: 25),
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 0.75),
                      itemBuilder: (context, index) => ItemCard(
                        product: snapshot.data[index],
                      ),
                    ),
                  )
                : new Center(
                    child: new CircularProgressIndicator(),
                  );
          }),
    );
  }
}
