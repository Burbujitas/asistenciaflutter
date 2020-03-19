import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wallet_app/src/models/factura_model.dart';
import 'package:wallet_app/src/pages/menu//form_factura.dart';
import 'package:wallet_app/src/pages/requerimiento/menu_requerimiento.dart';
import 'package:wallet_app/src/providers/menu_provider.dart';

final Color backgroundColor = Color.fromRGBO(75, 209, 255, 1);

class MenuPage extends StatefulWidget {

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final FacturaModel facturaModel = new FacturaModel(gasto: 'Alimentación',total: 0.0,igv: 0.0, fecha_scaneo: DateTime.now());
  bool isCollapsed = true;
  double screenWidth, screenHeigh;
  String tittle = 'Menú';
  final Duration duration = const Duration(milliseconds: 300);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeigh = size.height;
    screenWidth = size.width;
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 154, 174, 1.0),
      // appBar: AppBar(
      //   title: Text('Lector QR'),
      //   leading: GestureDetector(
      //     onTap: () {},
      //     child: Icon(
      //       Icons.menu
      //     ),
      //   ),
      // ),
      body: Stack(
        children: <Widget>[
          menu(context),
          dashboard(context),
        ],
      )
    );
  }

  

  List<Widget> _listaMenu ( List<dynamic> data, BuildContext context ) {
    final List<Widget> opciones = [];
    data.forEach( (opt)  {
      final widgetTemp = SingleChildScrollView(
      
        child: Column(
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(600.0),
              ),
              elevation: 6.0,
              child: InkWell(
                child: Image(
                  image: AssetImage(opt['image']),
                  height: 132.0,
                  fit: BoxFit.fill,
                ),
                onTap: () {
                  funcionesMenu( opt['funcion'], context );
                },
              )
            ),
            Text(
              opt['texto'],
            )
          ],
        )
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

  menu(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          
          mainAxisSize: MainAxisSize.max,
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 100),
            imagenUsuario('assets/dp.jpg','Pedro Navaja'),
            SizedBox(height: 130),
            //Text("Menu", style: TextStyle(color: Colors.white, fontSize: 20)),
            menuOptions(Icons.dashboard, 'Menú'),
            SizedBox(height: 20),
            menuOptions(Icons.card_travel, "Solicitar Requerimiento"),
            SizedBox(height: 20),
            menuOptions(Icons.library_books, "Facturas Emitas"),
          ],
        ),
      ),
    );
  }

  menuOptions(icon, text) {
    return Row(
      children: <Widget>[
        Icon(icon, color: Colors.white),
        InkWell(
          child: RichText(
            text: TextSpan(
              text: text,
              style: TextStyle(color: Colors.white, fontSize: 15.0)
            )
          ),
          onTap: () {
            print(text);
            setState(() {
              tittle = text;
              //escogerBody(text);
            });
          },
        ),      
      ],
    );
  }

  dashboard(BuildContext context) {
    return AnimatedPositioned(
      duration: duration,
      top: isCollapsed ? 0 : 0.1 * screenHeigh,
      bottom: isCollapsed ? 0 :  0.1 * screenWidth,
      left: isCollapsed ? 0 :  0.6 * screenWidth,
      right: isCollapsed ? 0 :  -0.4 * screenWidth,
      child: Material(
        animationDuration: duration,
        borderRadius: BorderRadius.all(Radius.circular(40)),
        elevation: 8,
        color: backgroundColor,
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  InkWell(
                    child: Icon(Icons.menu, color: Colors.white),
                    onTap: () {
                      setState(() {
                        isCollapsed = !isCollapsed;
                      });
                    },
                  ),
                  Text(tittle,style: TextStyle(fontSize: 24, color: Colors.white)),
                  Icon(Icons.settings, color: Colors.white),
                ],
              ),
              Expanded(
                child: escogerBody(),
              )
            ],
          ),
        ),
      ),
    );
  }

  imagenUsuario(String s,String name) {
    return Column(
      children: <Widget>[
        Container(
          width: 100.0,
          height: 100.0,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(s)
            )
          ),
        ),
        SizedBox(height: 10.0),
        Text(name,style: TextStyle(color: Colors.white, fontSize: 20.0),),
      ],
    );
  }

  menuCards() {
        return FutureBuilder(
          future: menuProvider.cargarData("opciones"),
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
        );
  }

  escogerBody() {
    var widget;
    if(tittle == 'Menú'){
      widget = menuCards();
    } else if (tittle == 'Solicitar Requerimiento') {
      widget = menuCardRequerimiento();
    }
    setState(() { 
      
    });
    return widget;
  } 
}