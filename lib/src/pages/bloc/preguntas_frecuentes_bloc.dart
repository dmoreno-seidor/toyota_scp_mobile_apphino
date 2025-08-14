// import 'dart:io';

import 'package:rxdart/subjects.dart';
import 'package:toyota_scp_mobile_apphino/src/models/preguntas_frecuentes_model.dart';
// import 'package:toyota_scp_mobile_apphino/src/models/tipo_documento_model.dart';
import 'package:toyota_scp_mobile_apphino/src/providers/preguntas_frecuentes_provider.dart';
// import 'package:toyota_scp_mobile_apphino/src/providers/tipo_documento_provider.dart';

class PreguntasFrecuentesBloc{
  final _preguntasFrecuentesController = new BehaviorSubject<List<PreguntasFrecuentesModel>>();
  final _cargandoController = new BehaviorSubject<bool>();
  final _preguntasFrecuentesProvider = new PreguntasFrecuentesProvider();

  Stream<List<PreguntasFrecuentesModel>> get preguntasFrecuentesStream => _preguntasFrecuentesController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  void cargarPreguntasFrecuentes() async{
    final preguntasFrecuentes = await _preguntasFrecuentesProvider.cargarPreguntasFrecuentes();
    _preguntasFrecuentesController.sink.add(preguntasFrecuentes);
  }
  
  dispose() {
    _preguntasFrecuentesController?.close();
    _cargandoController?.close();
  }

}





