// To parse this JSON data, do
//
//     final alternativaModel = alternativaModelFromJson(jsonString);

import 'dart:convert';

AlternativaModel alternativaModelFromJson(String str) => AlternativaModel.fromJson(json.decode(str));

String alternativaModelToJson(AlternativaModel data) => json.encode(data.toJson());

class AlternativaModel {
    String id;
    String descripcion;
    bool seleccionado;

    AlternativaModel({
        this.id,
        this.descripcion,
        this.seleccionado = false
    });

    factory AlternativaModel.fromJson(Map<String, dynamic> json) => AlternativaModel(
        id: json["id"],
        descripcion: json["descripcion"],
        seleccionado: false
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "descripcion": descripcion,
        "seleccionado": false
    };
}
