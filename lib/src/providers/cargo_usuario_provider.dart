import 'dart:convert';

import 'package:toyota_scp_mobile_apphino/src/models/cargo_usuario_model.dart';
// import 'package:toyota_scp_mobile_apphino/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

import '../app_config.dart';

class CargoUsuarioProvider {
  // final String _firebaseToken = 'AIzaSyBCRQuT-TpLdswdvpGEq3FyhPoS5gzeXis';
  // final _prefs = new PreferenciasUsuario();

  Future<List<CargoUsuarioModel>> cargarCargoUsuario() async {
    final url =
        "${AppConfig.api_host}/core/appMasters/service/ODataService.xsodata/VTipo_Usuario?\$format=json";
    final resp =
        await http.get(url, headers: {'Content-Type': 'application/json'});

    final Map<String, dynamic> decodedData =
        json.decode(utf8.decode(resp.bodyBytes)); //json.decode(resp.body);
    final List<CargoUsuarioModel> cargoUsuarios = new List();
    if (decodedData == null) {
      return [];
    } else if (decodedData['error'] != null) {
      return [];
    } else {
      decodedData["d"]["results"].forEach((obj) {
        print(obj);
        final cargoUsuarioTemp = CargoUsuarioModel.fromJson(obj);
        //  cargoUsuarioTemp.id = obj["ID"];
        if(obj["ESTADO"]=="Activo"){
        cargoUsuarios.add(cargoUsuarioTemp);
        }
      });
    }

    return cargoUsuarios;
  }
}
