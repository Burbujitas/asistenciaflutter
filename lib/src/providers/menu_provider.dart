import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class _MenuProvider {
  List<dynamic> opciones = [];

  _MenuProvider() {}

  Future<List<dynamic>> cargarData(String opcion) async {
    final resp = await rootBundle.loadString('data/menu_opts.json');
    Map dataMap = json.decode( resp );
    opciones = dataMap[opcion];
    return opciones;
  }

}

final menuProvider = _MenuProvider();