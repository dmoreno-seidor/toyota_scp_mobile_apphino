// import 'dart:io';
// import 'dart:convert';
import 'package:rxdart/subjects.dart';
// import 'package:toyota_scp_mobile_apphino/src/models/ciudad_model.dart';
import 'package:toyota_scp_mobile_apphino/src/models/respuesta_model.dart';
// import 'package:toyota_scp_mobile_apphino/src/models/grupo_familia_model.dart';
// import 'package:toyota_scp_mobile_apphino/src/models/respuesta_model.dart';
// import 'package:toyota_scp_mobile_apphino/src/providers/ciudad_provider.dart';
// import 'package:toyota_scp_mobile_apphino/src/providers/grupo_familia_provider.dart';
import 'package:toyota_scp_mobile_apphino/src/providers/respuesta_provider.dart';

class RespuestaBloc{
  final _aRespuestaController = new BehaviorSubject<List<RespuestaModel>>.seeded([]);
  final _respuestaProbider = RespuestaProvider();
  final _respuestaController = new BehaviorSubject<RespuestaModel>();
  final _cargandoController = new BehaviorSubject<bool>();

  Stream<List<RespuestaModel>> get aRespuestaStream => _aRespuestaController.stream;
  Function(RespuestaModel) get actualizarRepuesta => _respuestaController.sink.add;
  List<RespuestaModel> get aRespuestasLastValue => _aRespuestaController.value;
  void actualizarListaRespuesta(RespuestaModel respuestaModel){
    if(aRespuestasLastValue.length==0){
         List<RespuestaModel> aRespuestaModel = new List<RespuestaModel>();
        aRespuestaModel.add(respuestaModel);
        _aRespuestaController.sink.add(aRespuestaModel);
    }else{
      List<RespuestaModel> aRespuestaModel = aRespuestasLastValue;
        aRespuestaModel.add(respuestaModel);
        _aRespuestaController.sink.add(aRespuestaModel);
    }
   
    

  }
  Future<bool> guardarEncuesta(String idEncuesta, List<RespuestaModel> listaRespuestaModel) async{
    final respuestaEncuestaGuardar =  await _respuestaProbider.guardarEncuesta(idEncuesta,listaRespuestaModel);
     return respuestaEncuestaGuardar;
  }

  dispose() {
    _aRespuestaController?.close();
      _respuestaController?.close();
      _cargandoController?.close();
    _cargandoController?.close();
  }

}





