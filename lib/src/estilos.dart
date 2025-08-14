import 'package:flutter/material.dart';

class EstilosConfig {
  
  static const styleCabecerasPaginas = TextStyle(
      fontFamily: 'HelveticaNeue',
      fontSize: 22,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
      color: Colors.white);
  static const boxShadow = BoxShadow(
    color: Colors.grey,
    offset: Offset(0.0, 1.0), //(x,y)
    blurRadius: 6.0,
  );
  static const decorationKilometraje = BoxDecoration(
                color: Color(0xff71C341),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
              );
  static const styleTituloCajaPrincipal = TextStyle(
      color: Color(0xFFE60012),
      fontFamily: 'HelveticaNeue',
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      fontSize: 8);
  static const styleSubTituloCajaPrincipal = TextStyle(
      color: Color(0xFF94949A),
      fontFamily: 'HelveticaNeue',
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      fontSize: 8);
  static const styleValorTituloCajaSecundarias = TextStyle(
      color: Color(0xFF1C1C1C),
      fontFamily: 'HelveticaNeue',
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
      fontSize: 18);
  static const styleTituloCajaSecundarias = TextStyle(
      color: Color(0xFF94949A),
      fontFamily: 'HelveticaNeue',
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      fontSize: 15);
  static const styleEtiquetaPuntos = TextStyle(
      color: Color(0xFF1C1C1C),
      fontFamily: 'HelveticaNeue',
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
      fontSize: 14);
  static const styleEtiquetaKilometraje = TextStyle(
      color: Color(0xFFFFFFFF),
      fontFamily: 'HelveticaNeue',
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      fontSize: 12.5);
  static const styleEtiquetaCategoriaPremio = TextStyle(
      color: Colors.black,
      fontFamily: 'HelveticaNeue',
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.normal,
      fontSize: 9.5);
  static const styleEtiquetaCategoriaPremioActivo = TextStyle(
      color: Color(0xffE60012),
      fontFamily: 'HelveticaNeue',
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.normal,
      fontSize: 9.5);
  
}
