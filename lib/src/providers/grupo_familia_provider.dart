
import 'dart:convert';
import 'package:toyota_scp_mobile_apphino/src/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:toyota_scp_mobile_apphino/src/models/grupo_familia_model.dart';
class GrupoFamiliaProvider{
  //Crear meotod crear grupFamdad
  //Retornar -> Lista de Ciudades

  Future<List<GrupoFamiliaModel>> cargarGrupoFamilias() async {
      final url =
        "${AppConfig.api_host}/rest/grupo";
    final resp =
        await http.get(url, headers: {'Content-Type': 'application/json',
        'Authorization': AppConfig.autentificacion}
        );
 
    final Map<String, dynamic> decodedData =
        json.decode(utf8.decode(resp.bodyBytes)); //json.decode(resp.body);
        print(decodedData);
    final List<GrupoFamiliaModel> grupoFamilias = new List();
    if (decodedData == null) {
      return [];
    } else if (decodedData["GrupoResponse"]["Detalle"]["Mensaje"]["codigoMensaje"] != "000") {
      return [];
    } else if(decodedData["GrupoResponse"]["Detalle"]["Mensaje"]["codigoMensaje"] == "000") {
      decodedData["GrupoResponse"]["Detalle"]["Datos"].forEach((grupFam) {
        print(grupFam);
        final grupFamdadTemp = GrupoFamiliaModel.fromJson(grupFam);
        // grupFamdadTemp.id = grupFam["ID"];
        grupoFamilias.add(grupFamdadTemp);
      });
    }

    return grupoFamilias;
  }
}