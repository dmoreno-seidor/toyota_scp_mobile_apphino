// import 'dart:io';

import 'package:rxdart/subjects.dart';
// import 'package:toyota_scp_mobile_apphino/src/models/ciudad_model.dart';
import 'package:toyota_scp_mobile_apphino/src/models/grupo_familia_model.dart';
// import 'package:toyota_scp_mobile_apphino/src/providers/ciudad_provider.dart';
import 'package:toyota_scp_mobile_apphino/src/providers/grupo_familia_provider.dart';

class GrupoFamiliaBloc{
  final _grupoFamiliasController = new BehaviorSubject<List<GrupoFamiliaModel>>();
  final _cargandoController = new BehaviorSubject<bool>();
  final _grupoFamiliasProvider = new GrupoFamiliaProvider();

  Stream<List<GrupoFamiliaModel>> get grupoFamiliasStream => _grupoFamiliasController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  void cargarGrupoFamilias() async{
    final grupoFamilias = await _grupoFamiliasProvider.cargarGrupoFamilias();
    _grupoFamiliasController.sink.add(grupoFamilias);
  }
  
  dispose() {
    _grupoFamiliasController?.close();
    _cargandoController?.close();
  }

}





