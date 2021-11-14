//@dart=2.9

import 'package:flutter/material.dart';
import 'package:jave_store/Entidades/Categoria.dart';
import 'package:jave_store/Entidades/Producto.dart';
import 'package:jave_store/controller/apiFB.dart';

class Modificar extends StatefulWidget {
  final Producto product;
  const Modificar({
    Key key,
    this.product,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ModificarState();
  }
}

class ModificarState extends State<Modificar> {
  String _nombre;
  String _descripcion;
  String _urlImagen;
  String _precio;
  String _cantidad;
  String _categoria;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  showAlertDialog(BuildContext context, String mensaje, String titulo) {
    // set up the button
    Widget okButton = TextButton(
//
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(titulo),
      content: Text(mensaje),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _categoria = widget.product.category;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: Text('Editar'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(0),
                  padding: const EdgeInsets.all(0),
                  height: size.height / 5,
                  width: size.width / 2,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                    image: DecorationImage(
                        image: NetworkImage(widget.product.image),
                        fit: BoxFit.cover),
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Nombre producto'),
                  maxLength: 50,
                  readOnly: true,
                  initialValue: widget.product.name,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Campo vacio';
                    }

                    return null;
                  },
                  onSaved: (String value) {
                    _nombre = value;
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
                      decoration: InputDecoration(labelText: 'Categoria'),
                      value: widget.product.category,
                      onChanged: (val) {
                        _categoria = val;
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
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'Descripcion'),
                  maxLength: 250,
                  initialValue: widget.product.description,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Campo vacio';
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    _descripcion = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Url imagen'),
                  keyboardType: TextInputType.url,
                  initialValue: widget.product.image,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'URL is Required';
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    _urlImagen = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Precio'),
                  initialValue: widget.product.price.toString(),
                  keyboardType: TextInputType.phone,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Campo vacio';
                    }

                    return null;
                  },
                  onSaved: (String value) {
                    _precio = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Cantidad'),
                  initialValue: widget.product.quantity.toString(),
                  keyboardType: TextInputType.number,
                  validator: (String value) {
                    int calories = int.tryParse(value);

                    if (calories == null || calories <= 0) {
                      return 'La cantidad debe ser mayor a 0';
                    }

                    return null;
                  },
                  onSaved: (String value) {
                    _cantidad = value;
                  },
                ),
                SizedBox(
                  height: size.height / 20,
                ),
                ElevatedButton(
                  child: Text(
                    'Modificar',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () async {
                    String nombre = "-";
                    if (_formKey.currentState.validate()) {
                      await _formKey.currentState.save();

                      bool modificado = false;

                      if (_nombre != widget.product.name) {
                        modificado = true;
                        /*
                        repetido = await ApiFB().productos.check_name(_nombre);
                        if (!repetido)
                          nombre = _nombre;
                        else
                          showAlertDialog(context, "Nombre repetido",
                              "El nombre ingresado ya pertenece a un producto");
                              */
                      }
                      if (_categoria != widget.product.category) {
                        modificado = true;
                        widget.product.category = _categoria;
                      }
                      if (_descripcion != widget.product.description) {
                        modificado = true;
                        widget.product.description = _descripcion;
                      }
                      if (_urlImagen != widget.product.image) {
                        modificado = true;
                        widget.product.image = _urlImagen;
                      }
                      if (_precio != widget.product.price) {
                        modificado = true;
                        widget.product.price = double.parse(_precio);
                      }
                      if (_cantidad != widget.product.quantity) {
                        modificado = true;
                        widget.product.quantity = int.parse(_cantidad);
                      }
                      if (modificado) {
                        await ApiFB()
                            .productos
                            .modify_product(widget.product, nombre);
                        Navigator.of(context).pop();
                      } else
                        showAlertDialog(
                            context,
                            "Ningun campo ha sido cambiado",
                            "Modificacion fallida");
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
