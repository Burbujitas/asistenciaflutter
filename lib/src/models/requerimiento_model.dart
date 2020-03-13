// To parse this JSON data, do
//
//     final requerimientoModel = requerimientoModelFromJson(jsonString);

import 'dart:convert';

RequerimientoModel requerimientoModelFromJson(String str) => RequerimientoModel.fromJson(json.decode(str));

String requerimientoModelToJson(RequerimientoModel data) => json.encode(data.toJson());

class RequerimientoModel {
    String razon;
    String tipoGasto;
    double monto;
    DateTime fecha;
    String foto;

    RequerimientoModel({
        this.razon,
        this.tipoGasto,
        this.monto,
        this.fecha,
        this.foto,
    });

    factory RequerimientoModel.fromJson(Map<String, dynamic> json) => RequerimientoModel(
       
        razon: json["fact_ruc_emisor"],
        tipoGasto: json["fact_tipo_gasto"],
        monto: double.parse(json["fact_monto"].toString()) ,
        fecha: DateTime.parse(json["fact_fecha_emision"]),
        foto: json["fact_imagen"],
    );

    Map<String, dynamic> toJson() => {
        "razon": razon,
        "tipo_gasto": tipoGasto,
        "monto": monto,
        "fecha": fecha.toString(),
        "foto": foto,
    };
}


