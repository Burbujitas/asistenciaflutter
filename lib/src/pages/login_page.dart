import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallet_app/src/models/usuario_model.dart';
import 'package:wallet_app/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:wallet_app/src/providers/usuario_provider.dart';

class SignInOne extends StatelessWidget {
  final _prefs = new PreferenciasUsuario();
  UserModel cre= new UserModel();
  UsuarioProvider usu = new UsuarioProvider();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image1.png'),
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter
            )
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 270),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.all(23),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Container(
                    color: Color(0xfff5f5f5),
                    child: TextFormField(
                      style: TextStyle(
                        color: Colors.cyan,
                        fontFamily: 'SFUIDisplay'
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Usuario',
                        prefixIcon: Icon(Icons.person_outline),
                        labelStyle: TextStyle(
                          fontSize: 15
                        )
                      ),
                      onChanged:(value) { cre.usuario=value;},
                    ),
                  ),
                ),
                Container(
                  color: Color(0xfff5f5f5),
                  child: TextFormField(
                    obscureText: true,
                    style: TextStyle(
                      color: Colors.cyan,
                      fontFamily: 'SFUIDisplay'
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Contraseña',
                      prefixIcon: Icon(Icons.lock_outline),
                      labelStyle: TextStyle(
                          fontSize: 15
                        )
                    ),
                    onChanged: (value){ cre.password=value;}
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: MaterialButton(
                    onPressed: () async{ 
                      //'45845677'
                      if(cre.usuario==null){
                            _mostraralerta( context,'Ingrese un dni' );
                      }else{
                        if(cre.password==null){
                            _mostraralerta( context,'Ingrese una contraseña' );
                        }else{
                       final hola= await usu.login(cre.usuario, cre.password);
                    print('asdasd');
                  print(hola);
                   
                    if(_prefs.token!=""){
                         Navigator.pushNamed(context, 'qrnoti');//since this is only a UI app
                    }
                    else {
                      _mostraralerta( context,'Ingrese un dni o contraseña correcta' );
                    } 
                        }
                          
                      }
                  
                     },
                    child: Text('INGRESA',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'SFUIDisplay',
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                    color: Color(0xff009aaf),
                    elevation: 0,
                    minWidth: 400,
                    height: 50,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Center(
                    child: Text('¿Olvidaste tu contraseña?',
                    style: TextStyle(
                      fontFamily: 'SFUIDisplay',
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "¿No tienes una cuenta?",
                            style: TextStyle(
                              fontFamily: 'SFUIDisplay',
                              color: Colors.black,
                              fontSize: 15,
                            )
                          ),
                          TextSpan(
                            text: "regístrate",
                            style: TextStyle(
                              fontFamily: 'SFUIDisplay',
                              color: Color(0xff009aaf),
                              fontSize: 15,
                            )
                          )
                        ]
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
    _mostraralerta(BuildContext context, String mensaje){
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Datos incorrectos'),
            content: Text(mensaje),       
            actions: <Widget>[
              FlatButton(onPressed: ()=> Navigator.of(context).pop(), child: Text('Ok'))
            ], 
          );
        }
    );
  }

  
}