
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

import '../../models/catalogo_model.dart';
import '../../models/concesionario_model.dart';
import '../../providers/catalogo_provider.dart';

class CatalogoBloc {
  final _catalogoController = BehaviorSubject<List<CatalogoModel>>();
  final _concesionarioController =
      BehaviorSubject<List<ConcesionarioModel>>();//.seeded([]);
  final _cargandoController = new BehaviorSubject<bool>();
  final _catalogoProvider = new CatalogoProvider();
  final _sFilterController = BehaviorSubject<String>.seeded('');
  final _codigoPremioController = BehaviorSubject<String>.seeded('');
  final _descripcionAdicionalTalla = BehaviorSubject<String>.seeded('');
  final _descripcionAdicionalColor = BehaviorSubject<String>.seeded('');

  Stream<List<CatalogoModel>> get catalogoStream => _catalogoController.stream;
  Stream<List<ConcesionarioModel>> get concesionarioStream =>
      _concesionarioController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  Stream<String> get sFilterStream => _sFilterController.stream;
  Stream<String> get sCodigoPremioStream => _codigoPremioController.stream;
  Stream<String> get sDescripcionAdicionalTallaStream =>
      _descripcionAdicionalTalla.stream;
  Stream<String> get sDescripcionAdicionalColorStream =>
      _descripcionAdicionalColor.stream;

  Function(String) get changeCodigoPremio => _codigoPremioController.sink.add;
  Function(String) get changeDescripcionAdicionalTalla =>
      _descripcionAdicionalTalla.sink.add;
  Function(String) get changeDescripcionAdicionalColor =>
      _descripcionAdicionalColor.sink.add;
  Function(String) get changeGrupoFamiliaCatalogo =>
      _sFilterController.sink.add;
      Function(List<ConcesionarioModel>) get changeConcesionario => _concesionarioController.sink.add;

  String get sCodigoPremio => _codigoPremioController.value;
  String get sDescripcionAdicionalTalla => _descripcionAdicionalTalla.value;
  String get sDescripcionAdicionalColor => _descripcionAdicionalColor.value;

  Stream<List<CatalogoModel>> get filterCatalogos =>
      Rx.combineLatest2(catalogoStream, sFilterStream, (list, filter) {
        List<CatalogoModel> aDatosCatalogoFiltrado = new List<CatalogoModel>();
        if (filter.isNotEmpty) {
          list.forEach((item) {
            String codigo = item.codigo.split(".")[0];
            List codigos;
            if (filter.contains(",")) {
              codigos = filter.split(",");
              codigos.forEach((x) {
                if (codigo.contains(x)) {
                  aDatosCatalogoFiltrado.add(item);
                }
              });
            } else {
              if (codigo.contains(filter)) {
                aDatosCatalogoFiltrado.add(item);
              }
            }
          });
          return aDatosCatalogoFiltrado;
        } else {
          return list;
        }
      });

  void cargarCatalogo(String usuario, String grupoFamilia, double latitud,
      double longitud, int more) async {
    final catalogo = await _catalogoProvider.cargarCatalogo(
        usuario, grupoFamilia, latitud, longitud, more);
    _catalogoController.sink.add(catalogo);
  }

  void consultarConcesionarioxPremio(
      String codigo, double latitud, double longitud) async {
    final concesionario = await _catalogoProvider.consultarConcesionarioxPremio(
        codigo, latitud, longitud);
        // List<ConcesionarioModel> vacio = new List<ConcesionarioModel>();
    _concesionarioController.sink.add(concesionario);
  }

  dispose() {
    // _catalogoController?.close();
    // _cargandoController?.close();
    _concesionarioController?.close();
    _codigoPremioController?.close();
_descripcionAdicionalTalla?.close();
_descripcionAdicionalColor?.close();
  }
}
