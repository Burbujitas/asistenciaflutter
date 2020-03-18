import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wallet_app/src/models/factura_model.dart';
import 'package:wallet_app/src/pages/form_factura.dart';
import 'package:wallet_app/src/providers/menu_provider.dart';

class MenuPage extends StatelessWidget {

  final FacturaModel facturaModel = new FacturaModel(gasto: 'Alimentación',total: 0.0,igv: 0.0, fecha_scaneo: DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lector QR'),
        leading: GestureDetector(
          onTap: () {},
          child: Icon(
            Icons.menu
          ),
        ),
      ),
      body: FutureBuilder(
        future: menuProvider.cargarData(),
        initialData: [],
        builder: ( context, AsyncSnapshot<List<dynamic>> snapshot) {
          if( snapshot.hasData ) {
            return GridView.count(
              primary: true,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 40,
              crossAxisCount: 2,
              children: _listaMenu( snapshot.data, context ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ) 
    );
  }

  List<Widget> _listaMenu ( List<dynamic> data, BuildContext context ) {
    final List<Widget> opciones = [];
    data.forEach( (opt)  {
      final widgetTemp = Column(
        children: <Widget>[
          Card(
            elevation: 5.0,
            child: InkWell(
              child: Image(
                image: AssetImage(opt['image']),
                height: 140.0,
                fit: BoxFit.fill,
              ),
              onTap: () {
                funcionesMenu( opt['funcion'], context );
              },
            )
          ),
          Text(
            opt['texto']
          )
        ],
      );
       
      opciones..add(widgetTemp);
    });
    return opciones;
  }

  void funcionesMenu( String funcion, BuildContext context ){
    if( funcion == "facturaQR") {
      print(' Con QR ');
      facturaQR(context);
    } else if( funcion == "facturaSinQR") {
      print(' Sin QR ');
      facturaSinQR(context);
    } else {
      print(' En Desarrollo ');
    }
  }

  facturaQR(BuildContext context) async {
    String cadena = '';
    try {
      cadena = await BarcodeScanner.scan();
      if( cadena != '' && cadena != null ) {
        print(cadena);
        llenarModelo(cadena);
        Navigator.pushNamed(
          context,
          FormFacturaPage.routeName,
          arguments: facturaModel
        );
      }
    } catch ( e ) {
      cadena = e.toString();
      
    }
    print(cadena);
  }

  void facturaSinQR(BuildContext context) {
    FacturaModel factura = new FacturaModel(gasto: 'Alimentación',total: 0.0,igv: 0.0,fecha_emision: DateTime.now(), fecha_scaneo: DateTime.now());
    Navigator.pushNamed(
      context,
      FormFacturaPage.routeName,
      arguments: factura
    );
  }

  void llenarModelo(String cadena) {
    var formatter = new DateFormat('yyyy-MM-dd');
    var ldatos = cadena.split('|');
    facturaModel.ruc_emisor = ldatos[0];
    facturaModel.serie = ldatos[2];
    facturaModel.numero = ldatos[3];
    facturaModel.igv = double.parse(ldatos[4]);
    facturaModel.total = double.parse(ldatos[5]);
    facturaModel.fecha_emision =  DateTime.parse(formatter.format(DateTime.parse(ldatos[6])));
  } 

}