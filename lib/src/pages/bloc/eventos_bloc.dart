// import 'dart:io';

import 'package:rxdart/subjects.dart';
import 'package:toyota_scp_mobile_apphino/src/models/evento_model.dart';
import 'package:toyota_scp_mobile_apphino/src/providers/eventos_provider.dart';



class EventosBloc{
  final _eventosController = new BehaviorSubject<List<EventoModel>>();
  final _cargandoController = new BehaviorSubject<bool>();
  final _eventosProvider = new EventosProvider();

  Stream<List<EventoModel>> get eventosStream => _eventosController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  void cargarEventos(String usuario) async{
    final eventos = await _eventosProvider.cargarEventos(usuario);
   
    _eventosController.sink.add(eventos);
  }
  
  dispose() {
    _eventosController?.close();
    _cargandoController?.close();
  }

}





