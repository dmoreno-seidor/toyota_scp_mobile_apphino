// To parse this JSON data, do
//
//     final misServiciosModel = misServiciosModelFromJson(jsonString);

import 'dart:convert';

// import 'package:toyota_scp_mobile_apphino/src/models/premio_canjeado_model.dart';
import 'package:toyota_scp_mobile_apphino/src/models/servicio_model.dart';

MisServiciosModel misServiciosModelFromJson(String str) => MisServiciosModel.fromJson(json.decode(str));

String misServiciosModelToJson(MisServiciosModel data) => json.encode(data.toJson());

class MisServiciosModel {
    String totServicios;
    String fechaUltimoServicio;
    List<ServicioModel> servicios;

    MisServiciosModel({
        this.totServicios,
        this.fechaUltimoServicio,
        this.servicios,
    });

    factory MisServiciosModel.fromJson(Map<String, dynamic> json) => MisServiciosModel(
        totServicios: json["totServicios"],
        fechaUltimoServicio: json["fechaUltimoServicio"],
        servicios: json["servicios"]==null?[]:json["servicios"],
    );

    Map<String, dynamic> toJson() => {
        "totServicios": totServicios,
        "fechaUltimoServicio": fechaUltimoServicio,
        "servicios": servicios==null?[]:[],
    };
}