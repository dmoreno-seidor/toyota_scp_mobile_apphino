// To parse this JSON data, do
//
//     final concesionarioModel = concesionarioModelFromJson(jsonString);

import 'dart:convert';

ConcesionarioModel concesionarioModelFromJson(String str) => ConcesionarioModel.fromJson(json.decode(str));

String concesionarioModelToJson(ConcesionarioModel data) => json.encode(data.toJson());

class ConcesionarioModel {
    String id;
    String codigo;
    String distrito;
    String nombre;
    String direccion;
    String telefono;
    String whatsapp;
    String correo;
    String latitud;
    String longitud;
    String imagen;
    String distancia;
    String ciudad;
    String servicios;
     bool isExpanded;

    ConcesionarioModel({
        this.id,
        this.codigo,
        this.distrito,
        this.nombre,
        this.direccion,
        this.telefono,
        this.whatsapp,
        this.correo,
        this.latitud,
        this.longitud,
        this.imagen,
        this.distancia,
        this.ciudad,
        this.servicios,
        this.isExpanded
    });

    factory ConcesionarioModel.fromJson(Map<String, dynamic> json) => ConcesionarioModel(
        id: json["id"],
        codigo: json["codigo"],
        distrito: json["distrito"],
        nombre: json["nombre"],
        direccion: json["direccion"],
        telefono: json["telefono"],
        whatsapp: json["whatsapp"],
        correo: json["correo"],
        latitud: json["latitud"],
        longitud: json["longitud"],
        imagen: json["imagen"],
        distancia: json["distancia"],
        ciudad: json["ciudad"],
        servicios: json["servicios"],
        isExpanded: false,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "codigo" : codigo,
        "distrito": distrito,
        "nombre": nombre,
        "direccion": direccion,
        "telefono": telefono,
        "whatsapp": whatsapp,
        "correo": correo,
        "latitud": latitud,
        "longitud": longitud,
        "imagen": imagen,
        "distancia": distancia,
        "ciudad" : ciudad,
        "servicios" : servicios,
        "isExpanded": false,
    };
}
