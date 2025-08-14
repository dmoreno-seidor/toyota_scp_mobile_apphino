// To parse this JSON data, do
//
//     final catalogoModel = catalogoModelFromJson(jsonString);

import 'dart:convert';

import 'package:toyota_scp_mobile_apphino/src/models/talla_model.dart';

import 'color_model.dart';

CatalogoModel catalogoModelFromJson(String str) => CatalogoModel.fromJson(json.decode(str));

String catalogoModelToJson(CatalogoModel data) => json.encode(data.toJson());

class CatalogoModel {
    String codigo;
    String descrip;
    String puntos;
    String color;
    String talla;
    String material;
    String imagen;
    // String colores;
    // String tallas;
    dynamic aColores = new List<ColorModel>();
    dynamic aTallas = new List<TallaModel>();

    CatalogoModel({
        this.codigo,
        this.descrip,
        this.puntos,
        this.color,
        this.talla,
        this.material,
        this.imagen,
        this.aColores,
        this.aTallas,
    });

    factory CatalogoModel.fromJson(Map<String, dynamic> json) => CatalogoModel(
        codigo: json["codigo"],
        descrip: json["descrip"],
        puntos: json["puntos"],
        color: json["color"],
        talla: json["talla"],
        material: json["material"],
        imagen:  json["imagenes"].length>0?json["imagenes"][0]["sImagen"]:"",//json["imagen"],
        // colores: json["colores"],
        // tallas: json["tallas"],
        aColores : jsonEncode(json["colores"]),
        aTallas: jsonEncode(json["tallas"])
    );

    Map<String, dynamic> toJson() => {
        "codigo": codigo,
        "descrip": descrip,
        "puntos": puntos,
        "color": color,
        "talla": talla,
        "material": material,
        "imagen": imagen,
        // "colores": colores,
        // "tallas": tallas,
        "aColores": aColores==null?[]:aColores,
        "aTallas": aTallas==null?[]:aTallas
    };
}
