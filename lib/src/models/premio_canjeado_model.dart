// To parse this JSON data, do
//
//     final premioCanjeadoModel = premioCanjeadoModelFromJson(jsonString);

import 'dart:convert';

PremioCanjeadoModel premioCanjeadoModelFromJson(String str) => PremioCanjeadoModel.fromJson(json.decode(str));

String premioCanjeadoModelToJson(PremioCanjeadoModel data) => json.encode(data.toJson());

class PremioCanjeadoModel {
    String id;
    String codigo;
    String descrip;
    String idConcesionario;
    String concesionario;
    String fecha;
    String cantidad;
    String imagen;
    bool isExpanded;

    PremioCanjeadoModel({
        this.id,
        this.codigo,
        this.descrip,
        this.idConcesionario,
        this.concesionario,
        this.fecha,
        this.cantidad,
        this.imagen,
        this.isExpanded = false
    });

    factory PremioCanjeadoModel.fromJson(Map<String, dynamic> json) => PremioCanjeadoModel(
        id: json["id"]==null?"":json["id"],
        codigo: json["codigo"]==null?"":json["codigo"],
        descrip: json["descrip"]==null?"":json["descrip"],
        idConcesionario: json["idConcesionario"]==null?"":json["idConcesionario"],
        concesionario: json["concesionario"]==null?"":json["concesionario"],
        fecha: json["fecha"]==null?"":json["fecha"],
        cantidad: json["cantidad"]==null?"":json["cantidad"],
        imagen: json["imagenes"].length>0?json["imagenes"][0]["sImagen"]:"",
        isExpanded : json["isExpanded"]=="0"?false:true
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "codigo": codigo,
        "descrip": descrip,
        "idConcesionario": idConcesionario,
        "concesionario": concesionario,
        "fecha": fecha,
        "cantidad": cantidad,
        "imagen": imagen,
        "isExpanded" : false
    };
}
