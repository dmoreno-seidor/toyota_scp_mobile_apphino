// import 'dart:io';
import 'dart:convert';
import 'package:rxdart/subjects.dart';
// import 'package:toyota_scp_mobile_apphino/src/models/ciudad_model.dart';
import 'package:toyota_scp_mobile_apphino/src/models/encuesta_model.dart';
// import 'package:toyota_scp_mobile_apphino/src/models/grupo_familia_model.dart';
// import 'package:toyota_scp_mobile_apphino/src/providers/ciudad_provider.dart';
// import 'package:toyota_scp_mobile_apphino/src/providers/encuesta_provider.dart';
// import 'package:toyota_scp_mobile_apphino/src/providers/grupo_familia_provider.dart';

class EncuestaBloc{
  final _encuestaController = new BehaviorSubject<List<EncuestaModel>>();
  final _cargandoController = new BehaviorSubject<bool>();
  // final _encuestaProvider = new EncuestaProvider();
  final _inicioEncuestaController = new BehaviorSubject<int>.seeded(0);
  final _finalEncuestaController = new BehaviorSubject<int>.seeded(0);
  final _posisEncuestaController = new BehaviorSubject<int>.seeded(0);

  Stream<List<EncuestaModel>> get encuestaStream => _encuestaController.stream;
  Stream<int> get inicioEncuestaStream => _inicioEncuestaController.stream;
  Stream<int> get finalEncuestaStream => _finalEncuestaController.stream;
  Stream<int> get posiEncuestaStream => _finalEncuestaController.stream;
  Stream<bool> get cargando => _cargandoController.stream;
  
  //Agregar valores
  Function(int) get changeUltimaPosi => _posisEncuestaController.sink.add;

  //Obtener ultimo valor
  List<EncuestaModel> get aEncuestasLastValue => _encuestaController.value;
  int get inicioEncuestaLastValue => _inicioEncuestaController.value;
  int get finalFinalEncuestaLastValue => _finalEncuestaController.value;
  int get finalPosiEncuestaLastValue => _posisEncuestaController.value;

  void cargarEncuestas(info) async{
    print(info);
    // final encuestasFinal = await _encuestaProvider.cargarEncuestas(info["encuestas"]);
    _finalEncuestaController.add(jsonDecode(info["encuestas"]).length);
    List<EncuestaModel> listaEncuesta = new List();
    jsonDecode(info["encuestas"]).forEach((x){
       print(x);
        final temp = EncuestaModel.fromJson(x);
        // grupFamdadTemp.id = grupFam["ID"];
        listaEncuesta.add(temp);
    });
    _encuestaController.sink.add(listaEncuesta);
  }
  
  dispose() {
    _encuestaController?.close();
    _cargandoController?.close();
  }

}





