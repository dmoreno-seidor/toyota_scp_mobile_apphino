// import 'dart:io';

import 'package:rxdart/subjects.dart';
import 'package:toyota_scp_mobile_apphino/src/models/tipo_documento_model.dart';
import 'package:toyota_scp_mobile_apphino/src/providers/tipo_documento_provider.dart';

class TipoDocumentoBloc {
  final _tipoDocumentosController =
      new BehaviorSubject<List<TipoDocumentoModel>>();
  final _cargandoController = new BehaviorSubject<bool>();

  final _tipoDocumentoProvider = new TipoDocumentoProvider();

  Stream<List<TipoDocumentoModel>> get tipoDocumentosStream =>
      _tipoDocumentosController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  void cargarTipoDocumento() async {
    final tipoDocumentos = await _tipoDocumentoProvider.cargarTipoDocumento();
    _tipoDocumentosController.sink.add(tipoDocumentos);
  }

  

  dispose() {
    _tipoDocumentosController?.close();
    _cargandoController?.close();
  }
}
