// To parse this JSON data, do
//
//     final campaniaModel = campaniaModelFromJson(jsonString);

import 'dart:convert';

import 'package:toyota_scp_mobile_apphino/src/models/concesionario_model.dart';

CampaniaModel campaniaModelFromJson(String str) => CampaniaModel.fromJson(json.decode(str));

String campaniaModelToJson(CampaniaModel data) => json.encode(data.toJson());

class CampaniaModel {
    String id;
    String imagen;
    String nombre;
    String vigencia;
    String terminos;
    dynamic aConcesionarios = new List<ConcesionarioModel>();
 
    CampaniaModel({
        this.id,
        this.imagen,
        this.nombre,
        this.vigencia,
        this.terminos,
        this.aConcesionarios,
       
    });

    factory CampaniaModel.fromJson(Map<String, dynamic> json) => CampaniaModel(
        id: json["id"],
        imagen: json["imagen"],
        nombre: json["nombre"],
        vigencia: json["vigencia"],
        terminos: json["terminos"],
        aConcesionarios: json["concesionarios"]== null? []: json["concesionarios"],
       
        // aConcesionario: jsonEncode(json["concesionario"]),

    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "imagen": imagen,
        "nombre": nombre,
        "vigencia": vigencia,
        "terminos": terminos,
        "aConcesionarios": aConcesionarios==null?[]:aConcesionarios,
       
    };
}
