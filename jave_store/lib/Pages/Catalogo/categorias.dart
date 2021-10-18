//@dart=2.9
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jave_store/Entidades/Categoria.dart';
import 'package:jave_store/Entidades/Producto.dart';
import 'package:jave_store/Pages/Catalogo/pages/screenLibro.dart';
import 'package:jave_store/Pages/Widgets/AppBarBottom.dart';
import 'package:jave_store/Pages/Widgets/SearchBar.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  TabController _tabController;
  var _controller = TextEditingController();
  Future<List<Categoria>> getData() async {
    final url = "https://javestore.000webhostapp.com/jave/queryDB.php";
    final response = await http.post(Uri.parse(url),
        body: {"query": "select * from Categoria order by id;"});
    List<Categoria> rt = CategoriaFromJson(response.body);
    return rt;
  }

  Future<List<Producto>> getProducto(String val) async {
    final url = "https://javestore.000webhostapp.com/jave/queryDB.php";
    final response = await http.post(Uri.parse(url), body: {"query": val});
    List<Producto> rt = ProductoFromJson(response.body);
    return rt;
  }

  void _tapselect(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _tabController = new TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.only(top: 20, bottom: 20, left: 25, right: 25),
          height: 80,
          color: Colors.blue,
          child: Center(
            child: Container(
              height: 50,
              width: double.infinity,
              padding: EdgeInsets.only(left: 30, right: 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: Colors.white),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                    prefixIcon: IconButton(
                      color: Colors.yellow,
                      onPressed: () {},
                      icon: Icon(Icons.search, size: 20, color: Colors.black),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        _controller.clear();
                      },
                    ),
                    hintText: 'Buscar producto...',
                    border: InputBorder.none),
              ),
            ),
          ),
        ),
        FutureBuilder<List<Categoria>>(
          future: getData(),
          builder: (context, AsyncSnapshot<List<Categoria>> snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? Container(
                    height: 60,
                    child: TabBar(
                      onTap: _tapselect,
                      isScrollable: true,
                      controller: _tabController,
                      tabs: List.generate(
                        snapshot.data.length,
                        (index) => category(snapshot.data[index].nombre),
                      ),
                    ),
                  )
                : new Center();
          },
        ),
        Expanded(
          child: ScreenLibro(
            query:
                "select * from Producto where Categoriaid=${_selectedIndex + 1};",
          ),
        ),
      ],
    );
  }

  Widget category(String name) {
    return Container(
      width: 95,
      height: 45,
      child: Card(
        margin: EdgeInsets.all(5),
        semanticContainer: true,
        elevation: 6,
        child: Center(
          child: Text(
            name,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
