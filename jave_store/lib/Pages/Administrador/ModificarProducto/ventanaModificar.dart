// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/Entidades/Producto.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:jave_store/Pages/Administrador/ModificarProducto/modificar.dart';
import 'package:jave_store/Pages/Resenas/resenas.dart';
import 'package:jave_store/controller/Cart/cartController.dart';
import 'package:jave_store/controller/apiFB.dart';
import 'package:localstorage/localstorage.dart';

class ventanaModificar extends StatefulWidget {
  final Producto product;
  const ventanaModificar({
    Key key,
    this.product,
  }) : super(key: key);

  @override
  _ventanaModificar createState() => _ventanaModificar();
}

class _ventanaModificar extends State<ventanaModificar> {
  final LocalStorage storage = new LocalStorage('localstorage_app');

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<Producto>(
        future: ApiFB().get_product(widget.product.name),
        builder: (context, AsyncSnapshot<Producto> snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? Center(
                  /** Card Widget **/
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                    child: SizedBox(
                      width: size.width / 1.35,
                      height: size.height / 1.5,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                      snapshot.data.name,
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
                                        border: Border.all(
                                            color: Colors.blueAccent),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                snapshot.data.image),
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
                                      snapshot.data.description,
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
                                      initialRating:
                                          snapshot.data.rate.toDouble(),
                                      minRating: 1,
                                      itemSize: 20,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      ignoreGestures: true,
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 4.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                    SizedBox(
                                      height: size.height / 80,
                                    ),
                                    OutlinedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => resenas(
                                                  Idproduct:
                                                      snapshot.data.name)),
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

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Precio: ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ), //Textstyle
                                ),
                                Text(
                                  '\$' + "${snapshot.data.price} ",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ), //Textstyle
                                ),
                              ],
                            ),

                            SizedBox(
                              height: size.height / 240,
                            ), //Text //SizedBox
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(30.0)),
                                      primary: Colors.green,
                                    ),
                                    child: Text(
                                      "Modificar",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Modificar(
                                                product: snapshot.data)),
                                      );
                                    },
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(30.0)),
                                      primary: Colors.red,
                                    ),
                                    child: Text(
                                      "Eliminar",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                    onPressed: () async {
                                      /*
                          await ApiFB()
                              .productos
                              .delete_product(snapshot.data.name);
                              */
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ]),
                          ],
                        ), //Column
                      ), //Padding
                    ), //SizedBox
                  ), //Card
                )
              : Center();
        });
  }
}//Center

