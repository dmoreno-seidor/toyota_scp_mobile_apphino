import 'package:flutter/material.dart';

class AppConfig {
  //0 -> dev
  //1 -> Qas
  //2 -> Prd
  static const ambiente = 2;
  static const api_host = (ambiente == 0)
      ? ("https://destinations-d24416d89.dispatcher.us2.hana.ondemand.com/destinations/hanatoyota")
      : ((ambiente == 1)
          ? ("https://destinations-d85e9224f.dispatcher.us2.hana.ondemand.com/destinations/hanatoyota")
          : ("https://destinations-d6be74363.dispatcher.us2.hana.ondemand.com/destinations/hanatoyota"));

  static const api_host_docService = (ambiente == 0)
      ? ("https://bridged85e9224f.us2.hana.ondemand.com/Bridge/")
      : ((ambiente == 1)
          ? ("https://bridged85e9224f.us2.hana.ondemand.com/Bridge/")
          : ("https://bridged6be74363.us2.hana.ondemand.com/Bridge/"));

  static const repositoryName = (ambiente == 0)
      ? ('HinoAppRepo')
      : ((ambiente == 1) ? ("HinoAppRepo") : ("HinoAppRepo"));

  static const repositoryFolderId = (ambiente == 0)
      ? ('OtbKgjzNCVZoxAPqNEVPhFxSUDj1aG30ZjPUIiR4rCo')
      : ((ambiente == 1)
          ? ("OtbKgjzNCVZoxAPqNEVPhFxSUDj1aG30ZjPUIiR4rCo")
          : ("2T-01qd-6CVj9rbFzNwb7y7NWGrMCe1wWtVd-OkbJ7I"));

  static const autentificacion = (ambiente == 0)
      ? ('Basic UElTRVJWSUNFOkluaWNpbzAx')
      : ((ambiente == 1)
          ? ('Basic UElTRVJWSUNFOkZOdVYpe15rclpqNlFXbGZtX2wwXnAkPVEhVWZhWg==')
          : ('Basic UElTRVJWSUNFOlg1Q35HfEU0ZkppfURZO0ttXXBfbjp5VnJ6alpIQw=='));

  static const loginTextOpcionesInferior = TextStyle(
      fontFamily: "HelveticaNeue", fontSize: 15.0, color: Colors.white);
  static const loginInputText =
      TextStyle(fontFamily: "HelveticaNeue", color: Colors.white);
  static const styleCajasCrearCuenta = TextStyle(
    fontFamily: "HelveticaNeue",
    fontSize: 16,
  );
  static const styleTextBoton = TextStyle(
    fontFamily: "HelveticaNeue",
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  static const styleTextBotonDeshabilitado = TextStyle(
    fontFamily: "HelveticaNeue",
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontSize: 16,
  );
  static const styleCampoObligatorioCrearCuenta = TextStyle(
      fontFamily: "HelveticaNeue", color: Color(0xFFe53935), fontSize: 12);
  static const styleTextoRecuperarContrasena = TextStyle(
      fontFamily: "HelveticaNeue",
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 16.0,
      color: Color(0xFF1C1C1C));
  static const styleTextCargado =
      TextStyle(color: Colors.white, fontFamily: "HelveticaNeue", fontSize: 16);
  static const styleMenuWidget = TextStyle(
      fontSize: 16.0,
      fontFamily: 'HelveticaNeue',
      fontStyle: FontStyle.normal,
      color: Color(0xFF1C1C1C),
      fontWeight: FontWeight.w500);
  static const styleNavigationBarItem = TextStyle(
    fontSize: 10,
    fontFamily: "HelveticaNeue",
  );
  static const styleSubCabeceraCajas = TextStyle(
    fontFamily: 'HelveticaNeue',
    fontWeight: FontWeight.bold,
    color: Color(0xFF000000),
    fontSize: 16,
  );
  static const styleTextDropDown = TextStyle(
    fontFamily: 'HelveticaNeue',
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );

  static const styleCabecerasPaginas = TextStyle(
      // fontFamily: 'HelveticaNeue',
      fontFamily: "HelveticaNeue",
      fontSize: 22,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
      color: Colors.white);
  static const styleSubCabecerasPaginas = TextStyle(
      // fontFamily: 'HelveticaNeue',
      fontFamily: "HelveticaNeue",
      fontSize: 16,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
      color: Colors.white);
  static const boxShadow = BoxShadow(
    color: Colors.grey,
    offset: Offset(0, 0), //(x,y)
    blurRadius: 1.0,
  );
  static const styleTituloCajaPrincipal = TextStyle(
      color: Color(0xFFE60012),
      // fontFamily: 'HelveticaNeue',
      fontFamily: "HelveticaNeue",
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      fontSize: 12);
  static const styleSubTituloCajaPrincipal = TextStyle(
      color: Color(0xFF94949A),
      // fontFamily: 'HelveticaNeue',
      fontFamily: "HelveticaNeue",
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      fontSize: 12);
  static const styleValorTituloCajaSecundarias = TextStyle(
      color: Color(0xFF1C1C1C),
      // fontFamily: 'HelveticaNeue',
      fontFamily: "HelveticaNeue",
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
      fontSize: 16);
  static const styleTituloCajaSecundarias = TextStyle(
      color: Color(0xFF94949A),
      // fontFamily: 'HelveticaNeue',
      fontFamily: "HelveticaNeue",
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      fontSize: 12);

  static const styleCodigoCatalogoPremio = TextStyle(
      color: Color(0xFF94949A),
      // fontFamily: 'HelveticaNeue',
      fontFamily: "HelveticaNeue",
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.normal,
      fontSize: 10);
  static const styleTituloCatalogoPremio = TextStyle(
      color: Color(0xFF000000),
      // fontFamily: 'HelveticaNeue',
      fontFamily: "HelveticaNeue",
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
      fontSize: 12);

  static const styleCodigoDetallePremio = TextStyle(
      color: Color(0xFF94949A),
      // fontFamily: 'HelveticaNeue',
      fontFamily: "HelveticaNeue",
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
      fontSize: 12);
  static const styleTituloDetallePremio = TextStyle(
      color: Color(0xFF000000),
      // fontFamily: 'HelveticaNeue',
      fontFamily: "HelveticaNeue",
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
      fontSize: 14);
  static const styleTituloDetallePremioCaracteristica = TextStyle(
      color: Color(0xFFE60012),
      // fontFamily: 'HelveticaNeue',
      fontFamily: "HelveticaNeue",
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
      fontSize: 12);
  static const styleDondeEncuentroConsesionario = TextStyle(
      // fontFamily: 'HelveticaNeue',
      fontFamily: "HelveticaNeue",
      fontSize: 16,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
      color: Colors.black);
  static const styleTituloConcesionarioLugar = TextStyle(
      // fontFamily: 'HelveticaNeue',
      fontFamily: "HelveticaNeue",
      fontSize: 14,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
      color: Color(0xffE60012));
  static const styleTituloConcesionario = TextStyle(
      // fontFamily: 'HelveticaNeue',
      fontFamily: "HelveticaNeue",
      fontSize: 14,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
      color: Colors.black);
  static const styleTituloConcesionarioDireccion = TextStyle(
      // fontFamily: 'HelveticaNeue',
      fontFamily: "HelveticaNeue",
      fontSize: 11,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      color: Color(0xff94949A));
  static const styleTituloConcesionarioOpciones = TextStyle(
      // fontFamily: 'HelveticaNeue',
      fontFamily: "HelveticaNeue",
      fontSize: 12,
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.normal,
      color: Color(0xff94949A));
  static const styleTallaTamanioDesactivado = TextStyle(
      fontStyle: FontStyle.normal,
      fontFamily: "HelveticaNeue",
      fontWeight: FontWeight.bold,
      fontSize: 12);
  static const styleTallaTamanioActivado = TextStyle(
      fontStyle: FontStyle.normal,
      fontFamily: "HelveticaNeue",
      fontWeight: FontWeight.bold,
      fontSize: 12,
      color: Colors.white);
}
