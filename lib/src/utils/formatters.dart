// import 'package:flutter/material.dart';
import "package:intl/intl.dart";

String formatPuntos(int n) {
  final f = new NumberFormat("###,###,###");
  final s = f.format(n);
  return s;
}

String formatFechaDD_MM_YYYY(String date) {
  String fecha = '';
  String dia = '';
  String mes = '';
  String anio = '';
    if(date == null){
    return '';
      }else{
      if (date.length == 0) {
        return fecha;
      } else {
        if (DateTime.parse(date).day <= 9) {
          dia = '0' + DateTime.parse(date).day.toString();
        } else {
          dia = DateTime.parse(date).day.toString();
        }

        if (DateTime.parse(date).month <= 9) {
          mes = '0' + DateTime.parse(date).month.toString();
        } else {
          mes = DateTime.parse(date).month.toString();
        }

        anio = DateTime.parse(date).year.toString();
        fecha = dia +"/"+ mes +"/"+ anio;
        return fecha; 
      }
      }
}

String formatVencimientoPuntos(String date){
  String fecha = '';
  String dia = '';
  String mes = '';
  String anio = '';
  if(date == null){
return 'No existe vigencia';
  }
  else{
  if (date.length == 0) {
    return "No existe vigencia";
  } else {
    if (DateTime.parse(date).day <= 9) {
      dia = '0' + DateTime.parse(date).day.toString();
    } else {
      dia = DateTime.parse(date).day.toString();
    }

    if (DateTime.parse(date).month <= 9) {
      mes = '0' + DateTime.parse(date).month.toString();
    } else {
      mes = DateTime.parse(date).month.toString();
    }

    anio = DateTime.parse(date).year.toString();
    fecha = "Vence el " + dia + "/"+ mes+"/"+anio;
    
    return fecha; 
  }

  }
}

String formatSoloFechaVencimientoPuntos(String date){
  String fecha = '';
  String dia = '';
  String mes = '';
  String anio = '';
  if(date == null){
return 'No existe vigencia';
  }
  else{
  if (date.length == 0) {
    return "No existe vigencia";
  } else {
    if (DateTime.parse(date).day <= 9) {
      dia = '0' + DateTime.parse(date).day.toString();
    } else {
      dia = DateTime.parse(date).day.toString();
    }

    if (DateTime.parse(date).month <= 9) {
      mes = '0' + DateTime.parse(date).month.toString();
    } else {
      mes = DateTime.parse(date).month.toString();
    }

    anio = DateTime.parse(date).year.toString();
    fecha = dia + "/"+ mes+"/"+anio;
    
    return fecha; 
  }

  }
}


String formatObtenerDia(String date){
  String dia = '';
  
  if(date == null){
return 'No existe vigencia';
  }
  else{
  if (date.length == 0) {
    return "No existe vigencia";
  } else {
    date = date.replaceAll("-", "/");
    return date.split('/')[0]; 
  }

  }
}

String formatObtenerNombreDia(String? date) {
  if (date == null || date.isEmpty) {
    return '';
  }

  switch (date.toUpperCase()) {
    case 'MONDAY':
      return 'LUNES';
    case 'TUESDAY':
      return 'MARTES';
    case 'WEDNESDAY':
      return 'MIERCOLES';
    case 'THURSDAY':
      return 'JUEVES';
    case 'FRIDAY':
      return 'VIERNES';
    case 'SATURDAY':
      return 'SABADO';
    case 'SUNDAY':
      return 'DOMINGO';
    default:
      return '';
  }
}

String formatObtenerNombreMes(String date){
  
  if(date == null){
return '';
  }
  else{
     date = date.replaceAll("-", "/");

List<String> aMeses = [
    'ENE',
    'FEB',
    'MAR',
    'ABR',
    'MAY',
    'JUN',
    'JUL',
    'AGO',
    'SET',
    'OCT',
    'NOV',
    'DIC'
  ];
  return aMeses[int.parse(date.split('/')[1],radix: 10)-1];

  }
}



String formatObtenerNombreMesAnio(String date){

  String dia = '';
  String mes = '';
  String anio = '';
  if(date == null){
return 'No existe vigencia';
  }
  else{
  if (date.length == 0) {
    return "No existe vigencia";
  } else {
    if (DateTime.parse(date).day <= 9) {
      dia = '0' + DateTime.parse(date).day.toString();
    } else {
      dia = DateTime.parse(date).day.toString();
    }

    if (DateTime.parse(date).month <= 9) {
      mes = '0' + DateTime.parse(date).month.toString();
    } else {
      mes = DateTime.parse(date).month.toString();
    }

    anio = DateTime.parse(date).year.toString();
    // fecha = "Vence en el " + dia + "/"+ mes+"/"+anio;
    
    List<String> aMeses = [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Setiembre',
    'Octubre',
    'Noviembre',
    'Diciembre'
  ];

  return 'Algunos puntos vencen ' + aMeses[DateTime.parse(date).month-1] + " " +anio;
   
  }

  }
}


String formatObtenerNombreMesAnioV2(String date){

  String dia = '';
  String mes = '';
  String anio = '';
  if(date == null){
return 'No existe vigencia';
  }
  else{
  if (date.length == 0) {
    return "No existe vigencia";
  } else {
    if (DateTime.parse(date).day <= 9) {
      dia = '0' + DateTime.parse(date).day.toString();
    } else {
      dia = DateTime.parse(date).day.toString();
    }

    if (DateTime.parse(date).month <= 9) {
      mes = '0' + DateTime.parse(date).month.toString();
    } else {
      mes = DateTime.parse(date).month.toString();
    }

    anio = DateTime.parse(date).year.toString();
    // fecha = "Vence en el " + dia + "/"+ mes+"/"+anio;
    
    List<String> aMeses = [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Setiembre',
    'Octubre',
    'Noviembre',
    'Diciembre'
  ];

  return aMeses[DateTime.parse(date).month-1] + " " +anio;
   
  }

  }
}


  





