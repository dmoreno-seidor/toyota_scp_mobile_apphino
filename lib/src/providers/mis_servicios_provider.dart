
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:toyota_scp_mobile_apphino/src/models/concesionario_maestro_model.dart';
// import 'package:toyota_scp_mobile_apphino/src/models/concesionario_model.dart';
import 'package:toyota_scp_mobile_apphino/src/models/mis_servicios_model.dart';
import 'package:toyota_scp_mobile_apphino/src/models/servicio_model.dart';

import '../app_config.dart';
class MisServiciosProvider{
  //Crear meotod crear ciudad
  //Retornar -> Lista de Ciudades

  Future<MisServiciosModel> cargarMisServicios(String correo) async {
      final url =
        "${AppConfig.api_host}/rest/servicio?usuario=$correo";
        //https://hanamdcdevd532d2838.us2.hana.ondemand.com/toyota/rest/servicio
    final resp =
        await http.get(url, headers: {'Content-Type': 'application/json',
        'Authorization': AppConfig.autentificacion});

    final Map<String, dynamic> decodedData =
        json.decode(utf8.decode(resp.bodyBytes)); // json.decode(resp.body);
     MisServiciosModel misServiciosModel = new MisServiciosModel();
     final List<ServicioModel> listServicioModel= new List();

 
    if (decodedData == null) {
      return null;
    } else if (decodedData["ServicioResponse"]["Detalle"]["Mensaje"]["codigoMensaje"] != "000") {

      misServiciosModel.totServicios = decodedData["ServicioResponse"]["Detalle"]["Datos"]["totServicios"];
      misServiciosModel.fechaUltimoServicio = decodedData["ServicioResponse"]["Detalle"]["Datos"]["fechaUltimoServicio"];
      misServiciosModel.servicios = new List<ServicioModel>();
      decodedData["ServicioResponse"]["Detalle"]["Datos"]["servicios"].forEach((x){
        print(x);
        final serviciosTemp = ServicioModel.fromJson(x);
        // grupFamdadTemp.id = grupFam["ID"];
        listServicioModel.add(serviciosTemp);
      });
      misServiciosModel.servicios = listServicioModel;
      return misServiciosModel;
    } else if(decodedData["ServicioResponse"]["Detalle"]["Mensaje"]["codigoMensaje"] == "000") {
      // misPremiosModel = MisPremiosModel.fromJson(decodedData["ServicioResponse"]["Detalle"]["Datos"]);
      
      misServiciosModel.totServicios = decodedData["ServicioResponse"]["Detalle"]["Datos"]["totServicios"];
      misServiciosModel.fechaUltimoServicio = decodedData["ServicioResponse"]["Detalle"]["Datos"]["fechaUltimoServicio"];
      misServiciosModel.servicios = new List<ServicioModel>();
      decodedData["ServicioResponse"]["Detalle"]["Datos"]["servicios"].forEach((x){
        print(x);
        final serviciosTemp = ServicioModel.fromJson(x);
        // grupFamdadTemp.id = grupFam["ID"];
        listServicioModel.add(serviciosTemp);
      });
      misServiciosModel.servicios = listServicioModel;
    return misServiciosModel;
    }

    
  }

  // Future<List<ConcesionarioMaestroModel>> cargarConcesionarioMisServicios() async {
  
  //     final url =
  //       "${AppConfig.api_host}/core/appMasters/service/ODataService.xsodata/VConcesionario?\$format=json";
  //   final resp =
  //       await http.get(url, headers: {'Content-Type': 'application/json',
  //       'Authorization': AppConfig.autentificacion});

  //   final Map<String, dynamic> decodedData =
  //       json.decode(utf8.decode(resp.bodyBytes)); // json.decode(resp.body);
  //   //  MisPremiosModel misPremiosModel = new MisPremiosModel();
  //    final List<ConcesionarioMaestroModel> listConcesionarioModel = new List();


  //   if (decodedData == null) {
  //     return [];
  //   } else if (decodedData["d"]["results"].length==0) {
  //     return [];
  //   } else if(decodedData["d"]["results"].length>0) {
  //     // misPremiosModel = MisPremiosModel.fromJson(decodedData["ServicioResponse"]["Detalle"]["Datos"]);
      
  //     // 
  //     decodedData["d"]["results"].forEach((x){
  //       print(x);
  //       final concesionarioModelTemp = ConcesionarioMaestroModel.fromJson(x);
  //       if(x["ESTADO"]=="Activo"){
  //           listConcesionarioModel.add(concesionarioModelTemp);
  //       }
        
  //       // grupFamdadTemp.id = grupFam["ID"];
        
  //     });

  //   }

  //   return listConcesionarioModel;
  // }


 
}