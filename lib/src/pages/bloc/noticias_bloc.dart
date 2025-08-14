// import 'dart:io';

import 'package:rxdart/subjects.dart';
import 'package:toyota_scp_mobile_apphino/src/models/noticia_model.dart';
import 'package:toyota_scp_mobile_apphino/src/providers/noticias_provider.dart';


class NoticiasBloc{
  final _noticiasController = new BehaviorSubject<List<NoticiaModel>>();
  final _cargandoController = new BehaviorSubject<bool>();
  final _noticiasProvider = new NoticiasProvider();

  Stream<List<NoticiaModel>> get noticiasStream => _noticiasController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  void cargarNoticias(String usuario) async{
    final noticias = await _noticiasProvider.cargarNoticias(usuario);
    _noticiasController.sink.add(noticias);
  }
  
  dispose() {
    _noticiasController?.close();
    _cargandoController?.close();
  }

}





