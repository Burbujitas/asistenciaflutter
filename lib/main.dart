import 'package:flutter/material.dart';
import 'package:wallet_app/CardScreen.dart';
import 'package:wallet_app/src/pages/HomePage.dart';
import 'package:wallet_app/src/pages/menu/form_factura.dart';
import 'package:wallet_app/src/pages/menu/menu.dart';
import 'package:wallet_app/src/pages/requerimiento/form_requerimiento_vuelo.dart';
import 'package:wallet_app/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:wallet_app/src/providers/push_notifications_provider.dart';
import 'package:wallet_app/src/pages/qr_notificacion.dart';

import 'HomeScreen.dart';
 
void main() async{
  runApp(MyApp());
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();

} 
 
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 @override
  void initState() { 
    super.initState();
    final pushNotificationProvider= new PushNotificationProvider();    
    pushNotificationProvider.initNotifications();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'login',
        routes: {
          'screen'      : ( BuildContext context ) => HomeScreen(),
          'home'        : ( BuildContext context ) => HomePage(),
          'login'       : ( BuildContext context ) => PasarLogin(),
          'menu'        : ( BuildContext context ) => MenuPage(),
          'qrnoti'      : ( BuildContext context ) =>QRNOTI(),
          FormFacturaPage.routeName: ( BuildContext context ) => FormFacturaPage(),
          FormRequerimientoVueloPage.routeName: ( BuildContext context ) => FormRequerimientoVueloPage(),
        },
        theme: ThemeData(
          primaryColor: Color.fromRGBO(0, 154, 174, 1.0)
          
        ),
      );
    
  }
}
//  import 'package:wallet_app/CardScreen.dart';
//  import 'package:flutter/material.dart';
//  import 'package:wallet_app/HomeScreen.dart';
//  void main() => runApp(MyApp());
//  class MyApp extends StatelessWidget {
//    // This widget is the root of your application.
//    @override
//    Widget build(BuildContext context) {
//      return MaterialApp(
//        title: 'Flutter Demo',
//        theme: ThemeData(
//          // This is the theme of your application.
//          //
//          // Try running your application with "flutter run". You'll see the
//          // application has a blue toolbar. Then, without quitting the app, try
//          // changing the primarySwatch below to Colors.green and then invoke
//          // "hot reload" (press "r" in the console where you ran "flutter run",
//          // or simply save your changes to "hot reload" in a Flutter IDE).
//          // Notice that the counter didn't reset back to zero; the application
//          // is not restarted.
//          primarySwatch: Colors.blue,
//        ),
//        home: WalletApp(),
//        debugShowCheckedModeBanner: false,
//      );
//    }
//  }
//  class WalletApp extends StatefulWidget {
//    @override
//    _WalletAppState createState() => _WalletAppState();
//  }
//  class _WalletAppState extends State<WalletApp> {
//    var screens = [
//      HomeScreen(),
//      CardScreen(),
//    ]; //screens for each tab
//    int selectedTab = 0;
//    @override
//    Widget build(BuildContext context) {
//      return Scaffold(
//        backgroundColor: Color.fromRGBO(38, 81, 158, 1),
//        bottomNavigationBar: BottomNavigationBar(
//          items: [
//            BottomNavigationBarItem(
//              icon: Icon(Icons.home),
//              title: Text("Home")
//            ),
//            BottomNavigationBarItem(
//                icon: Icon(Icons.credit_card),
//                title: Text("Card")
//            ),
//          ],
//          onTap: (index){
//            setState(() {
//              selectedTab = index;
//            });
//          },
//          showUnselectedLabels: true,
//          iconSize: 30,
//        ),
//        floatingActionButton: FloatingActionButton(
//          onPressed: (){},
//          elevation: 0,
//          child: Icon(Icons.add),
//        ),
//        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//        body: screens[selectedTab],
//      );
//    }
//  }
