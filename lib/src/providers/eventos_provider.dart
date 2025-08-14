import 'dart:convert';
import 'package:toyota_scp_mobile_apphino/src/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:toyota_scp_mobile_apphino/src/models/evento_model.dart';


class EventosProvider{
  //Crear meotod crear grupFamdad
  //Retornar -> Lista de Ciudades

  Future<List<EventoModel>> cargarEventos(String usuario) async {

    // final oRequest = {
    //   "usuario" : usuario,
    // };
      // final url =
      //   "${AppConfig.api_host}/rest/evento?usuario=${oRequest['usuario']}";
      final url =
        "${AppConfig.api_host}/rest/evento?usuario=$usuario";
    final resp =
        await http.get(url, headers: {'Content-Type': 'application/json',
        'Authorization': AppConfig.autentificacion}
        );

    final Map<String, dynamic> decodedData =
        json.decode(utf8.decode(resp.bodyBytes)); //json.decode(resp.body);
        print(decodedData);
    final List<EventoModel> evento = new List();
    if (decodedData == null) {
      return [];
    } else if (decodedData["EventoResponse"]["Detalle"]["Mensaje"]["codigoMensaje"] != "000") {
      return [];
    } else if(decodedData["EventoResponse"]["Detalle"]["Mensaje"]["codigoMensaje"] == "000") {
      int unique = 0;
      decodedData["EventoResponse"]["Detalle"]["Datos"].forEach((event) {
        print(event);
        final eventoTemp = EventoModel.fromJson(event);
        eventoTemp.unique =unique.toString();
        evento.add(eventoTemp);
        unique++;
      });
    }

    return evento;
  }
}
