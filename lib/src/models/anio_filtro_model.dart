// To parse this JSON data, do
//
//     final anioFiltro = anioFiltroFromJson(jsonString);

import 'dart:convert';

// import 'package:toyota_scp_mobile_apphino/src/models/talla_model.dart';

// import 'color_model.dart';

AnioFiltro anioFiltroFromJson(String str) => AnioFiltro.fromJson(json.decode(str));

String anioFiltroToJson(AnioFiltro data) => json.encode(data.toJson());

class AnioFiltro {
    String anio;
    bool isSelected;

    AnioFiltro({
        this.anio,
        this.isSelected = false,
    });

    factory AnioFiltro.fromJson(Map<String, dynamic> json) => AnioFiltro(
        anio: json["anio"],
        isSelected : false
    );

    Map<String, dynamic> toJson() => {
        "anio": anio,
        "isSelected" : false
    };
}
