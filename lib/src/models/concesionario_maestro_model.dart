// To parse this JSON data, do
//
//     final concesionarioMaestroModel = concesionarioMaestroModelFromJson(jsonString);

import 'dart:convert';

ConcesionarioMaestroModel concesionarioMaestroModelFromJson(String str) => ConcesionarioMaestroModel.fromJson(json.decode(str));

String concesionarioMaestroModelToJson(ConcesionarioMaestroModel data) => json.encode(data.toJson());

class ConcesionarioMaestroModel {
    String id;
    String codigo;
    String descripcion;
    String ciudad;
    String tipoConcesionario;
    String tipoServicio;
    String taller;
    String imagen;
    String telefono;
    String whatsapp;
    String correo;
    String direccion;
    String distrito;
    String latitud;

    ConcesionarioMaestroModel({
        this.id,
        this.codigo,
        this.descripcion,
        this.ciudad,
        this.tipoConcesionario,
        this.tipoServicio,
        this.taller,
        this.imagen,
        this.telefono,
        this.whatsapp,
        this.correo,
        this.direccion,
        this.distrito,
        this.latitud,
    });

    factory ConcesionarioMaestroModel.fromJson(Map<String, dynamic> json) => ConcesionarioMaestroModel(
        id: json["ID"].toString(),
        codigo: json["CODIGO"],
        descripcion: json["DESCRIPCION"],
        ciudad: json["CIUDAD"],
        tipoConcesionario: json["TIPO_CONCESIONARIO"],
        tipoServicio: json["TIPO_SERVICIO"],
        taller: json["TALLER"],
        imagen: json["IMAGEN"],
        telefono: json["TELEFONO"],
        whatsapp: json["WHATSAPP"],
        correo: json["CORREO"],
        direccion: json["DIRECCION"],
        distrito: json["DISTRITO"],
        latitud: json["LATITUD"],
    );

    Map<String, dynamic> toJson() => {
        "ID": id,
        "CODIGO": codigo,
        "DESCRIPCION": descripcion,
        "CIUDAD": ciudad,
        "TIPO_CONCESIONARIO": tipoConcesionario,
        "TIPO_SERVICIO": tipoServicio,
        "TALLER": taller,
        "IMAGEN": imagen,
        "TELEFONO": telefono,
        "WHATSAPP": whatsapp,
        "CORREO": correo,
        "DIRECCION": direccion,
        "DISTRITO": distrito,
        "LATITUD": latitud,
    };
}
