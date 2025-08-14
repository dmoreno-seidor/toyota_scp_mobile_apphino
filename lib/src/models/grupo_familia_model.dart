// To parse this JSON data, do
//
//     final grupoFamiliaModel = grupoFamiliaModelFromJson(jsonString);

import 'dart:convert';

GrupoFamiliaModel grupoFamiliaModelFromJson(String str) => GrupoFamiliaModel.fromJson(json.decode(str));

String grupoFamiliaModelToJson(GrupoFamiliaModel data) => json.encode(data.toJson());

class GrupoFamiliaModel {
    String id;
    String codigo;
    String nombre;
    String iconoActivo;
    String iconoDesactivado;
    bool seleccionado;

    GrupoFamiliaModel({
        this.id,
        this.codigo,
        this.nombre,
        this.iconoActivo,
        this.iconoDesactivado,
        this.seleccionado,
    });

    factory GrupoFamiliaModel.fromJson(Map<String, dynamic> json) => GrupoFamiliaModel(
        id: json['id'].toString(),
        codigo: json["codigo"],
        nombre: json["nombre"],
        iconoActivo: json["iconoActivo"],
        iconoDesactivado: json["iconoDesactivado"],
        seleccionado: json["seleccionado"]=="0"?false:true,
    );

    Map<String, dynamic> toJson() => {
        "id" : id,
        "codigo": codigo,
        "nombre": nombre,
        "iconoActivo": iconoActivo,
        "iconoDesactivado": iconoDesactivado,
        "seleccionado": seleccionado,
    };
}
