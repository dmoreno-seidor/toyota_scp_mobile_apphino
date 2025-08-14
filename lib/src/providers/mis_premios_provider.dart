
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toyota_scp_mobile_apphino/src/models/concesionario_maestro_model.dart';
// import 'package:toyota_scp_mobile_apphino/src/models/concesionario_model.dart';
import 'package:toyota_scp_mobile_apphino/src/models/mis_premios_model.dart';
import 'package:toyota_scp_mobile_apphino/src/models/premio_canjeado_model.dart';

import '../app_config.dart';
class MisPremiosProvider{
  //Crear meotod crear ciudad
  //Retornar -> Lista de Ciudades

  Future<MisPremiosModel> cargarMisPremios(String correo) async {
      final url =
        "${AppConfig.api_host}/rest/premio/canje?usuario=$correo";
    final resp =
        await http.get(url, headers: {'Content-Type': 'application/json',
        'Authorization': AppConfig.autentificacion});

    final Map<String, dynamic> decodedData =
        json.decode(utf8.decode(resp.bodyBytes)); // json.decode(resp.body);
     MisPremiosModel misPremiosModel = new MisPremiosModel();
     final List<PremioCanjeadoModel> listPremioCanjeadoModel = new List();


    if (decodedData == null) {
      return null;
    } else if (decodedData["CanjeResponse"]["Detalle"]["Mensaje"]["codigoMensaje"] != "000") {

      misPremiosModel.totPremios = decodedData["CanjeResponse"]["Detalle"]["Datos"]["totPremios"];
      misPremiosModel.fechaUltimoCanje = decodedData["CanjeResponse"]["Detalle"]["Datos"]["fechaUltimoCanje"];
      misPremiosModel.premios = new List<PremioCanjeadoModel>();
      decodedData["CanjeResponse"]["Detalle"]["Datos"]["premios"].forEach((x){
        print(x);
        final premioCanjeadoTemp = PremioCanjeadoModel.fromJson(x);
        // grupFamdadTemp.id = grupFam["ID"];
        listPremioCanjeadoModel.add(premioCanjeadoTemp);
      });
      misPremiosModel.premios = listPremioCanjeadoModel;
      return misPremiosModel;
    } else if(decodedData["CanjeResponse"]["Detalle"]["Mensaje"]["codigoMensaje"] == "000") {
      // misPremiosModel = MisPremiosModel.fromJson(decodedData["CanjeResponse"]["Detalle"]["Datos"]);
      
      misPremiosModel.totPremios = decodedData["CanjeResponse"]["Detalle"]["Datos"]["totPremios"];
      misPremiosModel.fechaUltimoCanje = decodedData["CanjeResponse"]["Detalle"]["Datos"]["fechaUltimoCanje"];
      misPremiosModel.premios = new List<PremioCanjeadoModel>();
      decodedData["CanjeResponse"]["Detalle"]["Datos"]["premios"].forEach((x){
        print(x);
        final premioCanjeadoTemp = PremioCanjeadoModel.fromJson(x);
        // grupFamdadTemp.id = grupFam["ID"];
        listPremioCanjeadoModel.add(premioCanjeadoTemp);
      });
      misPremiosModel.premios = listPremioCanjeadoModel;
    return misPremiosModel;
    }

    
  }

  Future<List<ConcesionarioMaestroModel>> cargarConcesionarioMisPremios() async {
  
      final url =
        "${AppConfig.api_host}/core/appMasters/service/ODataService.xsodata/VConcesionario?\$format=json";
    final resp =
        await http.get(url, headers: {'Content-Type': 'application/json',
        'Authorization': AppConfig.autentificacion});

    final Map<String, dynamic> decodedData =
        json.decode(utf8.decode(resp.bodyBytes)); // json.decode(resp.body);
    //  MisPremiosModel misPremiosModel = new MisPremiosModel();
     final List<ConcesionarioMaestroModel> listConcesionarioModel = new List();


    if (decodedData == null) {
      return [];
    } else if (decodedData["d"]["results"].length==0) {
      return [];
    } else if(decodedData["d"]["results"].length>0) {
      // misPremiosModel = MisPremiosModel.fromJson(decodedData["CanjeResponse"]["Detalle"]["Datos"]);
      
      // 
      decodedData["d"]["results"].forEach((x){
        print(x);
        final concesionarioModelTemp = ConcesionarioMaestroModel.fromJson(x);
        if(x["ESTADO"]=="Activo"){
            listConcesionarioModel.add(concesionarioModelTemp);
        }
        
        // grupFamdadTemp.id = grupFam["ID"];
        
      });

    }

    return listConcesionarioModel;
  }


 
}