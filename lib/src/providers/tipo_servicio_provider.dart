import 'dart:convert';

import 'package:http/http.dart' as http;

import '../app_config.dart';
import '../models/tipo_servicio_model.dart';

class TipoServicioProvider {
  Future<List<TipoServicioModel>> cargarTipoServicio() async {
    final url =
        "${AppConfig.api_host}/core/appMasters/service/ODataService.xsodata/VTipo_Servicio?\$format=json";
    final resp =
        await http.get(url, headers: {'Content-Type': 'application/json'});

    final Map<String, dynamic> decoded =
        json.decode(utf8.decode(resp.bodyBytes));
    final List<TipoServicioModel> tipoServicios = new List();
    if (decoded == null) {
      return [];
    }
    if (decoded['error'] != null) {
      return [];
    }
    decoded["d"]["results"].forEach((item) {
      print(item);
      if (item["ESTADO"] == "Activo") {
        tipoServicios.add(TipoServicioModel.fromJson(item));
      }
    });
    return tipoServicios;
  }
}
