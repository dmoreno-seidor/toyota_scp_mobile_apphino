// To parse this JSON data, do
//
//     final preguntasFrecuentesModel = preguntasFrecuentesModelFromJson(jsonString);

import 'dart:convert';

PreguntasFrecuentesModel preguntasFrecuentesModelFromJson(String str) => PreguntasFrecuentesModel.fromJson(json.decode(str));

String preguntasFrecuentesModelToJson(PreguntasFrecuentesModel data) => json.encode(data.toJson());

class PreguntasFrecuentesModel {
    int iId;
    int iOrden;
    String sNombre;
    String sRespuesta;
    String sImagen;
    String dFechaRegistro;
    int idEstado;
    String sEstado;
    bool isExpanded;

    PreguntasFrecuentesModel({
        this.iId,
        this.iOrden,
        this.sNombre,
        this.sRespuesta,
        this.sImagen,
        this.dFechaRegistro,
        this.idEstado,
        this.sEstado,
        this.isExpanded = false,
    });

    factory PreguntasFrecuentesModel.fromJson(Map<String, dynamic> json) => PreguntasFrecuentesModel(
        iId: json["iId"],
        iOrden: json["iOrden"],
        sNombre: json["sNombre"],
        sRespuesta: json["sRespuesta"],
        sImagen: json["sImagen"],
        dFechaRegistro: json["dFechaRegistro"],
        idEstado: json["idEstado"],
        sEstado: json["sEstado"],
        isExpanded: false,
    );

    Map<String, dynamic> toJson() => {
        "iId": iId,
        "iOrden": iOrden,
        "sNombre": sNombre,
        "sRespuesta": sRespuesta,
        "sImagen": sImagen,
        "dFechaRegistro": dFechaRegistro,
        "idEstado": idEstado,
        "sEstado": sEstado,
        "isExpanded": false,
    };
}
