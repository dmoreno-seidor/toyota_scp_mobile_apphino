// To parse this JSON data, do
//
//     final respuestaModel = respuestaModelFromJson(jsonString);

import 'dart:convert';

// import 'package:toyota_scp_mobile_apphino/src/models/alternativa_model..dart';

RespuestaModel respuestaModelFromJson(String str) => RespuestaModel.fromJson(json.decode(str));

String respuestaModelToJson(RespuestaModel data) => json.encode(data.toJson());

class RespuestaModel {
    String idPregunta;
    String respuesta;

    RespuestaModel({
        this.idPregunta,
        this.respuesta
    });

    factory RespuestaModel.fromJson(Map<String, dynamic> json) => RespuestaModel(
        idPregunta: json["idPregunta"],
        respuesta: json["respuesta"]
    );

    Map<String, dynamic> toJson() => {
        "idPregunta": idPregunta,
        "respuesta": respuesta
    };
}
