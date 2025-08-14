import 'dart:convert';
import 'package:toyota_scp_mobile_apphino/src/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:toyota_scp_mobile_apphino/src/models/campania_model.dart';

class CampaniaProvider{
  //Crear meotod crear grupFamdad
  //Retornar -> Lista de Ciudades

  Future<List<CampaniaModel>> cargarCampania(String usuario, double latitud, double longitud, String ciudad) async {

    final oRequest = {
      "usuario" : usuario,
      "latitud" : latitud,
      "longitud": longitud,
      "ciudad" : ciudad,
    };
      final url =
        "${AppConfig.api_host}/rest/campana?usuario=${oRequest['usuario']}&latitud=${oRequest['latitud']}&longitud=${oRequest['longitud']}&ciudad=${oRequest['ciudad']}";
    final resp =
        await http.get(url, headers: {'Content-Type': 'application/json',
        'Authorization': AppConfig.autentificacion}
        );

    final Map<String, dynamic> decodedData =
        json.decode(utf8.decode(resp.bodyBytes)); //json.decode(resp.body);
        print(decodedData);
    final List<CampaniaModel> campania = new List();
    if (decodedData == null) {
      return [];
    } else if (decodedData["CampanaResponse"]["Detalle"]["Mensaje"]["codigoMensaje"] != "000") {
      return [];
    } else if(decodedData["CampanaResponse"]["Detalle"]["Mensaje"]["codigoMensaje"] == "000") {
      decodedData["CampanaResponse"]["Detalle"]["Datos"].forEach((camp) {
        print(camp);
        final campaniaTemp = CampaniaModel.fromJson(camp);
        campaniaTemp.id = camp["id"];
        campania.add(campaniaTemp);
      });
    }

    return campania;
  }
}
