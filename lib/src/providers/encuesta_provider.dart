
// import 'dart:convert';
// import 'package:toyota_scp_mobile_apphino/src/app_config.dart';
// import 'package:http/http.dart' as http;
import 'package:toyota_scp_mobile_apphino/src/models/encuesta_model.dart';
// import 'package:toyota_scp_mobile_apphino/src/models/grupo_familia_model.dart';
class EncuestaProvider{
  //Crear meotod crear grupFamdad
  //Retornar -> Lista de Ciudades

  Future<List<EncuestaModel>> cargarEncuestas(List encuestas) async {     
    final List<EncuestaModel> encuestasFinal = encuestas;
    return encuestasFinal;
  }
}