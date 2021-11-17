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
          
          DataTable(columns: const <DataColumn> [
            DataColumn(label: Text('Nombre', textAlign: TextAlign.left)),
            DataColumn(label: Text('Cod Produc.',textAlign: TextAlign.left)),
            DataColumn(label: Text ('Cod Cliente', textAlign: TextAlign.left)),
            DataColumn(label: Text('Precio', textAlign: TextAlign.left))

          ],
          rows: const<DataRow>[
            DataRow(cells: <DataCell> [
              DataCell(Text('Lapices',textAlign: TextAlign.left)),
              DataCell(Text('0014',textAlign: TextAlign.left)),
              DataCell(Text('003',textAlign: TextAlign.left)),
              DataCell(Text('100.000',textAlign: TextAlign.left))
            ]),
             DataRow(cells: <DataCell> [
              DataCell(Text('Cuadernos',textAlign: TextAlign.left)),
              DataCell(Text('0015',textAlign: TextAlign.left)),
              DataCell(Text('123',textAlign: TextAlign.left)),
              DataCell(Text('200.000',textAlign: TextAlign.left))
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('Uniformes',textAlign: TextAlign.left)),
              DataCell(Text('0013',textAlign: TextAlign.left)),
              DataCell(Text('4243',textAlign: TextAlign.left)),
              DataCell(Text('200.000',textAlign: TextAlign.left))
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('Libros',textAlign: TextAlign.left)),
              DataCell(Text('0016',textAlign: TextAlign.left)),
              DataCell(Text('5000',textAlign: TextAlign.left)),
              DataCell(Text('300.000',textAlign: TextAlign.left))
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


