import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wallet_app/src/preferencias_usuario/preferencias_usuario.dart';

 class NotiProvider{
   final _prefs = new PreferenciasUsuario();
Future<dynamic> encontrarnoti(String dni) async{
final url = 'https://api-rendiciones.herokuapp.com/token/11111111';

final resp = await http.get(url,headers: {'authorization': _prefs.token});
    final decodedData = json.decode(resp.body);

  decodedData.forEach((dni){
         print(dni);
         
         if(dni.containsKey('token')){
      final hola = dni['usuario_nombre']; 

           print('funciona ${hola}');
          mandarnoti(dni['token'],'Asistencia', 'El trabajador Fernando llego al trabajar');
         }
        
        
       });

   

}


Future<bool> mandarnoti(String token,String titulo,String mensaje) async{

  final url='https://rendiciones-noti.herokuapp.com/api/send';

 final resp = await http.post(url,body: { 'token':token,
                        'title':titulo,
                        'body':mensaje});


  return true;
}

 }
