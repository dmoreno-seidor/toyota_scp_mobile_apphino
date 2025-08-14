import 'package:flutter/material.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/bottom-navbar-bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/campania_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/cargo_usuario_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/catalogo_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/citas_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/ciudad_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/dashboard_bloc.dart';
// import 'package:toyota_scp_mobile_apphino/src/pages/bloc/datos_maestros_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/encuesta_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/eventos_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/login_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/mis_premios_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/noticias_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/respuesta_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/tipo_documento_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/usuario_bloc.dart';

// import 'package:toyota_scp_mobile_apphino/src/providers/encuesta_provider.dart';
import 'package:toyota_scp_mobile_apphino/src/providers/location_provider.dart';
import 'package:toyota_scp_mobile_apphino/src/providers/push_notifications_provider.dart';
export 'package:toyota_scp_mobile_apphino/src/pages/bloc/login_bloc.dart';

class Provider extends InheritedWidget {
  final loginBloc = new LoginBloc();
  final _usuarioBloc = new UsuarioBloc();
  final _tipoDocumentoBloc =  new TipoDocumentoBloc();
  final _cargoUsuarioBloc = new CargoUsuarioBloc();
  final _ciudadesBloc = new CiudadBloc();
  final _catalogoBloc = new CatalogoBloc();
  final _misPremiosBloc = new MisPremiosBloc();
  final _campaniaBloc = new CampaniaBloc();
  final _locationService = new LocationService();
  final _pushNotification = new PushNotificationProvider();
  final _dashboardBloc = new DashboardBloc();
  final _bottomNavBarBloc = new BottomNavBarBloc();
  final _encuestaBloc = new EncuestaBloc();
  final _respuestaBloc = new RespuestaBloc();
  final _citasBloc = new CitasBloc();
  final _noticiasBloc= new NoticiasBloc();
  final _eventosBloc = new EventosBloc();



  static Provider _instancia;

  factory Provider({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new Provider._internal(key: key, child: child);
    }
    return _instancia;
  }
  
  Provider._internal({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)
        .loginBloc;
  }
  

  static UsuarioBloc usuarioBloc(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)
        ._usuarioBloc;
  }

  static TipoDocumentoBloc tipoDocumentoBloc( BuildContext context ){
    return context.dependOnInheritedWidgetOfExactType<Provider>()._tipoDocumentoBloc;
  }
  static CargoUsuarioBloc cargoUsuarioBloc( BuildContext context ){
    return context.dependOnInheritedWidgetOfExactType<Provider>()._cargoUsuarioBloc;
  }

  static CiudadBloc ciudadesBloc( BuildContext context ){
    return context.dependOnInheritedWidgetOfExactType<Provider>()._ciudadesBloc;
  }

  static CatalogoBloc catalogoBloc( BuildContext context ){
    return context.dependOnInheritedWidgetOfExactType<Provider>()._catalogoBloc;
  }

   static CampaniaBloc campaniaBloc( BuildContext context ){
    return context.dependOnInheritedWidgetOfExactType<Provider>()._campaniaBloc;
  }

  static CitasBloc citasBloc( BuildContext context ){
    return context.dependOnInheritedWidgetOfExactType<Provider>()._citasBloc;
  }

  static NoticiasBloc noticiasBloc( BuildContext context ){
    return context.dependOnInheritedWidgetOfExactType<Provider>()._noticiasBloc;
  }

  static EventosBloc eventosBloc( BuildContext context ){
    return context.dependOnInheritedWidgetOfExactType<Provider>()._eventosBloc;
  }



  

  static MisPremiosBloc misPremiosBloc( BuildContext context ){
    return context.dependOnInheritedWidgetOfExactType<Provider>()._misPremiosBloc;
  }

  static LocationService locationService ( BuildContext context ){
    return context.dependOnInheritedWidgetOfExactType<Provider>()._locationService;
  }

  static PushNotificationProvider pushNotification ( BuildContext context ){
    return context.dependOnInheritedWidgetOfExactType<Provider>()._pushNotification;
  }

  static DashboardBloc dashboardBloc ( BuildContext context ){
    return context.dependOnInheritedWidgetOfExactType<Provider>()._dashboardBloc;
  }

  static BottomNavBarBloc bottomNavBarBloc ( BuildContext context ){
    return context.dependOnInheritedWidgetOfExactType<Provider>()._bottomNavBarBloc;
  }

  static EncuestaBloc encuestaBloc ( BuildContext context ){
    return context.dependOnInheritedWidgetOfExactType<Provider>()._encuestaBloc;
  }

  static RespuestaBloc respuestaBloc ( BuildContext context ){
    return context.dependOnInheritedWidgetOfExactType<Provider>()._respuestaBloc;
  }


}
