import 'package:flutter/cupertino.dart';
// import 'package:toyota_scp_mobile_apphino/src/models/usuario_model.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/campanias_page.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/campanias_detalle_page.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/catalogo_page.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/citas_page.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/crear_cuenta_page.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/dashboard_page.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/detalle_premio_page.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/home_page.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/login_page.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/maps_page.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/maps_permission.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/mi_perfil_page.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/mis_premios_page.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/mis_puntos_page.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/mis_servicios_page.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/mis_vehiculos_page.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/noticias_detalle_page.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/eventos_detalle_page.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/noticias_page.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/nueva_contrasena_page.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/onboarding_screen.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/preguntas_frecuentes.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/recuperar_contrasena_page.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/splash.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/validacion_sms_page.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/validacion_sms_recuperar_contrasena.dart';

Map<String, WidgetBuilder> getAplicationRoutes() {
  return <String, WidgetBuilder>{
    'splash' : (BuildContext context) => SplashPage(),
    'onBoardingScreen': (BuildContext context) => OnboardingScreen(),
    'login': (BuildContext context) => LoginPage(),
    'crearCuenta': (BuildContext context) => CrearCuentaPage(),
    'validacionSms': (BuildContext context) => ValidarSmsPage(),
    'recuperarContrasena': (BuildContext context) => RecuperarContrasenaPage(),
    'validacionSmsRecuperarContrasena': (BuildContext context) => ValidarSmsRecuperarContrasena(),
    'nuevaContrasena': (BuildContext context) => NuevaContrasenaPage(),
    'dashboard': (BuildContext context) => DashboardPage(),
    'home': (BuildContext context) => HomePage(),
    'miPerfil': (BuildContext context) => MiPerfilPage(),
    'misPuntos': (BuildContext context) => MisPuntosPage(),
    'misPremios': (BuildContext context) => MisPremiosPage(),
    'misServicios': (BuildContext context) => MisServiciosPage(),
    'misVehiculos': (BuildContext context) => MisVehiculosPage(),
    'catalogo': (BuildContext context) => CatalogoPage(),
    'citas': (BuildContext context) => CitasPage(),
    'campanias': (BuildContext context) => CampaniasPage(),
    'campaniasDetalle': (BuildContext context) => CampaniasDetallePage(),
    'noticias': (BuildContext context) => NoticiasPage(),
    'noticiasDetalle': (BuildContext context) => NoticiasDetallePage(),
    'eventosDetalle': (BuildContext context) => EventosDetallePage(),
    'preguntasFrecuentes': (BuildContext context) => PreguntasFrecuentesPage(),
    'detallePremio' : (BuildContext context)=> DetallePremioPage(),
    'mapsPermission' : (BuildContext context)=> MapsPermission(),
    'mapsPage' : (BuildContext context) => MapsPage(),
  };
}
