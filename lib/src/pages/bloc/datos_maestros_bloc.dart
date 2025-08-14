// Observable<bool> stream1;
// Observable<String> stream2;

// final fusion = stream1.withLatestFrom(stream2, (foo, bar) {
//   return MyClass(foo: foo, bar: bar);
// });

import 'dart:async';
import 'package:toyota_scp_mobile_apphino/src/models/cargo_usuario_model.dart';
import 'package:toyota_scp_mobile_apphino/src/models/datos_maestros_model.dart';
import 'package:toyota_scp_mobile_apphino/src/models/tipo_documento_model.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:toyota_scp_mobile_apphino/src/providers/cargo_usuario_provider.dart';
import 'package:toyota_scp_mobile_apphino/src/providers/tipo_documento_provider.dart';

class DatosMaestrosBloc with Validators {
  final _tipoDocumentosController = BehaviorSubject<List<TipoDocumentoModel>>();
  final _cargoUsuariosController = BehaviorSubject<List<CargoUsuarioModel>>();
  final _tipoDocumentoProvider = new TipoDocumentoProvider();
  final _cargoUsuarioProvider = new CargoUsuarioProvider();

  //Recuperar los datos del Stream

  void cargarTipoDocumento() async {
    final tipoDocumentos = await _tipoDocumentoProvider.cargarTipoDocumento();
    _tipoDocumentosController.sink.add(tipoDocumentos);
  }

  void cargarCargoUsuario() async {
    final cargoUsuarios = await _cargoUsuarioProvider.cargarCargoUsuario();
    _cargoUsuariosController.sink.add(cargoUsuarios);
  }

  Stream<List<TipoDocumentoModel>> get tipoDocumentosStream =>
      _tipoDocumentosController.stream;
  Stream<List<CargoUsuarioModel>> get cargoUsuariosController =>
      _cargoUsuariosController.stream;

  Stream<DatosMaestroModel> get obtenerMaestros =>
      Rx.combineLatest2(tipoDocumentosStream, cargoUsuariosController,
          (tipoDocumentos, cargoUsuarios) {
        var datosMaestroModel = DatosMaestroModel(
            tipoDocumentos: tipoDocumentos, cargoUsuarios: cargoUsuarios);
        return datosMaestroModel;
      });

  dispose() {
    _tipoDocumentosController?.close();
    _cargoUsuariosController?.close();
  }
}
