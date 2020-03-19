import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:wallet_app/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:wallet_app/src/providers/notificacion_provider.dart';


class QRNOTI extends StatefulWidget {
   int currentIndex =0;
  @override
  _QRNOTIState createState() => _QRNOTIState();
}

class _QRNOTIState extends State<QRNOTI> {
  PreferenciasUsuario _prefs = new PreferenciasUsuario();
  NotiProvider pro = new NotiProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.delete_forever), onPressed: (){})
        ],
      ),
      body: Center(
        child: Text('home qr'),
      ),
      bottomNavigationBar: _crearBottomNavigationBar(),
     floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
     
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: _scanQR,
           backgroundColor: Theme.of(context).primaryColor,
        ),
     
    );
  }

_scanQR() async{
  String futureString = '';

  try {
    futureString = await BarcodeScanner.scan();
    if(futureString!=null){
      pro.buscarusuarios(_prefs.dni);
     // pro.mandarnoti('Asistencia', 'El trabajador nombre asistio');
      print('dsaas');
    }
  } catch (e) {
    futureString = e.toString();
  }
}


Widget _crearBottomNavigationBar() {
return BottomNavigationBar(
currentIndex: 0,
onTap: ( index ){},
items: [
BottomNavigationBarItem(
icon: Icon(Icons.map),
title: Text('Mapas')
),
BottomNavigationBarItem(
  icon: Icon(Icons.brightness_5),
  title: Text('Direcciones')
  )
]
);
}
}