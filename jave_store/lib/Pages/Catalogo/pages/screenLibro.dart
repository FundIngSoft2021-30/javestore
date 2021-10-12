//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/Entidades/Producto.dart';
import 'package:http/http.dart' as http;
import 'package:jave_store/Pages/Catalogo/Item.dart';

class ScreenLibro extends StatelessWidget {
  final url = "https://javestore.000webhostapp.com/jave/queryDB.php";
  Future<List<Producto>> getData() async {
    final response = await http.post(Uri.parse(url), body: {
      "query":
          "select * from Producto p where p.Categoriaid=2 and p.estado='A';"
    });

    List<Producto> rt = ProductoFromJson(response.body);
    return rt;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        alignment: Alignment.bottomCenter,
        height: size.height / 1.2,
        width: size.width,
        child: FutureBuilder<List<Producto>>(
            future: getData(),
            builder: (context, AsyncSnapshot<List<Producto>> snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: Container(
                              child: GridView.builder(
                                padding: EdgeInsets.only(left: 30),
                                shrinkWrap: true,
                                itemCount: snapshot.data.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                ),
                                itemBuilder: (context, index) => ItemCard(
                                    product: snapshot.data[index],
                                    press: () =>
                                        {print(snapshot.data[index].codigo)}),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : new Center(
                      child: new CircularProgressIndicator(),
                    );
            }),
      ),
    );
  }
}
