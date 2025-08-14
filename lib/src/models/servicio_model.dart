// To parse this JSON data, do
//
//     final premioCanjeadoModel = premioCanjeadoModelFromJson(jsonString);

import 'dart:convert';

ServicioModel premioCanjeadoModelFromJson(String str) => ServicioModel.fromJson(json.decode(str));

String premioCanjeadoModelToJson(ServicioModel data) => json.encode(data.toJson());

class ServicioModel {
    String id;
    String descrip;
    String fecha;
    String idConcesionario;
    String concesionario;
    String asesor;
    String placa;
    bool isExpanded;

    ServicioModel({
        this.id,
        this.descrip,
        this.fecha,
        this.idConcesionario,
        this.concesionario,
        this.asesor,
        this.placa,
        this.isExpanded = false
    });

    factory ServicioModel.fromJson(Map<String, dynamic> json) => ServicioModel(
        id: json["id"]==null?"":json["id"],
        descrip: json["descrip"]==null?"":json["descrip"],
        fecha: json["fecha"]==null?"":json["fecha"],
        idConcesionario: json["idConcesionario"]==null?"":json["idConcesionario"],
        concesionario: json["concesionario"]==null?"":json["concesionario"],
        asesor: json["asesor"]==null?"":json["asesor"],
        placa: json["placa"]==null?"":json["placa"],
        isExpanded : false
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "descrip": descrip,
        "fecha": fecha,
        "idConcesionario": idConcesionario,
        "concesionario": concesionario,
        "asesor": asesor,
        "placa": placa,
        "isExpanded" : false
    };
}
