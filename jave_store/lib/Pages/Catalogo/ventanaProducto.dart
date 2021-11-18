//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/Entidades/Producto.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:jave_store/Pages/Resenas/resenas.dart';
import 'package:jave_store/controller/Cart/cartController.dart';
import 'package:jave_store/controller/apiFB.dart';
import 'package:localstorage/localstorage.dart';

class ventanaProducto extends StatefulWidget {
  final Producto product;
  const ventanaProducto({
    Key key,
    this.product,
  }) : super(key: key);

  @override
  _ventanaProducto createState() => _ventanaProducto();
}

class _ventanaProducto extends State<ventanaProducto> {
  final LocalStorage storage = new LocalStorage('localstorage_app');
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Future<Widget> descuento() async {
      String desc =
          await ApiFB().descuentos.getDescuentosProducto(widget.product);
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Descuento: ",
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ), //Textstyle
          ),
          Text(
            desc,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20,
              color: Colors.red,
              fontWeight: FontWeight.w500,
            ), //Textstyle
          ),
        ],
      );
    }

    return Center(
      /** Card Widget **/
      key: Key('productoDetallado'),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
        child: SizedBox(
          width: size.width / 1.35,
          height: size.height / 1.45,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Color.fromRGBO(235, 235, 235, 1),
                  ),
                  alignment: Alignment.topCenter,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: size.height / 200,
                        ),
                        Text(
                          "Nombre",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: size.height / 400,
                        ), //Texts
                        Text(
                          widget.product.name,
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ), //Textstyle
                        ),
                        Container(
                          margin: const EdgeInsets.all(5.0),
                          padding: const EdgeInsets.all(2.0),
                          height: size.height / 5.5,
                          width: size.width / 2.2,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent),
                            image: DecorationImage(
                                image: NetworkImage(widget.product.image),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Text(
                          "Descripción:",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ), //Textstyle
                        ),
                        Text(
                          widget.product.description,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5, //Textstyle
                        ),
                        SizedBox(
                          height: size.height / 80,
                        ),
                        Text(
                          "Calificación promedio",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: size.height / 400,
                        ),
                        RatingBar.builder(
                          initialRating: widget.product.rate.toDouble(),
                          minRating: 1,
                          itemSize: 20,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          ignoreGestures: true,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          /*
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                          */
                        ),
                        SizedBox(
                          height: size.height / 80,
                        ),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      resenas(Idproduct: widget.product.name)),
                            );
                          },
                          child: Text("Ver reseñas"),
                        ),

                        SizedBox(
                          height: size.height / 160,
                        ),
                      ]),
                ), //Siz
                SizedBox(
                  height: size.height / 60,
                ),

                FutureBuilder<String>(
                    future: ApiFB().descuentos.getDescuentosProducto(widget
                        .product), // a previously-obtained Future<String> or null
                    builder: (context, snapshot) {
                      if (snapshot.hasError) print(snapshot.error);
                      return snapshot.hasData
                          ? Column(children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Sin descuento: ",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ), //Textstyle
                                  ),
                                  Text(
                                    '\$' + "${widget.product.price} ",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300,
                                        decoration: TextDecoration
                                            .lineThrough), //Textstyle
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Precio actual: ",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ), //Textstyle
                                  ),
                                  Text(
                                    '\$' +
                                        (widget.product.price -
                                                double.parse(snapshot.data))
                                            .toString(),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ), //Textstyle
                                  ),
                                ],
                              )
                            ])
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Precio: ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ), //Textstyle
                                ),
                                Text(
                                  '\$' + "${widget.product.price} ",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ), //Textstyle
                                ),
                              ],
                            );
                    }),

                SizedBox(
                  height: size.height / 240,
                ), //Text //SizedBox
                Container(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      primary: Colors.blue,
                    ),
                    child: Text(
                      "Agregar",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    onPressed: () {
                      CartController().add_product(widget.product);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ), //Column
          ), //Padding
        ), //SizedBox
      ), //Card
    );
  }
}//Center

