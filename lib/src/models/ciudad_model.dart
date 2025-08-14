// To parse this JSON data, do
//
//     final ciudadModel = ciudadModelFromJson(jsonString);

import 'dart:convert';

CiudadModel ciudadModelFromJson(String str) => CiudadModel.fromJson(json.decode(str));

String ciudadModelToJson(CiudadModel data) => json.encode(data.toJson());

class CiudadModel {
    int id;
    String codigo;
    String descripcion;
    String estado;
    String tabla;

    CiudadModel({
        this.id,
        this.codigo,
        this.descripcion,
        this.estado,
        this.tabla,
    });

    factory CiudadModel.fromJson(Map<String, dynamic> json) => CiudadModel(
        id: json["ID"],
        codigo: json["CODIGO"],
        descripcion: json["DESCRIPCION"],
        estado: json["ESTADO"],
        tabla: json["TABLA"],
    );

    Map<String, dynamic> toJson() => {
        "ID": id,
        "CODIGO": codigo,
        "DESCRIPCION": descripcion,
        "ESTADO": estado,
        "TABLA": tabla,
    };
}
