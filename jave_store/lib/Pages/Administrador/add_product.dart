//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/Entidades/Categoria.dart';
import 'package:jave_store/Entidades/Producto.dart';
import 'package:jave_store/controller/apiFB.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController nombre = new TextEditingController();
  TextEditingController description = new TextEditingController();
  TextEditingController price = new TextEditingController();
  TextEditingController quantity = new TextEditingController();
  TextEditingController url = new TextEditingController();
  String _currentCategory = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Container(
            width: size.width * 0.9,
            height: size.height * 0.8,
            color: Colors.transparent,
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                padding: EdgeInsets.only(top: 40, left: 30, right: 30),
                child: Column(
                  children: [
                    Text(
                      "Anadir producto",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      style: TextStyle(color: Colors.black),
                      controller: nombre,
                      decoration: InputDecoration(
                          labelText: "Nombre producto",
                          labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                      onSaved: (value) {
                        nombre.text = value;
                      },
                    ),
                    FutureBuilder<List<Categoria>>(
                      future: ApiFB().getCategories(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return Text('');
                        List<DropdownMenuItem> data = [];
                        for (int i = 0; i < snapshot.data.length; i++) {
                          data.add(DropdownMenuItem(
                            child: Text(snapshot.data[i].nombre),
                            value: snapshot.data[i].nombre,
                          ));
                        }
                        return DropdownButtonFormField(
                          onChanged: (val) {
                            setState(() => _currentCategory = val);
                          },
                          items: data,
                          hint: Text("Categoria",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                          style: TextStyle(color: Colors.black),
                        );
                      },
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          labelText: "Descripcion",
                          labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                      controller: description,
                      onSaved: (value) {
                        description.text = value;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.black),
                      onChanged: (value) async {},
                      decoration: InputDecoration(
                          labelText: "Precio",
                          labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                      controller: price,
                      onSaved: (value) {
                        price.text = value;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.black),
                      controller: quantity,
                      decoration: InputDecoration(
                        labelText: "Cantidad",
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onSaved: (value) {
                        quantity.text = value;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.url,
                      style: TextStyle(color: Colors.black),
                      controller: url,
                      decoration: InputDecoration(
                        labelText: "Url imagen",
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onSaved: (value) {
                        url.text = value;
                      },
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                      ),
                      width: size.width * 0.4,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.blue,
                        ),
                        onPressed: () async {
                          bool flag = await ApiFB().add_product(Producto(
                              name: nombre.text,
                              description: description.text,
                              price: double.parse(price.text),
                              quantity: int.parse(quantity.text),
                              image: url.text,
                              category: _currentCategory,
                              available: true,
                              rate: 5));
                          if (flag) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Alert(
                                      "El producto ha sido creado con éxito");
                                });
                            nombre.text = '';
                            description.text = '';
                            price.text = '';
                            quantity.text = '';
                            url.text = '';
                            _currentCategory = '';
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Alert("Ha ocurrido un error");
                                });
                          }
                        },
                        child: Text(
                          'Agregar',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget Alert(String msm) {
    return AlertDialog(
      backgroundColor: Colors.blue.shade50,
      title: Text("Estado"),
      content: Text(msm),
    );
  }
}
