import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class FormFacturaPage extends StatefulWidget {
  FormFacturaPage({Key key}) : super(key: key);

  @override
  _FormFacturaPageState createState() => _FormFacturaPageState();
}

class _FormFacturaPageState extends State<FormFacturaPage> {
  final _formKey = GlobalKey<FormState>();
  final format = DateFormat("dd-MM-yyyy");
  int _radioValue1 = -1;
  String dropdownValue = 'Alimentación';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Información Factura'),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            children: formUI(),
          )
        ),
      ),
    );
  }

  List<Widget> formUI() {
    List<Widget> lwidget = [];
    final widgetTemp = Column(
      children: listaFormulario(),
    );
    lwidget..add(widgetTemp);
    return lwidget;
  }

  Widget formItemsDesign(IconData icon, Widget item) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.5,horizontal: 10.0), 
      child: Card(
        elevation: 4.0,
        child: ListTile(
          leading: Icon(icon),
          title: item,
          contentPadding: EdgeInsets.only(left: 20.0 ,bottom: 7.0, right: 30.0),
        )
      ),
    );
  }

  List<Widget> listaFormulario() {
    
    List<Widget> lista = [];
    final formRuc = formItemsDesign(
      Icons.person,
      TextFormField(
        decoration: new InputDecoration(
          labelText: 'Ruc',
          contentPadding: const EdgeInsets.all(10.0),
        ),
        keyboardType: TextInputType.number,
      )
    );
    final formSerie = formItemsDesign(
      Icons.person_add,
      TextFormField(
        decoration: new InputDecoration(
          labelText: 'Serie',
          contentPadding: const EdgeInsets.all(10.0),
        ),
      )
    );
    final formNumeroSerie = formItemsDesign(
      Icons.person_add,
      TextFormField(
        decoration: new InputDecoration(
          labelText: 'Número Serie',
          contentPadding: const EdgeInsets.all(10.0),
        ),
      )
    );
    final formMonto = formItemsDesign(
      Icons.person_add,
      TextFormField(
        decoration: new InputDecoration(
          labelText: 'Monto',
          contentPadding: const EdgeInsets.all(10.0),
        ),
        keyboardType: TextInputType.number,
      )
    );
    final formIgv = formItemsDesign(
      Icons.person_add,
      TextFormField(
        decoration: new InputDecoration(
          labelText: 'IGV',
          contentPadding: const EdgeInsets.all(10.0),
        ),
        keyboardType: TextInputType.number,
      )
    );
    final formFecha = formItemsDesign(
      Icons.calendar_today,
      DateTimeField(
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
        }
      )
    );
    final formMoneda = formItemsDesign(
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
    final formCategoria = formItemsDesign(
      null,
      Container(
        width: 320,
        child: DropdownButton<String>(
          value: dropdownValue,
          onChanged: (String newValue) {
            dropdownValue = newValue;
            setState(() {
              
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

    final formButton = formItemsDesign(
      null,
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: RaisedButton(
          padding: const EdgeInsets.all(8.0),
          textColor: Colors.white,
          color: Colors.deepPurple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              print('Enviamos');
            }
          },
          child: Text('Enviar'),
        ),
      ),
    );

    


    lista..add(formRuc)
         ..add(formSerie)
         ..add(formNumeroSerie)
         ..add(formMonto)
         ..add(formIgv)
         ..add(formFecha)
         ..add(formMoneda)
         ..add(formCategoria);
    return lista;
  }

  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;

      switch (_radioValue1) {
        case 0:
          print('Soles');
          break;
        case 1:
          print('Dólares');
          break;
        case 2:
          print('Try again!');
          break;
      }
    });
  }
}