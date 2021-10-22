//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/Entidades/Producto.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:jave_store/controller/apiDB.dart';

class ventanaProducto extends StatefulWidget {
  final Producto product;
  final url = "https://javestore.000webhostapp.com/jave/queryDB.php";

  const ventanaProducto({
    Key key,
    this.product,
  }) : super(key: key);

  @override
  _ventanaProducto createState() => _ventanaProducto();
}

class _ventanaProducto extends State<ventanaProducto> {
  ApiDB controllerDB = new ApiDB();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      /** Card Widget **/
      child: Card(
        elevation: 600,
        color: Colors.grey[70],
        shadowColor: Colors.white,
        child: SizedBox(
          width: size.width / 1.35,
          height: size.height / 1.4,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      alignment: Alignment.centerRight,
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.clear,
                        color: Colors.blueAccent,
                      )),
                ),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(3.0),
                  height: size.height / 5,
                  width: size.width / 1.6,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                    image: DecorationImage(
                        image: NetworkImage(widget.product.imagen),
                        fit: BoxFit.cover),
                  ),
                ),
                //SizedBox
                Text(
                  widget.product.nombre,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ), //Textstyle
                ),
                SizedBox(
                  height: 15,
                ),
                RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  itemSize: 20,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ), //Text
                SizedBox(
                  height: 5,
                ), //SizedBox
                Text(
                  widget.product.descripcion,
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
                SizedBox(
                  height: size.height / 40,
                ),
                Text(
                  '\$ ' + widget.product.precio,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ), //Textstyle
                ),
                SizedBox(
                  height: size.height / 50,
                ), //Text //SizedBox
                SizedBox(
                  width: size.width / 3,
                  child: RaisedButton(
                    onPressed: () => controllerDB.insertItem('1', '1'),
                    color: Colors.blue,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        children: [
                          Icon(Icons.add_shopping_cart_sharp),
                          Text(
                            'Agregar',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ), //Row
                    ), //Padding
                  ), //RaisedButton
                ) //SizedBox
              ],
            ), //Column
          ), //Padding
        ), //SizedBox
      ), //Card
    );
  }
}//Center