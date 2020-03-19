import 'package:flutter/material.dart';
import 'package:wallet_app/src/pages/requerimiento/form_requerimiento_vuelo.dart';
import 'package:wallet_app/src/providers/menu_provider.dart';
import 'package:wallet_app/src/utils/notificaciones_util.dart' as util;

menuCardRequerimiento() {
return FutureBuilder(
  future: menuProvider.cargarData("opcionesRequerimiento"),
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
            elevation: 5.0,
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
  if( funcion == "requerimientoVuelo") {
    requerimientoVuelo(context);
  } else if( funcion == "requerimientoCompra") {
    
    requerimientoCompra(context);
  } else {
    print('GG');
  }
}

void requerimientoCompra(BuildContext context) {
  util.mostraralerta(context , 'En desarrollo' , "Estamos trabajando en ello");
}

void requerimientoVuelo(BuildContext context) {
  Navigator.pushNamed(
    context,
    FormRequerimientoVueloPage.routeName
  );
}