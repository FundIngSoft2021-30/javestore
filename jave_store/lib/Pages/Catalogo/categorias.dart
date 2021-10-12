//@dart=2.9
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jave_store/Entidades/Categoria.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final url = "https://javestore.000webhostapp.com/jave/queryDB.php";
  Future<List<Categoria>> getData() async {
    final response = await http
        .post(Uri.parse(url), body: {"query": "select nombre from Categoria;"});
    List<Categoria> rt = CategoriaFromJson(response.body);
    return rt;
  }
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<List<Categoria>>(
        future: getData(),
        builder: (context, AsyncSnapshot<List<Categoria>> snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) =>
                      buildCategory(index, snapshot.data[index].nombre),
                )
              : new Center(
                 
                );
        },
    
    );
  }

  Widget buildCategory(int index, String name) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: selectedIndex == index
                    ? Color(0xFF535353)
                    : Color(0xFFACACAC),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20 / 4), //top padding 5
              height: 2,
              width: 30,
              color: selectedIndex == index ? Colors.black : Colors.transparent,
            
            ),
           
          ],
        ),
      ),
    );
  }
}
