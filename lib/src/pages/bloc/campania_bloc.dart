// import 'dart:convert';
// import 'dart:io';
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:toyota_scp_mobile_apphino/src/models/campania_model.dart';
// import 'package:toyota_scp_mobile_apphino/src/models/ciudad_model.dart';
import 'package:toyota_scp_mobile_apphino/src/models/concesionario_model.dart';
// import 'package:toyota_scp_mobile_apphino/src/models/tipo_documento_model.dart';
import 'package:toyota_scp_mobile_apphino/src/providers/campania_provider.dart';
// import 'package:toyota_scp_mobile_apphino/src/providers/ciudad_provider.dart';
// import 'package:toyota_scp_mobile_apphino/src/providers/tipo_documento_provider.dart';

class CampaniaBloc{
  final _campaniaController = new BehaviorSubject<List<CampaniaModel>>();
  final _cargandoController = new BehaviorSubject<bool>();
  final _campaniaProvider = new CampaniaProvider();
  final _sFilterController = BehaviorSubject<String>.seeded('');
  
  //1.He creado un controlador de tipo ConcesionarioModel de tal forma que pueda 
  //hacer de el mismo de la pantalla.
  final _concesionarioSeleccionadoController = new BehaviorSubject<ConcesionarioModel>();
  Stream<List<CampaniaModel>> get campaniaStream => _campaniaController.stream;
  Stream<bool> get cargando => _cargandoController.stream;
 //2.He creado un stream de tipo ConcesionarioModel con la finalidad de poder usar el patron bloc.
  Stream<ConcesionarioModel> get oConcesionarioSeleccionadoStream => _concesionarioSeleccionadoController.stream;
  //3.He creado un metodo que recibe un parametro ConcesionarioModel con el fin de que pueda almacenar
  //lo que se le esta pasando ya estamos usando uso de un sink.add
  Function(ConcesionarioModel) get changeConcesionarioSeleccionado => _concesionarioSeleccionadoController.sink.add;
  //4.Sirve para obtener el ultimo valor de la tuberia.
  ConcesionarioModel get oConcesionarioSeleccionado =>_concesionarioSeleccionadoController.value;


  Function(String) get changeCiudad => _sFilterController.sink.add;
   Stream<String> get sFilterStream => _sFilterController.stream;
  Stream<List<CampaniaModel>> get filterCampanias =>
      Rx.combineLatest2(campaniaStream, sFilterStream, (list, filter) {
        List<CampaniaModel> aDatosCampaniaFiltrado =
            new List<CampaniaModel>();
         
        if (filter.isNotEmpty) {
          list.forEach((item) {
            List aConcesionario =
             new List();
             List aConcesionarios = item.aConcesionarios;
             aConcesionarios.forEach((con) {

                if (con["ciudad"].toString().contains(filter)) {
                  aConcesionario.add(con);
                }

             });

             if(aConcesionario.length>0){
               CampaniaModel campaniaModel = CampaniaModel();
               campaniaModel.id = item.id;
               campaniaModel.imagen = item.imagen;
               campaniaModel.nombre = item.nombre;
               campaniaModel.terminos = item.terminos;
               campaniaModel.vigencia = item.vigencia;
               campaniaModel.aConcesionarios = aConcesionario;
                aDatosCampaniaFiltrado.add(campaniaModel);
             }
            
            
          });

          return aDatosCampaniaFiltrado;
        } else {
          return list;
        }
      });
 
  void cargarCampania(String usuario, double longitud, double latitud, String ciudad) async{
    final campania = await _campaniaProvider.cargarCampania(usuario, longitud, latitud, ciudad);
    
    _campaniaController.sink.add(campania);
  }
  
  dispose() {
    _campaniaController?.close();
    _cargandoController?.close();
  }

}





