import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

import '../../models/concesionario_model.dart';
import '../../providers/catalogo_provider.dart';

/// @author Daniel Carpio
class CitasBloc {
  final _concesionarioController = new BehaviorSubject<List<ConcesionarioModel>>();
  final _cargandoController = new BehaviorSubject<bool>();
  final _catalogoProvider = new CatalogoProvider();
  final _sFiltroCiudadController = BehaviorSubject<String>.seeded('');
  final _sFiltroServiciosController = BehaviorSubject<String>.seeded('');

  Stream<List<ConcesionarioModel>> get concesionarioStream => _concesionarioController.stream;
  Stream<bool> get cargando => _cargandoController.stream;
   Stream<String> get sFiltroCiudadStream => _sFiltroCiudadController.stream;
   Stream<String> get sFiltroServiciosStream => _sFiltroServiciosController.stream;


  Function(String) get changeCiudad => _sFiltroCiudadController.sink.add;
  Function(String) get changeServicios => _sFiltroServiciosController.sink.add;

  String get sFiltroCiudad => _sFiltroCiudadController.value;
  String get sFiltroServicios => _sFiltroServiciosController.value;



  Stream<List<ConcesionarioModel>> get filterConcesionarios =>
      Rx.combineLatest3(concesionarioStream, sFiltroCiudadStream, sFiltroServiciosStream,  (concesionarios, filterCiudad,filterServicios) {
        List<ConcesionarioModel> concesionariosModelFiltrado =  new List<ConcesionarioModel>();
        concesionariosModelFiltrado = [];
        List<ConcesionarioModel> aDatosConcesionarioFiltrado =
            new List<ConcesionarioModel>();
        if (filterCiudad.isNotEmpty || filterServicios.isNotEmpty) {
          if(filterCiudad.isNotEmpty){
              concesionarios.forEach((item) {
                if (item.ciudad == filterCiudad) {
                  aDatosConcesionarioFiltrado.add(item);
                }
              });
              concesionariosModelFiltrado = aDatosConcesionarioFiltrado;
          }else{
            concesionariosModelFiltrado = concesionarios;
          }
          // return [];
          if(filterServicios.isNotEmpty){
            aDatosConcesionarioFiltrado = [];
               concesionariosModelFiltrado.forEach((item) {
                  //  print();
                     print("asdsad");
            String servicio = item.servicios.split(",")[0];
            List servicios;
            if (filterServicios.contains(",")) {
              servicios = filterServicios.split(",");
              servicios.forEach((x) {
                if (item.servicios.contains(x)) {
                  aDatosConcesionarioFiltrado.add(item);
                }
              });
            } else {
              if (item.servicios.contains(filterServicios)) {
                aDatosConcesionarioFiltrado.add(item);
              }
            }
              
          });
        concesionariosModelFiltrado = aDatosConcesionarioFiltrado;
              
          }
          return concesionariosModelFiltrado;
        } else {
          return concesionarios;
        }
      });

  void consultarConcesionarioxCiudadxServicios(
      String ciudad, String servicios, double latitud, double longitud) async {
    final concesionario = await _catalogoProvider.consultarConcesionarioxCiudadxServicios(
        ciudad, servicios, latitud, longitud);
    _concesionarioController.sink.add(concesionario);
  }

  dispose() {
    _concesionarioController?.close();
    _cargandoController?.close();
  }
}
