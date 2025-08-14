import 'dart:convert';

import 'package:toyota_scp_mobile_apphino/src/app_config.dart';
import 'package:toyota_scp_mobile_apphino/src/models/tipo_documento_model.dart';
// import 'package:toyota_scp_mobile_apphino/src/pages/bloc/datos_maestros_bloc.dart';
// import 'package:toyota_scp_mobile_apphino/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class TipoDocumentoProvider {
  // final String _firebaseToken = 'AIzaSyBCRQuT-TpLdswdvpGEq3FyhPoS5gzeXis';
  // final _prefs = new PreferenciasUsuario();

  Future<List<TipoDocumentoModel>> cargarTipoDocumento() async {
    final url =
        "${AppConfig.api_host}/core/appMasters/service/ODataService.xsodata/VTipo_documento?\$format=json";
    final resp =
        await http.get(url, headers: {'Content-Type': 'application/json'});

    final Map<String, dynamic> decodedData =
        json.decode(utf8.decode(resp.bodyBytes)); //json.decode(resp.body);
    final List<TipoDocumentoModel> tipoDocumentos = new List();
    if (decodedData == null) {
      return [];
    } else if (decodedData['error'] != null) {
      return [];
    } else {
      decodedData["d"]["results"].forEach((prod) {
        print(prod);
        final tipoDocumentoTemp = TipoDocumentoModel.fromJson(prod);
        // tipoDocumentoTemp.id = prod["ID"];
        if(prod["ESTADO"]=="Activo"){
            tipoDocumentos.add(tipoDocumentoTemp);
        }
        
      });
    }

    return tipoDocumentos;
  }
}
