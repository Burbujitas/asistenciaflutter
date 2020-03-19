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
    guardartoken(dni, _prefs.celtoken);

    //return true;
    return { 'ok': true, 'token':decodedResp['token'] };
  }else{

  //  return false;
        return { 'ok': false, 'message':'no hay token' };
  }
  
  
}

Future<bool> guardartoken(String dni,String token) async{
final resp = await http.put(
    'https://api-rendiciones.herokuapp.com/tokencelular',
    body: { 'dni':dni,'token':token}
    ,
    headers: {'authorization': _prefs.token}
  );
final decodedResp = json.decode(resp.body);
if(decodedResp.containsKey('Status')=='Actualizacion exitosa'){
  return true;
}else{
  return false;
}

}

}

