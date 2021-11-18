//@dart=2.9
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/Entidades/Pedido.dart';
import 'package:jave_store/Entidades/Producto.dart';
import 'package:jave_store/controller/Pedido/pedidoController.dart';
import 'package:jave_store/controller/apiFB.dart';

class Reportes extends StatefulWidget {
  @override
  _ReportesState createState() => _ReportesState();
}

class _ReportesState extends State<Reportes> {
  String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  Future<List<Producto>> productos;
  String time;
  Timer timer;
  @override
  void initState() {
    productos = pedidoController(ApiFB().firestore).getAllPbydate(date);
    time = DateFormat('kk:mm:ss').format(DateTime.now());
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.05,
          ),
          Row(
            children: [
              Text(
                'Fecha:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                width: size.width * 0.05,
              ),
              Text(
                date,
              ),
              Spacer(),
              TextButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Cambiar fecha')),
            ],
          ),
          Row(
            children: [
              Text('Hora actual:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  )),
              SizedBox(
                width: size.width * 0.05,
              ),
              Text(
                time,
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: Colors.grey[400],
            ),
            height: size.height * 0.07,
            child: Center(
              child: Text(
                'Reportes de ventas',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            color: Colors.grey[300],
            height: size.height * 0.20,
            alignment: Alignment.topCenter,
            child: FutureBuilder<List<Pedido>>(
              future:
                  pedidoController(ApiFB().firestore).get_pedido_byDate(date),
              builder: (context, snapshot) => snapshot.hasData
                  ? Column(
                      children: [
                        ListTile(
                          title:
                              Text('Ventas totales: ${snapshot.data.length}'),
                          leading: Image.asset(
                            'images/dolar.png',
                            width: size.width * 0.1,
                            height: size.height * 0.05,
                            fit: BoxFit.fill,
                            alignment: Alignment.center,
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ),
          ),
          Container(
            height: size.height * 0.07,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
            child: Center(
              child: FutureBuilder<double>(
                future: pedidoController(ApiFB().firestore).cost_by_date(date),
                builder: (context, snapshot) => Text(
                  'Total de ventas: ${snapshot.data}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
          Container(
            width: size.width,
            height: size.height * 0.06,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Center(
              child: Text(
                date,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            width: size.width,
            height: size.height * 0.5,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
            child: FutureBuilder<List<Producto>>(
              future: productos,
              builder: (context, s) => s.hasData
                  ? SingleChildScrollView(
                      child: DataTable(
                        columns: [
                          DataColumn(
                            label: Text('Producto'),
                          ),
                          DataColumn(
                            label: Text('Categoria'),
                          ),
                          DataColumn(
                            label: Text('Price'),
                          ),
                        ],
                        rows: s.data
                            .map((p) => DataRow(
                                  cells: [
                                    DataCell(
                                      Text(p.name),
                                    ),
                                    DataCell(
                                      Text(p.category.toString()),
                                    ),
                                    DataCell(
                                      Text(p.price.toString()),
                                    ),
                                  ],
                                ))
                            .toList(),
                      ),
                    )
                  : Container(),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null)
      setState(() {
        date = DateFormat('yyyy-MM-dd').format(pickedDate);
        this.productos =
            pedidoController(ApiFB().firestore).getAllPbydate(date);
      });
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    setState(() {
      time = DateFormat('kk:mm:ss').format(now);
    });
  }
}
