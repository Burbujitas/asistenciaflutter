// To parse this JSON data, do
//
//     final rendicionModel = rendicionModelFromJson(jsonString);

import 'dart:convert';

RendicionModel rendicionModelFromJson(String str) => RendicionModel.fromJson(json.decode(str));

String rendicionModelToJson(RendicionModel data) => json.encode(data.toJson());

class RendicionModel {
    String dni;
    String nombre;
    int numeroreq;
    DateTime fecha_inicio;
    DateTime fecha_fin;
    int total;
    String motivo;
    double gasto_actual;

    RendicionModel({
        this.dni='',
        this.nombre='',
        this.numeroreq=0,
        this.fecha_inicio,
        this.fecha_fin,
        this.total=0,
        this.motivo='',
        this.gasto_actual=0,
    });

    factory RendicionModel.fromJson(Map<String, dynamic> json) => RendicionModel(
        dni: json["dni"],
        nombre: json["nombre"],
        numeroreq: json["numero_requerimiento"],
        fecha_inicio:  DateTime.parse(json["fecha_inicio"]),
        fecha_fin: DateTime.parse(json["fecha_fin"]),
        total: json["total"],
        motivo: json["motivo"],
        gasto_actual: json["gasto_actual"],
    );

    Map<String, dynamic> toJson() => {
        "dni": dni,
        "nombre": nombre,
        "numeroreq": numeroreq,
        "fechaini": fecha_inicio.toString(),
        "fechafin": fecha_fin.toString(),
        "total": total,
        "motivo": motivo,
        "gastoactual": gasto_actual,
    };
}
