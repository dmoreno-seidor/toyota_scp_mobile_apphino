import 'dart:async';
import 'package:toyota_scp_mobile_apphino/src/models/anio_filtro_model.dart';
import 'package:toyota_scp_mobile_apphino/src/models/concesionario_maestro_model.dart';
import 'package:toyota_scp_mobile_apphino/src/models/mis_premios_model.dart';
import 'package:toyota_scp_mobile_apphino/src/models/premio_canjeado_model.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:toyota_scp_mobile_apphino/src/providers/mis_premios_provider.dart';

class MisPremiosBloc with Validators {
  //----
  final _aMisPremiosController = BehaviorSubject<MisPremiosModel>();
  final _aConcesionarioMisPremiosController = BehaviorSubject<List<ConcesionarioMaestroModel>>();
  final _misPremiosProvider = new MisPremiosProvider();
  final _sFilterController = BehaviorSubject<String>.seeded('');
  final _aAnioController = BehaviorSubject<List<AnioFiltro>>();
  final _sFilterAnioController = BehaviorSubject<String>.seeded('');
  final _sFilterRespuestaAnioController= BehaviorSubject<String>.seeded('');

  Stream<MisPremiosModel> get aMisPremiosStream => _aMisPremiosController.stream;
  Stream<List<ConcesionarioMaestroModel>> get aConcesionarioMisPremiosStream => _aConcesionarioMisPremiosController.stream;
  Stream<List<AnioFiltro>> get aAnioStream => _aAnioController.stream;
  Stream<String> get sFilterStream => _sFilterController.stream;
  Stream<String> get sFilterAnioStream => _sFilterAnioController.stream;

  Function(String) get changeConcesionarioPremio => _sFilterController.sink.add;
  Function(String) get changeAnio => _sFilterAnioController.sink.add;
  Function(String) get changeRespuestaAnio => _sFilterRespuestaAnioController.sink.add;

  String get sFilterAnioLastValue => _sFilterAnioController.value;
  String get sFilterRespuestaAnioLastValue => _sFilterRespuestaAnioController.value;
  List<AnioFiltro> get aAnioLastValue => _aAnioController.value;
  MisPremiosModel get aMisPremiosLastValue => _aMisPremiosController.value;

  Stream<MisPremiosModel> get filterMisPremios =>
      Rx.combineLatest3(aMisPremiosStream, sFilterStream, sFilterAnioStream,  (misPremios, filter,filterAnio) {
        MisPremiosModel misPremiosModelFiltrado =  new MisPremiosModel();
        misPremiosModelFiltrado.fechaUltimoCanje =misPremios.fechaUltimoCanje;
        misPremiosModelFiltrado.totPremios =misPremios.totPremios;
        misPremiosModelFiltrado.premios = [];
        List<PremioCanjeadoModel> aDatosPremiosCanjeadoFiltrado =
            new List<PremioCanjeadoModel>();
        if (filter.isNotEmpty || filterAnio.isNotEmpty) {
          if(filter.isNotEmpty){
              misPremios.premios.forEach((item) {
                if (item.idConcesionario == filter) {
                  aDatosPremiosCanjeadoFiltrado.add(item);
                }
              });
              misPremiosModelFiltrado.premios = aDatosPremiosCanjeadoFiltrado;
          }else{
            misPremiosModelFiltrado.premios = misPremios.premios;
          }

          if(filterAnio.isNotEmpty){
              misPremiosModelFiltrado.premios.forEach((item) {
                if (item.fecha.split("/")[2] == filterAnio) {
                  aDatosPremiosCanjeadoFiltrado.add(item);
                }
              });
              misPremiosModelFiltrado.premios = aDatosPremiosCanjeadoFiltrado;
          }
          return misPremiosModelFiltrado;
        } else {
          return misPremios;
        }
      });
  void cargarMisPremios(String correo) async{
    final misPremios = await _misPremiosProvider.cargarMisPremios(correo);
    if(misPremios!=null){
       obtenerAnios(misPremios);
    }
   
    _aMisPremiosController.sink.add(misPremios);
  }

  void obtenerAnios(MisPremiosModel misPremios){
   
    
    List<AnioFiltro> listAnioFiltro = new List<AnioFiltro>();
    List<AnioFiltro> listAnioFiltroFinal = new List<AnioFiltro>();
    misPremios.premios.forEach((x){
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

  void cargarConcesionarioMisPremios() async{
    final concesionaioMisPremios = await _misPremiosProvider.cargarConcesionarioMisPremios();
    _aConcesionarioMisPremiosController.sink.add(concesionaioMisPremios);
  }

  dispose() {
    _aMisPremiosController?.close();
    _sFilterController?.close();
  }
}
