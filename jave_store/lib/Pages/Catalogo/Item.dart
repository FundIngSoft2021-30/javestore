//@dart=2.9
import 'package:flutter/material.dart';
import 'package:jave_store/Entidades/Producto.dart';

class ItemCard extends StatelessWidget {
  final Producto product;
  final Function press;
  const ItemCard({
    Key key,
    this.product,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
  
             Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Hero(
                tag: product.codigo,
                child: Container(
                width: 100,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Frockcontent.com%2Fes%2Fwp-content%2Fuploads%2Fsites%2F3%2F2019%2F02%2Fo-que-e-produto-no-mix-de-marketing.png&f=1&nofb=1"),
                      fit: BoxFit.cover),
                ),
              ),
              ),
            ),
          
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20 / 4),
            child: Text(
              // products is out demo list
              product.nombre,
              style: TextStyle(color: Colors.black),
            ),
          ),
          Text(
            product.precio,
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}