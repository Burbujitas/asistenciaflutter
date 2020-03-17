import 'dart:convert';

FacturaModel facturaModelFromJson(String str) => FacturaModel.fromJson(json.decode(str));
String facturaModelToJson(FacturaModel data) => json.encode(data.toJson());
final facturaPost = new FacturaModel();

class FacturaModel {
    String ruc_emisor;
    String tipo_doc;
    String gasto;
    String serie;
    String numero;
    String ser_guia;
    String num_guia;
    double igv;
    DateTime fecha_scaneo;
    String moneda;
    double monto;
    String orden;
    String tipopago;
    DateTime fecha_emision;
    String imagen;
    double total;
    String comentario;
    String dni;
    int requerimientos_vuelos_id;
    dynamic detalles_requerimiento_id;
    int estado_factura_id;
    

    FacturaModel({
        this.ruc_emisor,
        this.tipo_doc,
        this.gasto,
        this.serie,
        this.numero,
        this.ser_guia,
        this.num_guia,
        this.igv,
        this.fecha_scaneo,
        this.moneda,
        this.monto,
        this.orden,
        this.tipopago,
        this.fecha_emision,
        this.imagen,
        this.total,
        this.comentario,
        this.dni,
        this.requerimientos_vuelos_id,
        this.detalles_requerimiento_id,
        this.estado_factura_id,
    });

    factory FacturaModel.fromJson(Map<String, dynamic> json) => FacturaModel(
        ruc_emisor: json["ruc_emisor"],
        tipo_doc: json["tipo_doc"],
        gasto: json["gasto"],
        serie: json["serie"],
        numero: json["numero"],
        ser_guia: json["ser_guia"],
        num_guia: json["num_guia"],
        igv: json["igv"].toDouble(),
        fecha_scaneo: DateTime.parse(json["fecha_scaneo"]),
        moneda: json["moneda"],
        monto: json["monto"].toDouble(),
        orden: json["orden"],
        tipopago: json["tipopago"],
        fecha_emision: DateTime.parse(json["fecha_emision"]),
        imagen: json["imagen"],
        total: json["total"].toDouble(),
        comentario: json["comentario"],
        dni: json["dni"],
        requerimientos_vuelos_id: json["requerimientos_vuelos_id"],
        detalles_requerimiento_id: json["detalles_requerimiento_id"],
        estado_factura_id: json["estado_factura_id"],
    );

    Map<String, dynamic> toJson() => {
        "ruc_emisor": ruc_emisor,
        "tipo_doc": tipo_doc,
        "gasto": gasto,
        "serie": serie,
        "numero": numero,
        "ser_guia": ser_guia,
        "num_guia": num_guia,
        "igv": igv,
        "fecha_scaneo": "${fecha_scaneo.year.toString().padLeft(4, '0')}-${fecha_scaneo.month.toString().padLeft(2, '0')}-${fecha_scaneo.day.toString().padLeft(2, '0')}",
        "modena": moneda,
        "monto": monto,
        "orden": orden,
        "tipopago": tipopago,
        "fecha_emision": "${fecha_emision.year.toString().padLeft(4, '0')}-${fecha_emision.month.toString().padLeft(2, '0')}-${fecha_emision.day.toString().padLeft(2, '0')}",
        "imagen": imagen,
        "total": total,
        "comentario": comentario,
        "dni": dni,
        "requerimientos_vuelos_id": requerimientos_vuelos_id,
        "detalles_requerimiento_id": detalles_requerimiento_id,
        "estado_factura_id": estado_factura_id,
    };

}