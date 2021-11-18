import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: MyAp_p(),
    ));

class MyAp_p extends StatelessWidget {
  DateTime selectedDate = DateTime.now();
  final firstDate = DateTime(2020, 1);
  final lastDate = DateTime(2025, 12);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
        title: 'Reportes',
        home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: new Center(
              child: new Text('Reportes',
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 25)),
            ),
            backgroundColor: Color(0xFF004aac),
          ),
          body: Column(
            children: [
              SizedBox(height: 10),
              Text(
                '$selectedDate'.split(' ')[0],
                style: TextStyle(fontSize: 24),
              ),
              Divider(),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => _openDatePicker(context),
                child: Text('Seleccionar Fecha'),
              ),
              Divider(),
              DataTable(
                columnSpacing: 44,
                columns: const <DataColumn>[
                  DataColumn(
                      label: Text('Nombre', textAlign: TextAlign.center)),
                  DataColumn(
                      label:
                          Text('Codigo\nProduco', textAlign: TextAlign.center)),
                  DataColumn(
                      label:
                          Text('Codigo\nCliente', textAlign: TextAlign.center)),
                  DataColumn(label: Text('Precio', textAlign: TextAlign.center))
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text('Lapices', textAlign: TextAlign.center)),
                    DataCell(Text('0014', textAlign: TextAlign.center)),
                    DataCell(Text('003', textAlign: TextAlign.center)),
                    DataCell(Text('100.000', textAlign: TextAlign.center)),
                  ]),
                  DataRow(cells: <DataCell>[
                    DataCell(Text('Cuadernos', textAlign: TextAlign.center)),
                    DataCell(Text('0015', textAlign: TextAlign.center)),
                    DataCell(Text('123', textAlign: TextAlign.center)),
                    DataCell(Text('200.000', textAlign: TextAlign.center))
                  ]),
                  DataRow(cells: <DataCell>[
                    DataCell(Text('Uniformes', textAlign: TextAlign.center)),
                    DataCell(Text('0013', textAlign: TextAlign.center)),
                    DataCell(Text('4243', textAlign: TextAlign.center)),
                    DataCell(Text('200.000', textAlign: TextAlign.center))
                  ]),
                  DataRow(cells: <DataCell>[
                    DataCell(Text('Libros', textAlign: TextAlign.center)),
                    DataCell(Text('0016', textAlign: TextAlign.center)),
                    DataCell(Text('5000', textAlign: TextAlign.center)),
                    DataCell(Text('300.000', textAlign: TextAlign.center))
                  ]),
                ],
              )
            ],
          ),
        ));
  }

  _openDatePicker(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  void setState(Null Function() param0) {}
}
