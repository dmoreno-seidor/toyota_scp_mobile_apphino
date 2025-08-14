// To parse this JSON data, do
//
//     final TallaModel = TallaModelFromJson(jsonString);

import 'dart:convert';

TallaModel tallaModelFromJson(String str) => TallaModel.fromJson(json.decode(str));

String tallaModelToJson(TallaModel data) => json.encode(data.toJson());

class TallaModel {
    String id;
    String codigo;
    String descripcion;
    bool seleccionado;

    TallaModel({
        this.id,
        this.codigo,
        this.descripcion,
        this.seleccionado,
    });

    factory TallaModel.fromJson(Map<String, dynamic> json) => TallaModel(
        id: json["id"],
        codigo: json["codigo"],
        descripcion: json["descripcion"],
        seleccionado: json["seleccionado"]=="0"?false:true,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "codigo": codigo,
        "descripcion": descripcion,
        "seleccionado": seleccionado,
    };
}
