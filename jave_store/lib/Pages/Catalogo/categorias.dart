//@dart=2.9
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jave_store/Entidades/Categoria.dart';
import 'package:jave_store/Entidades/Producto.dart';
import 'package:jave_store/Pages/Catalogo/pages/screenLibro.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:jave_store/Pages/Catalogo/ventanaProducto.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  TabController _tabController;
  final _formKey = GlobalKey<FormState>();
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

  Future<List<String>> suggestions() async {
    final url = "https://javestore.000webhostapp.com/jave/queryDB.php";
    final response = await http
        .post(Uri.parse(url), body: {"query": "select nombre from Producto"});
    List<Producto> tmp = ProductoFromJson(response.body);
    List<String> rt = new List<String>();
    for (Producto x in tmp) rt.add(x.nombre);
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
              child: Form(
                key: _formKey,
                child: Container(
                  child: TypeAheadFormField(
                    suggestionsCallback: (pattern) => suggestions().then(
                        (value) => value.where((item) => item
                            .toLowerCase()
                            .contains(pattern.toLowerCase()))),
                    onSuggestionSelected: (String val) async {
                      this._controller.text = val;
                      Producto product = await getProducto(
                              "Select * from Producto where nombre='${val}'")
                          .then((value) => value[0]);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ventanaProducto(product: product)));
                    },
                    itemBuilder: (context, String item) => ListTile(
                      title: Text(item),
                    ),
                    getImmediateSuggestions: false,
                    hideSuggestionsOnKeyboardHide: true,
                    hideOnEmpty: false,
                    noItemsFoundBuilder: (context) => Padding(
                      padding: EdgeInsets.all(8),
                      child: Text("No items"),
                    ),
                    textFieldConfiguration: TextFieldConfiguration(
                      decoration: InputDecoration(
                        hintText: "Buscar",
                        suffixIcon: IconButton(
                          onPressed: () {
                            this._controller.clear();
                          },
                          icon: Icon(Icons.cancel_rounded),
                        ),
                      ),
                      controller: this._controller,
                    ),
                  ),
                ),
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
                    color: Colors.white.withOpacity(.45),
                    height: 40,
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
        color: Colors.white,
        semanticContainer: true,
        elevation: 0,
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
