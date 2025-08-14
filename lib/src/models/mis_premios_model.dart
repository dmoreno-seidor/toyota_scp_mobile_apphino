// To parse this JSON data, do
//
//     final misPremiosModel = misPremiosModelFromJson(jsonString);

import 'dart:convert';

import 'package:toyota_scp_mobile_apphino/src/models/premio_canjeado_model.dart';

MisPremiosModel misPremiosModelFromJson(String str) => MisPremiosModel.fromJson(json.decode(str));

String misPremiosModelToJson(MisPremiosModel data) => json.encode(data.toJson());

class MisPremiosModel {
    String totPremios;
    String fechaUltimoCanje;
    List<PremioCanjeadoModel> premios;

    MisPremiosModel({
        this.totPremios,
        this.fechaUltimoCanje,
        this.premios,
    });

    factory MisPremiosModel.fromJson(Map<String, dynamic> json) => MisPremiosModel(
        totPremios: json["totPremios"],
        fechaUltimoCanje: json["fechaUltimoCanje"],
        premios: json["premios"]==null?[]:json["premios"],
    );

    Map<String, dynamic> toJson() => {
        "totPremios": totPremios,
        "fechaUltimoCanje": fechaUltimoCanje,
        "premios": premios==null?[]:[],
    };
}