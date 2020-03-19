import 'dart:convert';

RequerimientoVueloModel requerimientoVueloModelFromJson(String str) => RequerimientoVueloModel.fromJson(json.decode(str));

String requerimientoVueloModelToJson(RequerimientoVueloModel data) => json.encode(data.toJson());

class RequerimientoVueloModel {
    DateTime requerimientoFechaInicio;
    DateTime requerimientoFechaFin;
    DateTime requerimientoFecha;
    double requerimientoAlimento;
    double requerimientoHospedaje;
    double requerimientoBoleto;
    double requerimientoMovilidad;
    double requerimientoOtro;
    String requerimientoMotivo;
    int estadoRequerimientoId;
    String usuarioDni;

    RequerimientoVueloModel({
        this.requerimientoFechaInicio,
        this.requerimientoFechaFin,
        this.requerimientoFecha,
        this.requerimientoAlimento,
        this.requerimientoHospedaje,
        this.requerimientoBoleto,
        this.requerimientoMovilidad,
        this.requerimientoOtro,
        this.requerimientoMotivo,
        this.estadoRequerimientoId,
        this.usuarioDni,
    });

    factory RequerimientoVueloModel.fromJson(Map<String, dynamic> json) => RequerimientoVueloModel(
        requerimientoFechaInicio: DateTime.parse(json["requerimientoFechaInicio"]),
        requerimientoFechaFin: DateTime.parse(json["requerimientoFechaFin"]),
        requerimientoFecha: DateTime.parse(json["requerimientoFecha"]),
        requerimientoAlimento: json["requerimientoAlimento"].toDouble(),
        requerimientoHospedaje: json["requerimientoHospedaje"].toDouble(),
        requerimientoBoleto: json["requerimientoBoleto"].toDouble(),
        requerimientoMovilidad: json["requerimientoMovilidad"].toDouble(),
        requerimientoOtro: json["requerimientoOtro"].toDouble(),
        requerimientoMotivo: json["requerimientoMotivo"],
        estadoRequerimientoId: json["estadoRequerimientoId"],
        usuarioDni: json["usuarioDni"],
    );

    Map<String, dynamic> toJson() => {
        "requerimientoFechaInicio": "${requerimientoFechaInicio.year.toString().padLeft(4, '0')}-${requerimientoFechaInicio.month.toString().padLeft(2, '0')}-${requerimientoFechaInicio.day.toString().padLeft(2, '0')}",
        "requerimientoFechaFin": "${requerimientoFechaFin.year.toString().padLeft(4, '0')}-${requerimientoFechaFin.month.toString().padLeft(2, '0')}-${requerimientoFechaFin.day.toString().padLeft(2, '0')}",
        "requerimientoFecha": "${requerimientoFecha.year.toString().padLeft(4, '0')}-${requerimientoFecha.month.toString().padLeft(2, '0')}-${requerimientoFecha.day.toString().padLeft(2, '0')}",
        "requerimientoAlimento": requerimientoAlimento,
        "requerimientoHospedaje": requerimientoHospedaje,
        "requerimientoBoleto": requerimientoBoleto,
        "requerimientoMovilidad": requerimientoMovilidad,
        "requerimientoOtro": requerimientoOtro,
        "requerimientoMotivo": requerimientoMotivo,
        "estadoRequerimientoId": estadoRequerimientoId,
        "usuarioDni": usuarioDni,
    };
}
