// To parse this JSON data, do
//
//     final cargoUsuarioModel = cargoUsuarioModelFromJson(jsonString);

import 'dart:convert';

CargoUsuarioModel cargoUsuarioModelFromJson(String str) =>
    CargoUsuarioModel.fromJson(json.decode(str));

String cargoUsuarioModelToJson(CargoUsuarioModel data) =>
    json.encode(data.toJson());

class CargoUsuarioModel {
  int id;
  String cargoUsuario;

  CargoUsuarioModel({
    this.id,
    this.cargoUsuario = '',
  });

  factory CargoUsuarioModel.fromJson(Map<String, dynamic> json) =>
      CargoUsuarioModel(
        id: json["ID"],
        cargoUsuario: json["DESCRIPCION"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cargoUsuario": cargoUsuario,
      };
}
