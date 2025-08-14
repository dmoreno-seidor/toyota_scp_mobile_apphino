// To parse this JSON data, do
//
//     final ColorModel = ColorModelFromJson(jsonString);

import 'dart:convert';

ColorModel colorModelFromJson(String str) => ColorModel.fromJson(json.decode(str));

String colorModelToJson(ColorModel data) => json.encode(data.toJson());

class ColorModel {
    String id;
    String codigo;
    String descripcion;
    String codehex;
    bool seleccionado;

    ColorModel({
        this.id,
        this.codigo,
        this.descripcion,
        this.codehex,
        this.seleccionado,
    });

    factory ColorModel.fromJson(Map<String, dynamic> json) => ColorModel(
        id: json["id"],
        codigo: json["codigo"],
        descripcion: json["descripcion"],
        codehex : json["codehex"],
        seleccionado: json["seleccionado"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "codigo": codigo,
        "descripcion": descripcion,
        "codehex": codehex,
        "seleccionado": seleccionado,
    };
}
