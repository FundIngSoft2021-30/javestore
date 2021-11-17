import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: MyAp_p(),
    ));

class MyAp_p extends StatelessWidget {
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
          body: 
          
          DataTable(
            columnSpacing: 44,
            columns: const <DataColumn> [
            DataColumn(label: Text('Nombre', textAlign: TextAlign.center)),
            DataColumn(label: Text('Codigo\nProduco',textAlign: TextAlign.center)),
            DataColumn(label: Text ('Codigo\nCliente', textAlign: TextAlign.center)),
            DataColumn(label: Text('Precio', textAlign: TextAlign.center))

          ],
          rows: [
            DataRow(cells: [
              DataCell(Text('Lapices',textAlign: TextAlign.center)),
              DataCell(Text('0014',textAlign: TextAlign.center)),
              DataCell(Text('003',textAlign: TextAlign.center)),
              DataCell(Text('100.000',textAlign: TextAlign.center)),
 
            ]),
             DataRow(cells: <DataCell> [
              DataCell(Text('Cuadernos',textAlign: TextAlign.center)),
              DataCell(Text('0015',textAlign: TextAlign.center)),
              DataCell(Text('123',textAlign: TextAlign.center)),
              DataCell(Text('200.000',textAlign: TextAlign.center))
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('Uniformes',textAlign: TextAlign.center)),
              DataCell(Text('0013',textAlign: TextAlign.center)),
              DataCell(Text('4243',textAlign: TextAlign.center)),
              DataCell(Text('200.000',textAlign: TextAlign.center))
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('Libros',textAlign: TextAlign.center)),
              DataCell(Text('0016',textAlign: TextAlign.center)),
              DataCell(Text('5000',textAlign: TextAlign.center)),
              DataCell(Text('300.000',textAlign: TextAlign.center))
            ]),

          ],         
         )
      
      ));
  }

  /*Widget Alert(String msm) {
    return AlertDialog(
      backgroundColor: Colors.blue.shade50,
      title: Text("Respuesta"),
      content: Text(msm),
    );
  }*/
}


