import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wallet_app/src/preferencias_usuario/preferencias_usuario.dart';

class UsuarioProvider {


final _prefs = new PreferenciasUsuario();

Future<dynamic> login(String dni, String password) async{
 
  final resp = await http.post(
    'https://api-rendiciones.herokuapp.com/api/login/$dni/$password',
   
    headers: { "Content-Type":"application/json"}
  );

  final decodedResp = json.decode(resp.body);

  if(decodedResp.containsKey('token'))
  {
    _prefs.token = decodedResp['token'];

    //return true;
    return { 'ok': true, 'token':decodedResp['token'] };
  }else{

  //  return false;
        return { 'ok': false, 'message':'no hay token' };
  }
  
  
}
}

