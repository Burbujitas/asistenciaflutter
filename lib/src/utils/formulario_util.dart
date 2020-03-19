import 'package:flutter/material.dart';


Widget formItemsDesign(IconData icon, Widget item) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 10.0), 
      child: Card(
        elevation: 4.0,
        child: ListTile(
          leading: Icon(icon, color: Color.fromRGBO(0, 154, 174, 1.0)),
          title: item,
          contentPadding: EdgeInsets.only(left: 20.0 ,bottom: 7.0, right: 30.0),
        )
      ),
    );
}