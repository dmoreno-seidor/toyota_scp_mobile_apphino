
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toyota_scp_mobile_apphino/src/app_config.dart';
import 'package:toyota_scp_mobile_apphino/src/models/preguntas_frecuentes_model.dart';
class PreguntasFrecuentesProvider{
  //Crear meotod crear ciudad
  //Retornar -> Lista de preguntasFrecuentes

  Future<List<PreguntasFrecuentesModel>> cargarPreguntasFrecuentes() async {
      final url =
        "${AppConfig.api_host}/core/appMasters/service/ODataService.xsodata/VPregunta_Frecuente?\$format=json";
    final resp =
        await http.get(url, headers: {'Content-Type': 'application/json'});

    final Map<String, dynamic> decodedData =
        json.decode(utf8.decode(resp.bodyBytes)); //json.decode(resp.body);
    final List<PreguntasFrecuentesModel> preguntasFrecuentes = new List();
    
    if (decodedData == null) {
      return [];
    } else if (decodedData['error'] != null) {
      return [];
    } else {
      
      decodedData["d"]["results"].forEach((pre) {
        print(pre);
        final pregTemp = PreguntasFrecuentesModel.fromJson(pre);
        if(pregTemp.idEstado == 101){
          preguntasFrecuentes.add(pregTemp);
        }
      });
    }

    return preguntasFrecuentes;
  }
}