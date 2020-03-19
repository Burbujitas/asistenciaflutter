import 'dart:async';

import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:wallet_app/src/preferencias_usuario/preferencias_usuario.dart';

class PushNotificationProvider{

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

final _mensajesStreamController = StreamController<String>.broadcast();
PreferenciasUsuario _prefs=new PreferenciasUsuario();

Stream<String> get mensajes =>_mensajesStreamController.stream;

  initNotifications(){
    _firebaseMessaging.requestNotificationPermissions();

    _firebaseMessaging.getToken().then( (token){
      print('===== FCM Token =====');
      print(token);
      _prefs.celtoken=token;

    });

_firebaseMessaging.configure(

onMessage: (ms) async {

print('onMessage');
print(ms);

//_mensajesStreamController.sink.add(event);
},
onLaunch: (ms) async {

print('onLaunch');
print(ms);

},
onResume: (ms) async {
  
print('onResume');
print(ms);
}

);

  }


dispose(){
  _mensajesStreamController?.close();
}

}