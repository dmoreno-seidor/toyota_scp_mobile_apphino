import 'dart:async';
import 'package:toyota_scp_mobile_apphino/src/models/anio_filtro_model.dart';
// import 'package:toyota_scp_mobile_apphino/src/models/concesionario_maestro_model.dart';
// import 'package:toyota_scp_mobile_apphino/src/models/mis_premios_model.dart';
import 'package:toyota_scp_mobile_apphino/src/models/mis_servicios_model.dart';
// import 'package:toyota_scp_mobile_apphino/src/models/premio_canjeado_model.dart';
import 'package:toyota_scp_mobile_apphino/src/models/servicio_model.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';
// import 'package:toyota_scp_mobile_apphino/src/providers/mis_premios_provider.dart';
import 'package:toyota_scp_mobile_apphino/src/providers/mis_servicios_provider.dart';

class MisServiciosBloc with Validators {
  //----
  final _aMisServiciosController = BehaviorSubject<MisServiciosModel>();
  // final _placaServicioController = new BehaviorSubject<List<ServicioModel>>();
  // final _aConcesionarioMisPremiosController = BehaviorSubject<List<ConcesionarioMaestroModel>>();
  final _misServiciosProvider = new MisServiciosProvider();
  final _sFilterPlacaController = BehaviorSubject<String>.seeded('');

  final _aAnioController = BehaviorSubject<List<AnioFiltro>>();
  final _sFilterAnioController = BehaviorSubject<String>.seeded('');
  final _sFilterRespuestaAnioController= BehaviorSubject<String>.seeded('');

  Stream<MisServiciosModel> get aMisServiciosStream => _aMisServiciosController.stream;
  // Stream<List<ServicioModel>> get oPlacaSeleccionadaStream => _oPlacaServicioController.stream;
  // Function(ServicioModel) get changePlacaSeleccionada => _placaSeleccionadaController.sink.add;
  // ServicioModel get oPlacaSeleccionada => _placaSeleccionadaController.value;
  // Stream<List<ConcesionarioMaestroModel>> get aConcesionarioMisPremiosStream => _aConcesionarioMisPremiosController.stream;
  
  
  
  
  Stream<List<AnioFiltro>> get aAnioStream => _aAnioController.stream;
  Stream<String> get sFilterPlacaStream => _sFilterPlacaController.stream;//tuberia


  Stream<String> get sFilterAnioStream => _sFilterAnioController.stream;

  Function(String) get changePlaca => _sFilterPlacaController.sink.add;//entrada

  Function(String) get changeAnio => _sFilterAnioController.sink.add;
  Function(String) get changeRespuestaAnio => _sFilterRespuestaAnioController.sink.add;

  String get sFilterAnioLastValue => _sFilterAnioController.value;
  String get sFilterRespuestaAnioLastValue => _sFilterRespuestaAnioController.value;
  List<AnioFiltro> get aAnioLastValue => _aAnioController.value;
  MisServiciosModel get aMisServiciosLastValue => _aMisServiciosController.value;

  Stream<MisServiciosModel> get filterAservicios =>
      Rx.combineLatest3(aMisServiciosStream, sFilterPlacaStream, sFilterAnioStream,  (misServicios, filter,filterAnio) {
        MisServiciosModel misServiciosModelFiltrado =  new MisServiciosModel();
        misServiciosModelFiltrado.fechaUltimoServicio =misServicios.fechaUltimoServicio;
        misServiciosModelFiltrado.totServicios =misServicios.totServicios;
        misServiciosModelFiltrado.servicios = [];
    
        if (filter.isNotEmpty || filterAnio.isNotEmpty) {
              List<ServicioModel> aDatosServicioFiltrado =
            new List<ServicioModel>();
          if(filter.isNotEmpty){
              misServicios.servicios.forEach((item) {
                if (item.placa == filter) {
                  aDatosServicioFiltrado.add(item);
                }
              });
              
              misServiciosModelFiltrado.servicios = aDatosServicioFiltrado;
          }else{
            misServiciosModelFiltrado.servicios = misServicios.servicios;
          }

          aDatosServicioFiltrado =
            new List<ServicioModel>();

          if(filterAnio.isNotEmpty){
              misServiciosModelFiltrado.servicios.forEach((item) {
                if (item.fecha.split("/")[2] == filterAnio) {
                  aDatosServicioFiltrado.add(item);
                }
              });
              misServiciosModelFiltrado.servicios = aDatosServicioFiltrado;
          }
          return misServiciosModelFiltrado;
        } else {
          return misServicios;
        }
      });
  void cargarMisServicios(String correo) async{
    final misServicios = await _misServiciosProvider.cargarMisServicios(correo);
    if(misServicios!=null){
       obtenerAnios(misServicios);
    }
   
    _aMisServiciosController.sink.add(misServicios);
  }

  void obtenerAnios(MisServiciosModel misServicios){
   
    
    List<AnioFiltro> listAnioFiltro = new List<AnioFiltro>();
    List<AnioFiltro> listAnioFiltroFinal = new List<AnioFiltro>();
    misServicios.servicios.forEach((x){
       AnioFiltro anioFiltro = new AnioFiltro();
      anioFiltro.anio = x.fecha.split("/")[2];
      anioFiltro.isSelected = false;
      listAnioFiltro.add(anioFiltro);
    });
  var uniqueListAnioFiltro = listAnioFiltro.map<String>(
    (c) => c.anio as String)
    .toSet().toList();
    AnioFiltro anioFiltroFinal = new AnioFiltro();
      anioFiltroFinal.anio = "Todos";
      anioFiltroFinal.isSelected = true;
      listAnioFiltroFinal.add(anioFiltroFinal);
    uniqueListAnioFiltro.forEach((x){
      AnioFiltro anioFiltroFinal = new AnioFiltro();
      anioFiltroFinal.anio = x;
      anioFiltroFinal.isSelected = false;
      listAnioFiltroFinal.add(anioFiltroFinal);
    });
    Comparator<AnioFiltro> anioSort = (a, b) => b.anio.compareTo(a.anio);
    listAnioFiltroFinal.sort(anioSort);
    _aAnioController.sink.add(listAnioFiltroFinal);
  }

  

  dispose() {
    _aMisServiciosController?.close();
    _sFilterPlacaController?.close();
  }
}
