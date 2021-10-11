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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      child: FutureBuilder<List<Producto>>(
          future: getData(),
          builder: (context, AsyncSnapshot<List<Producto>> snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? GridView.builder(
                    itemCount: snapshot.data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) => ItemCard(
                        product: snapshot.data[index],
                        press: () => {print(snapshot.data[index].codigo)}),
                  )
                : new Center(
                    child: new CircularProgressIndicator(),
                  );
          }),
    );
  }
}
