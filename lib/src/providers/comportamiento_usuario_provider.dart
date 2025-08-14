import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../models/comportamiento_usuario_model.dart';
import '../app_config.dart';

/// @author Daniel Carpio
class ComportamientoUsuarioProvider {

  Future<ComportamientoUsuarioModel> registrarComportamiento(
      ComportamientoUsuarioModel comportamientoUsuarioModel) async {
    final oRequest = comportamientoUsuarioModel.toJson();
    final url = "${AppConfig.api_host}/rest/registrarComportamientoUsuario";

    final resp = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'SAPUI5Aplicacion':
              '{"Aplicacion":"com.seidor.appMasters","AplicacionVersion":"1.0.0","AplicacionFWVersion":"1.65.6","AplicacionLatitud":"0","AplicacionLongitud":"0","AplicacionFechaRequest":"2019-12-12T17:42:31.886Z","AplicacionIpLocal":"0.0.0.0","AplicacionDevice":"win | 10"}'
        },
        body: json.encode(oRequest));
    
    if (resp.statusCode != 200) {
      throw PlatformException(
          code: resp.statusCode.toString(), message: resp.toString());
    }

    Map<String, dynamic> decoded = json.decode(resp.body);
    // final iCode = decoded["iCode"];
    if (decoded["iCode"] != 1) {
      throw PlatformException(
          code: decoded["iCode"].toString(), message: decoded["sMessage"].toString());
    }
    return ComportamientoUsuarioModel.fromJson(decoded["oData"]);
  }
}
