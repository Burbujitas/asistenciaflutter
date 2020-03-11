import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wallet_app/src/models/rendiciones_model.dart';

class RendicionesProvider{

  Future<List<RendicionModel>> cargarrendiciones() async {

      final url = 'https://api-rendiciones.herokuapp.com/estado/2/4';
      final resp = await http.get(url);
      final List<dynamic>decodedData = json.decode(resp.body);
      final List<RendicionModel>rendi = new List();  
       if(decodedData==null) return [];

       decodedData.forEach((dni){
         print(dni);
         final prodTemp =  RendicionModel.fromJson(dni);
         
         rendi.add(prodTemp);
        
       });

        print(rendi[1].fecha_inicio);
return rendi;
      
  }

}