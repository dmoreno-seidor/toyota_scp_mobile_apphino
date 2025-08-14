// To parse this JSON data, do
//
//     final noticiaModel = noticiaModelFromJson(jsonString);

import 'dart:convert';

NoticiaModel noticiaModelFromJson(String str) => NoticiaModel.fromJson(json.decode(str));

String noticiaModelToJson(NoticiaModel data) => json.encode(data.toJson());

class NoticiaModel {
    String id;
    String imagen;
    String nombre;
    String publicadoDesde;
    String publicadoHasta;
    String texto;

    NoticiaModel({
        this.id,
        this.imagen,
        this.nombre,
        this.publicadoDesde,
        this.publicadoHasta,
        this.texto,
    });

    factory NoticiaModel.fromJson(Map<String, dynamic> json) => NoticiaModel(
        id: json["id"],
        imagen: json["imagen"],
        nombre: json["nombre"],
        publicadoDesde: json["publicadoDesde"],
        publicadoHasta: json["publicadoHasta"],
        texto: json["texto"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "imagen": imagen,
        "nombre": nombre,
        "publicadoDesde": publicadoDesde,
        "publicadoHasta": publicadoHasta,
        "texto": texto,
    };
}
