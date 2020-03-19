import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wallet_app/src/preferencias_usuario/preferencias_usuario.dart';

 class NotiProvider{
   final _prefs = new PreferenciasUsuario();

Future<dynamic> buscarusuarios(String dni) async{
  final url = 'https://api-rendiciones.herokuapp.com/buscarjefe/$dni';
  
  final resp= await http.get(url, headers: {'authorization': _prefs.token});

  final decodedData = json.decode(resp.body);

  
    

    
    if(decodedData.containsKey('usuario_dni_jefe')){
final dnijefe = decodedData['usuario_dni_jefe'];

    final usnombre = decodedData['usuario_nombre']+' '+decodedData['usuario_apellido'];
    encontrarnoti(dnijefe, usnombre);
    }
  
}


Future<dynamic> encontrarnoti(String dni, usunombre) async{
final url = 'https://api-rendiciones.herokuapp.com/token/$dni';

final resp = await http.get(url,headers: {'authorization': _prefs.token});
    final decodedData = json.decode(resp.body);

  decodedData.forEach((dni){
         print(dni);
         
         if(dni.containsKey('token')){
    
          mandarnoti(dni['token'],'Asistencia', 'El trabajador $usunombre llego a trabajar');
         }
        
        
       });

   

}


Future<bool> mandarnoti(String token,String titulo,String mensaje) async{

  final url='https://rendiciones-noti.herokuapp.com/api/send';

 final resp = await http.post(url,body: { 'token':token,
                        'title':titulo,
                        'body':mensaje});

print('funciono');
  return true;
}

 }
