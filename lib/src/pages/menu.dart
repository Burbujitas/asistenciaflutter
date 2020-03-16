import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:wallet_app/src/providers/menu_provider.dart';

class MenuPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lector QR'),
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
      facturaQR();
    } else if( funcion == "facturaSinQR") {
      print(' Sin QR ');
      facturaSinQR(context);
    } else {
      print(' En Desarrollo ');
    }
  }


  facturaQR() async {
    BuildContext context;
    String cadena = '';
    try {
      cadena = await BarcodeScanner.scan();
      if( cadena != '' && cadena != null ) {
        print(cadena);
        Navigator.pushNamed(context, 'formulario');
      }
    } catch ( e ) {
      cadena = e.toString();
    }
  }

  void facturaSinQR(BuildContext context) {
    Navigator.pushNamed(context, 'formulario');
  }

  

}