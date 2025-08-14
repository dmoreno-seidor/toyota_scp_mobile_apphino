// To parse this JSON data, do
//
//     final datosMaestroModel = datosMaestroModelFromJson(jsonString);

import 'dart:convert';

import 'package:toyota_scp_mobile_apphino/src/models/cargo_usuario_model.dart';
import 'package:toyota_scp_mobile_apphino/src/models/tipo_documento_model.dart';

String datosMaestroModelToJson(DatosMaestroModel data) =>
    json.encode(data.toJson());

class DatosMaestroModel {
  List<TipoDocumentoModel> tipoDocumentos;
  List<CargoUsuarioModel> cargoUsuarios;

  DatosMaestroModel({
    this.tipoDocumentos,
    this.cargoUsuarios,
  });

  Map<String, dynamic> toJson() => {
        "tipoDocumentos": tipoDocumentos,
        "cargoUsuarios": cargoUsuarios,
      };

  getTipoDocumentos() {
    return this.tipoDocumentos;
  }

  getCargoUsuarios() {
    return this.cargoUsuarios;
  }
}
