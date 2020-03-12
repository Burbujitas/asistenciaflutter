import 'package:flutter/material.dart';
import 'package:wallet_app/src/models/rendiciones_model.dart';
import 'package:wallet_app/src/providers/rendiciones.dart';

class HomePage extends StatelessWidget {
  
 final rendicionesProvider = new RendicionesProvider();

 
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        
         appBar: AppBar(
           
          title: Text('Pruebas'),
         ),
        body: _crearList(),
      );
  }


  Widget _crearList(){
 return FutureBuilder(
   future: rendicionesProvider.cargarrendiciones(),

   builder: (BuildContext context, AsyncSnapshot<List<RendicionModel>> snapshot) {
     if(snapshot.hasData ){
       final rendici= snapshot.data;

       return ListView.builder(
         itemCount: rendici.length,
         itemBuilder: (context, i){

           return _crearvista(context, rendici[i]);

         },);
     }else{
       return Center( child: CircularProgressIndicator());
     }
   },
 );
}
  Widget _crearvista(BuildContext context,RendicionModel rendi){


                          return Column(
                            
                                  
                          children:<Widget>[ InkWell(
                            onTap: (){ 
                              rendicionesProvider.cargarrequerimientos(rendi.numeroreq);
                              Navigator.pushNamed(context, 'login',arguments: rendi);
                              print('${rendi.numeroreq}');},
                                                      child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 16),
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          borderRadius: BorderRadius.all(Radius.circular(18))
                                      ),
                                      child: Icon(Icons.person, color: Colors.lightBlue[900],),
                                      padding: EdgeInsets.all(12),
                                    ),

                                    SizedBox(width: 16,),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(rendi.dni, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.grey[900]),),
                                          Text(rendi.nombre, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.grey[500]),),
                                        ],
                                      ),
                                    ),

                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text("+\$ ${rendi.gasto_actual}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.lightGreen),),
                                        Text(rendi.motivo, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.grey[500]),),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                          ),

                                ]

                          );

  }
}