import 'dart:convert';
import 'package:toyota_scp_mobile_apphino/src/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:toyota_scp_mobile_apphino/src/models/noticia_model.dart';

class NoticiasProvider{
  //Crear meotod crear grupFamdad
  //Retornar -> Lista de Ciudades

  Future<List<NoticiaModel>> cargarNoticias(String usuario) async {

    // final oRequest = {
    //   "usuario" : "wguill@gmail.com",
    // };
      final url =
        "${AppConfig.api_host}/rest/noticia?usuario=$usuario";
    final resp =
        await http.get(url, headers: {'Content-Type': 'application/json',
        'Authorization': AppConfig.autentificacion}
        );

    final Map<String, dynamic> decodedData =
        json.decode(utf8.decode(resp.bodyBytes)); //json.decode(resp.body);
        print(decodedData);
    final List<NoticiaModel> noticia = new List();
    if (decodedData == null) {
      return [];
    } else if (decodedData["NoticiaResponse"]["Detalle"]["Mensaje"]["codigoMensaje"] != "000") {
      return [];
    } else if(decodedData["NoticiaResponse"]["Detalle"]["Mensaje"]["codigoMensaje"] == "000") {
      decodedData["NoticiaResponse"]["Detalle"]["Datos"].forEach((not) {
        print(not);
        final noticiaTemp = NoticiaModel.fromJson(not);
        // noticiaTemp.id = not["id"];
        noticia.add(noticiaTemp);
      });
    }

    return noticia;
  }
}
