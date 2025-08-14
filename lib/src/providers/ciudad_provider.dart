
import 'dart:convert';
import 'package:toyota_scp_mobile_apphino/src/models/ciudad_model.dart';
import 'package:http/http.dart' as http;

import '../app_config.dart';
class CiudadProvider{
  //Crear meotod crear ciudad
  //Retornar -> Lista de Ciudades

  Future<List<CiudadModel>> cargarCiudades() async {
      final url =
        "${AppConfig.api_host}/core/appMasters/service/ODataService.xsodata/VCiudadApp?\$format=json";
    final resp =
        await http.get(url, headers: {'Content-Type': 'application/json'});

    final Map<String, dynamic> decodedData =
        json.decode(utf8.decode(resp.bodyBytes)); //json.decode(resp.body);
    final List<CiudadModel> ciudades = new List();
    if (decodedData == null) {
      return [];
    } else if (decodedData['error'] != null) {
      return [];
    } else {
      decodedData["d"]["results"].forEach((ciu) {
        print(ciu);
        final ciudadTemp = CiudadModel.fromJson(ciu);
        ciudadTemp.id = ciu["ID"];
        if(ciu["ESTADO"]=="Activo"){
        ciudades.add(ciudadTemp);
        }
      });
    }

    return ciudades;
  }
}