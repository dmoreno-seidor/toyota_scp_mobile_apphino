import 'dart:convert';
import 'package:http/http.dart' as http;

import '../app_config.dart';
import '../models/catalogo_model.dart';
import '../models/concesionario_model.dart';

class CatalogoProvider {

  Future<List<CatalogoModel>> cargarCatalogo(String usuario,
      String grupoFamilia, double latitud, double longitud, int more) async {
    final oRequest = {
      "usuario": usuario, //"USUARIO",
      "gruposFamilia": grupoFamilia, //"143",
      "latitud": latitud, //12.00,
      "longitud": longitud, //12.00,
      "more": 0,
    };
    final url =
        "${AppConfig.api_host}/rest/premio?usuario=${oRequest['usuario']}&gruposFamilia=${oRequest['gruposFamilia']}&latitud=${oRequest['latitud']}&longitud=${oRequest['longitud']}&more=${oRequest['more']}";
    final resp = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': AppConfig.autentificacion
    });

    final Map<String, dynamic> decodedData =
        json.decode(utf8.decode(resp.bodyBytes)); //json.decode(resp.body);
    print(decodedData);
    final List<CatalogoModel> catalogo = new List();
    if (decodedData == null) {
      return [];
    } else if (decodedData["PremioResponse"]["Detalle"]["Mensaje"]
            ["codigoMensaje"] !=
        "000") {
      return [];
    } else if (decodedData["PremioResponse"]["Detalle"]["Mensaje"]
            ["codigoMensaje"] ==
        "000") {
      decodedData["PremioResponse"]["Detalle"]["Datos"]["premios"]
          .forEach((cat) {
        print(cat);
        final catalogoTemp = CatalogoModel.fromJson(cat);
        catalogo.add(catalogoTemp);
      });
    }

    return catalogo;
  }

  Future<List<ConcesionarioModel>> consultarConcesionarioxPremio(
      String codigo, double latitud, double longitud) async {
    // final oRequest = {
    //   "codPremio" : "USUARIO",
    //   "latitud" : 12.00,
    //   "longitud" : 12.00,
    // };

    final url =
        "${AppConfig.api_host}/rest/concesionario?codPremio=${codigo}&latitud=${latitud}&longitud=${longitud}";
    final resp = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': AppConfig.autentificacion
    });

    final Map<String, dynamic> decodedData =
        json.decode(utf8.decode(resp.bodyBytes));
    print(decodedData);
    final List<ConcesionarioModel> concesionario = new List();
    if (decodedData == null) {
      return [];
    } else if (decodedData["ConcesionarioResponse"]["Detalle"]["Mensaje"]
            ["codigoMensaje"] !=
        "000") {
      return [];
    } else if (decodedData["ConcesionarioResponse"]["Detalle"]["Mensaje"]
            ["codigoMensaje"] ==
        "000") {
      decodedData["ConcesionarioResponse"]["Detalle"]["Datos"].forEach((cat) {
        print(cat);
        final concesionarioTemp = ConcesionarioModel.fromJson(cat);
        concesionario.add(concesionarioTemp);
      });
    }

    return concesionario;
  }

  /// @author Daniel Carpio
  Future<List<ConcesionarioModel>> consultarConcesionarioxCiudadxServicios(
      String ciudad, String servicios, double latitud, double longitud) async {
    // final oRequest = {
    //   "ciudad" : 105,
    //   "servicios" : "REPUESTOS,TALLER MOVIL"
    //   "latitud" : 12.00,
    //   "longitud" : 12.00,
    // };

    final url =
        "${AppConfig.api_host}/rest/concesionario?ciudad=$ciudad&servicios=$servicios&latitud=$latitud&longitud=$longitud";
    final resp = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': AppConfig.autentificacion
    });

    final Map<String, dynamic> decodedData =
        json.decode(utf8.decode(resp.bodyBytes));
    print(decodedData);
    final List<ConcesionarioModel> concesionario = new List();
    if (decodedData == null) {
      return [];
    } else if (decodedData["ConcesionarioResponse"]["Detalle"]["Mensaje"]
            ["codigoMensaje"] !=
        "000") {
      return [];
    } else if (decodedData["ConcesionarioResponse"]["Detalle"]["Mensaje"]
            ["codigoMensaje"] ==
        "000") {
      decodedData["ConcesionarioResponse"]["Detalle"]["Datos"].forEach((item) {
        concesionario.add(ConcesionarioModel.fromJson(item));
      });
    }

    return concesionario;
  }
}
