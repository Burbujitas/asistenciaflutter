import 'dart:io';

import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:wallet_app/src/models/factura_model.dart';
import 'package:wallet_app/src/utils/notificaciones_util.dart' as util;
import 'package:wallet_app/src/utils/formulario_util.dart' as f;

class FormFacturaPage extends StatefulWidget {
  static const routeName = '/formulario_factura';
  FormFacturaPage({Key key}) : super(key: key);

  @override
  _FormFacturaPageState createState() => _FormFacturaPageState();
}

class _FormFacturaPageState extends State<FormFacturaPage> {

  final _formKey = GlobalKey<FormState>();
  final format = DateFormat("dd-MM-yyyy");
  int _radioValue1 = -1;
  String dropdownValue = 'Alimentación';
  File foto;
  var fotoTomada = Icons.camera_alt;
  var colorCamara = Color.fromRGBO(0, 154, 174, 1.0);
  //Inicializando
  FacturaModel facturaModel = new FacturaModel();
  
  @override
  Widget build(BuildContext context) {
    facturaModel = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Información Factura'),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            children: formUI(context),
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(fotoTomada),
        onPressed: _tomarFoto,
        backgroundColor: colorCamara
        
      ),
    );
  }

  List<Widget> formUI(BuildContext context) {
    List<Widget> lwidget = [];
    final widgetTemp = Column(
      children: listaFormulario(context),
    );
    lwidget..add(widgetTemp);
    return lwidget;
  }

  // Widget f.formItemsDesign(IconData icon, Widget item) {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 10.0), 
  //     child: Card(
  //       elevation: 4.0,
  //       child: ListTile(
  //         leading: Icon(icon),
  //         title: item,
  //         contentPadding: EdgeInsets.only(left: 20.0 ,bottom: 7.0, right: 30.0),
  //       )
  //     ),
  //   );
  // }

  List<Widget> listaFormulario(BuildContext context) {
    
    List<Widget> lista = [];
    //RUC
    final formRuc = f.formItemsDesign(
      Icons.person,
      TextFormField(
        initialValue: facturaModel.ruc_emisor,
        decoration: new InputDecoration(
          labelText: 'Ruc',
          contentPadding: const EdgeInsets.all(10.0),
        ),
        keyboardType: TextInputType.number,
        onChanged: (value) => facturaModel.ruc_emisor = value,
      )
    );
    //SERIE
    final formSerie = f.formItemsDesign(
      Icons.person_add,
      TextFormField(
        initialValue: facturaModel.serie,
        decoration: new InputDecoration(
          labelText: 'Serie',
          contentPadding: const EdgeInsets.all(10.0),
        ),
        onChanged: (value) => facturaModel.serie = value,
      ),
    );
    //NÚMERO
    final formNumeroSerie = f.formItemsDesign(
      Icons.person_add,
      TextFormField(
        initialValue: facturaModel.numero,
        decoration: new InputDecoration(
          labelText: 'Número Serie',
          contentPadding: const EdgeInsets.all(10.0),
        ),
        onChanged: (value) => facturaModel.numero = value,
      ),
      
    );
    //MONTO
    final formMonto = f.formItemsDesign(
      Icons.attach_money,
      TextFormField(
        initialValue: facturaModel.total.toString(),
        decoration: new InputDecoration(
          labelText: 'Total',
          contentPadding: const EdgeInsets.all(10.0),
        ),
        keyboardType: TextInputType.number,
        onChanged: (value) => facturaModel.total = double.parse(value),
      )
    );
    //IGV
    final formIgv = f.formItemsDesign(
      Icons.attach_money,
      TextFormField(
        initialValue: facturaModel.igv.toString(),
        decoration: new InputDecoration(
          labelText: 'IGV',
          contentPadding: const EdgeInsets.all(10.0),
        ),
        keyboardType: TextInputType.number,
        onChanged: (value) => facturaModel.igv = double.parse(value),
      )
    );
    //FECHA
    final formFecha = f.formItemsDesign(
      Icons.calendar_today,
      DateTimeField(
        initialValue: facturaModel.fecha_emision,
        format: format,
        decoration: const InputDecoration(
          labelText: 'Fecha'
        ),
        onShowPicker: (context, currentValue) {
          return showDatePicker(
            context: context,
            initialDate: currentValue ?? DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100)
          );
        },
        onChanged: (value) => facturaModel.fecha_emision = value,
      )
    );
    //MONEDA
    final formMoneda = f.formItemsDesign(
      null,
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Radio(         
            value: 0,
            groupValue: _radioValue1,
            onChanged: _handleRadioValueChange1,
            autofocus: true,
            activeColor: Color.fromRGBO(0, 154, 174, 1.0),
          ),
          Text(
            'Soles',
            style: TextStyle(fontSize: 16.0)
          ),
          Radio(         
            value: 1,
            groupValue: _radioValue1,
            onChanged: _handleRadioValueChange1,
            autofocus: false,
            activeColor: Color.fromRGBO(0, 154, 174, 1.0),
          ),
          Text(
            'Dólares',
            style: TextStyle(fontSize: 16.0)
          )
        ],
      )
    );
    //CATEGORÍA
    final formCategoria = f.formItemsDesign(
      Icons.info,
      Container(
        width: 300,
        child: DropdownButton<String>(
          value: dropdownValue,
          onChanged: (String newValue) {
            dropdownValue = newValue;
            setState(() {
              facturaModel.gasto = dropdownValue;
            });
          },
          iconSize: 30,
          underline: Container(
            height: 1,
            color: Colors.black38,
          ),
          items: <String>['Alimentación', 'Combustible', 'Hospedaje', 'Otros']
                .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
        ),
      )
    );
    //BOTON
    final formButton =  Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: MaterialButton(
        minWidth: 200.0,
        height: 40.0,
        onPressed: () {
          if (_formKey.currentState.validate()) {
            facturaModel.monto = facturaModel.total - facturaModel.igv;
            print(facturaModel.toJson());
            util.mostraralerta(context , 'Registro Exitoso' , "La factura con número ${facturaModel.serie} - ${ facturaModel.numero }");
        
            //facturaProvider.subirFirebase(foto);
          }
        },
        color: Color.fromRGBO(0, 154, 174, 1.0),
        child: Text('Enviar',style: TextStyle(color: Colors.white)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      )
    );

    lista..add(formRuc)
         ..add(formSerie)
         ..add(formNumeroSerie)
         ..add(formMonto)
         ..add(formIgv)
         ..add(formFecha)
         ..add(formCategoria)
         ..add(formMoneda)
         ..add(formButton);
    return lista;
  }

  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;

      switch (_radioValue1) {
        case 0:
          facturaModel.moneda = 'Soles';
          print(facturaModel.moneda);
          break;
        case 1:
          facturaModel.moneda = 'Dólares';
          print(facturaModel.moneda);
          break;
        case 2:
          print('Try again!');
          break;
      }
    });
  }

  _tomarFoto() async {
    foto = await ImagePicker.pickImage(
      source: ImageSource.camera
    );

    setState(() {
      fotoTomada = Icons.check_circle;
      //colorCamara = Color.fromRGBO(255, 204, 50, 1.0);
      colorCamara = Color.fromRGBO(77, 208, 255, 1.0);
    });
  }
}