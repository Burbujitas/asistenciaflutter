import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wallet_app/src/models/requerimiento_vuelo.dart';
import 'package:wallet_app/src/utils/formulario_util.dart' as f;
import 'package:wallet_app/src/utils/notificaciones_util.dart' as util;

class FormRequerimientoVueloPage extends StatefulWidget {
  static const routeName = '/formulario_requerimiento_vuelo';
  FormRequerimientoVueloPage({Key key}) : super(key: key);

  @override
  _FormRequerimientoVueloPageState createState() => _FormRequerimientoVueloPageState();
}

class _FormRequerimientoVueloPageState extends State<FormRequerimientoVueloPage> {
  final _formKey = GlobalKey<FormState>();
  final format = DateFormat("dd-MM-yyyy");
  RequerimientoVueloModel requerimiento = new RequerimientoVueloModel(estadoRequerimientoId: 1, usuarioDni: '70976447', requerimientoFecha: DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Solicitar Requerimiento'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 11.0),
            child: InkWell(
              child: Icon(Icons.info),
              onTap: () {
                util.mostraralerta(context, "Infomación", "Toda esta información es de un solo día de viaje");
              },
            ),
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            children: formUI(context),
          ),
        ),
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

  List<Widget> listaFormulario(BuildContext context) {

    List<Widget> lista = [];
    //FEHCA INICIO
    final formFechaInicio = f.formItemsDesign(
      Icons.calendar_today,
      DateTimeField(
        format: format,
        decoration: const InputDecoration(
          labelText: 'Fecha Inicio'
        ),
        onShowPicker: (context, currentValue) {
          return showDatePicker(
            context: context,
            initialDate: currentValue ?? DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100)
          );
        },
        onChanged: (value) => requerimiento.requerimientoFechaInicio = value,
      )
    );
    //FECHA FIN
    final formFechaFin = f.formItemsDesign(
      Icons.calendar_today,
      DateTimeField(
        format: format,
        decoration: const InputDecoration(
          labelText: 'Fecha Fin'
        ),
        onShowPicker: (context, currentValue) {
          return showDatePicker(
            context: context,
            initialDate: currentValue ?? DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100)
          );
        },
        onChanged: (value) => requerimiento.requerimientoFechaFin = value,
      )
    );
    //MONTO BOLETO-
    final formMontoViaje = f.formItemsDesign(
      Icons.flight,
      TextFormField(
        decoration: new InputDecoration(
          labelText: 'Monto de Viaje',
          contentPadding: const EdgeInsets.all(10.0),
        ),
        onChanged: (value) => requerimiento.requerimientoBoleto = double.parse(value),
        keyboardType: TextInputType.number,
      )
    );
    //MONTO ALIMENTO
    final formMontoAlimento = f.formItemsDesign(
      Icons.restaurant,
      TextFormField(
        decoration: new InputDecoration(
          labelText: 'Monto de Alimento',
          contentPadding: const EdgeInsets.all(10.0),
        ),
        onChanged: (value) => requerimiento.requerimientoAlimento = double.parse(value),
        keyboardType: TextInputType.number,
      )
    );
    //MONTO HOSPEDAJE
    final formMontoHospedaje = f.formItemsDesign(
      Icons.hotel,
      TextFormField(
        decoration: new InputDecoration(
          labelText: 'Monto de Hospedaje',
          contentPadding: const EdgeInsets.all(10.0),
        ),
        onChanged: (value) => requerimiento.requerimientoHospedaje = double.parse(value),
        keyboardType: TextInputType.number,
      )
    );
    //MONTO MOVILIDAD
    final formMontoMovilidad = f.formItemsDesign(
      Icons.local_taxi,
      TextFormField(
        decoration: new InputDecoration(
          labelText: 'Monto de Movilidad',
          contentPadding: const EdgeInsets.all(10.0),
        ),
        onChanged: (value) => requerimiento.requerimientoMovilidad = double.parse(value),
        keyboardType: TextInputType.number,
      )
    );
    //MONTO OTROS
    final formMontoOtros = f.formItemsDesign(
      Icons.local_mall,
      TextFormField(
        decoration: new InputDecoration(
          labelText: 'Otros',
          contentPadding: const EdgeInsets.all(10.0),
        ),
        onChanged: (value) => requerimiento.requerimientoOtro = double.parse(value),
        keyboardType: TextInputType.number,
      )
    );
    final formMotivo = f.formItemsDesign(
      Icons.create,
      TextFormField(
        decoration: new InputDecoration(
          labelText: 'Motivo del Viaje',
          contentPadding: const EdgeInsets.all(10.0),
        ),
        onChanged: (value) => requerimiento.requerimientoMotivo = value,
      ),
    );
    final formButton =  Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: MaterialButton(
        minWidth: 200.0,
        height: 40.0,
        onPressed: () {
          if (_formKey.currentState.validate()) {
            //facturaProvider.subirFirebase(foto);
            print(requerimiento.toJson());
          }
        },
        color: Color.fromRGBO(0, 154, 174, 1.0),
        child: Text('Enviar',style: TextStyle(color: Colors.white)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      )
    );
    


    lista..add(formFechaInicio)
         ..add(formFechaFin)
         ..add(formMontoViaje)
         ..add(formMontoAlimento)
         ..add(formMontoHospedaje)
         ..add(formMontoMovilidad)
         ..add(formMontoOtros)
         ..add(formMotivo)
         ..add(formButton);



    return lista;

  }

  
}