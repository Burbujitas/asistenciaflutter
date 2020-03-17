import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wallet_app/src/models/rendiciones_model.dart';
import 'package:wallet_app/src/models/requerimiento_model.dart';
import 'package:wallet_app/src/preferencias_usuario/preferencias_usuario.dart';

import '../models/rendiciones_model.dart';

class RendicionesProvider{
final _prefs = new PreferenciasUsuario();
  Future<List<RendicionModel>> cargarrendiciones() async {

      final url = 'https://api-rendiciones.herokuapp.com/estado/2/4';
      final resp = await http.get(url,headers: {'authorization': _prefs.token});
      final decodedData = json.decode(resp.body);
      final List<RendicionModel>rendi = new List();  
       if(decodedData==null) return [];
      //if(decodedData["success"]==false) return [];
       decodedData.forEach((dni){
         print(dni);
         final prodTemp =  RendicionModel.fromJson(dni);
         
         rendi.add(prodTemp);
        
       });

        
return rendi;
      
  }


  Future<List<RequerimientoModel>> cargarrequerimientos(int requerimiento) async{
    final url = 'https://api-rendiciones.herokuapp.com/requerimiento/$requerimiento';
    final resp = await http.get(url,headers: {'authorization': _prefs.token});
    final decodedData = json.decode(resp.body);
      final List<RequerimientoModel>rendi = new List();  
      print(decodedData);
       if(decodedData==null) return [];

       decodedData.forEach((dni){
         print(dni);
         final prodTemp =  RequerimientoModel.fromJson(dni);
         
         rendi.add(prodTemp);
        
       });

        
return rendi;
  }

}