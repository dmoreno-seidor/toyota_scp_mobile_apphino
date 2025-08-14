import 'package:shared_preferences/shared_preferences.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/splash.dart';

/*
  Recordar instalar el paquete de:
    shared_preferences:

  Inicializar en el main
    final prefs = new PreferenciasUsuario();
    await prefs.initPrefs();
    
    Recuerden que el main() debe de ser async {...

*/

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del token
  get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  // GET y SET de la última página
  get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? SplashPage.routeName;
  }

  set ultimaPagina(String value) {
    _prefs.setString('ultimaPagina', value);
  }

  get ocultarOnBoardingScreen{
    return _prefs.getString('ocultarOnBoardingScreen') ?? '0';
  }
  set ocultarOnBoardingScreen(String value){
    _prefs.setString('ocultarOnBoardingScreen', value);
  }

  clear() async{
    await _prefs.clear();
  }

  // GET y SET del token

  set iId (int value){
    _prefs.setInt('iId', value);
  }

  int get iId {
    return _prefs.getInt('iId') ?? 0;
  }

  set sNombresUsuario (String value){
    _prefs.setString('sNombresUsuario', value);
  }

  get sNombresUsuario {
    return _prefs.getString('sNombresUsuario') ?? '';
  }

  set sNumeroDocumento (String value){
    _prefs.setString('sNumeroDocumento', value);
  }

  get sNumeroDocumento {
    return _prefs.getString('sNumeroDocumento') ?? '';
  }

   set sImagen (String value){
    _prefs.setString('sImagen', value);
  }

  get sImagen {
    return _prefs.getString('sImagen') ?? '';
  }

  get usuarioInfo {
    return _prefs.getString('usuarioInfo') ?? '';
  }

  set sCelular (String value){
    _prefs.setString('sCelular', value);
  }

  get sCelular {
    return _prefs.getString('sCelular') ?? '';
  }

  set sCorreo (String value){
    _prefs.setString('sCorreo', value);
  }

  get sCorreo {
    return _prefs.getString('sCorreo') ?? '';
  }

  set usuarioInfo(String value) {
    _prefs.setString('usuarioInfo', value);
  }

  get latitude {
    return _prefs.getDouble('latitude') ?? 0.0;
  }

  set latitude(double value){
     _prefs.setDouble('latitude',value);
  }

  get longitud {
    return _prefs.getDouble('longitud') ?? 0.0;
  }

  set longitud(double value){
     _prefs.setDouble('longitud',value);
  }
}
