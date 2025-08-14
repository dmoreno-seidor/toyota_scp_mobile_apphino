// To parse this JSON data, do
//
//     final encuestaModel = encuestaModelFromJson(jsonString);

import 'dart:convert';

import 'package:toyota_scp_mobile_apphino/src/models/alternativa_model..dart';

EncuestaModel encuestaModelFromJson(String str) => EncuestaModel.fromJson(json.decode(str));

String encuestaModelToJson(EncuestaModel data) => json.encode(data.toJson());

class EncuestaModel {
    String id;
    String titulo;
    String idEncuesta;
    String descripcion;
    String tipoEncuesta;
    dynamic alternativas = new List<AlternativaModel>();

    EncuestaModel({
        this.id,
        this.titulo,
        this.idEncuesta,
        this.descripcion,
        this.tipoEncuesta,
        this.alternativas
    });

    factory EncuestaModel.fromJson(Map<String, dynamic> json) => EncuestaModel(
        id: json["id"],
        titulo: json["titulo"],
        idEncuesta : json["idEncuesta"],
        descripcion: json["descripcion"],
        tipoEncuesta : json["tipoEncuesta"],
        alternativas: json["alternativas"]==null?[]:json["alternativas"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "titulo": titulo,
        "idEncuesta" : idEncuesta,
        "descripcion": descripcion,
        "tipoEncuesta" : tipoEncuesta,
        "alternativas": alternativas
    };
}
