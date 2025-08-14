// To parse this JSON data, do
//
//     final tipoDocumentoModel = tipoDocumentoModelFromJson(jsonString);

import 'dart:convert';

TipoDocumentoModel tipoDocumentoModelFromJson(String str) =>
    TipoDocumentoModel.fromJson(json.decode(str));

String tipoDocumentoModelToJson(TipoDocumentoModel data) =>
    json.encode(data.toJson());

class TipoDocumentoModel {
  int id;
  String tipoDocumento;

  TipoDocumentoModel({
    this.id,
    this.tipoDocumento = '',
  });

  factory TipoDocumentoModel.fromJson(Map<String, dynamic> json) =>
      TipoDocumentoModel(
        id: json["ID"],
        tipoDocumento: json["DESCRIPCION"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipoDocumento": tipoDocumento,
      };
}
