import 'dart:convert';

import 'package:flutter/material.dart';

bool isNumeric(String s) {
  if (s.isEmpty) {
    return false;
  }
  final n = num.tryParse(s);

  return (n == null) ? false : true;
}

bool validarCorreo(String sCorreo) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(pattern);
  if (regExp.hasMatch(sCorreo)) {
    return true;
  } else {
    return false;
  }
}

bool validarNumeroDocumento(String sNumeroDocumento, String idTipoDocumento) {
  
  int cantidadDigitos ;

  if(idTipoDocumento =='103'){
   
    cantidadDigitos =8;

  }else if(idTipoDocumento =='104'){
    
    cantidadDigitos =12;

  }

  if (sNumeroDocumento.length== cantidadDigitos) {
    return true;
  } else {
    return false;
  }
}

bool validarNombre(String sNumeroDocumento) {
  if (sNumeroDocumento.length > 0) {
    return true;
  } else {
    return false;
  }
}

bool validarCelular(String sNumeroDocumento) {
  if (sNumeroDocumento.length == 11) {
    return true;
  } else {
    return false;
  }
}

bool validarPassword(String sPassword) {
  Pattern pattern = r'^((?=.*[A-Z])(?=.*\d)[A-Za-z\d@$!%*#?&]{8,})$';
  RegExp regExp = new RegExp(pattern);
  if (regExp.hasMatch(sPassword)) {
    return true;
  } else {
    return false;
  }
}

String generateEncripto(String userPass) {
  var bytes = utf8.encode(userPass);
  var base64Str = base64.encode(bytes);

  return base64Str;
}
bool validarRecuperarPassword(String sPassword){
  Pattern pattern =
        r'^((?=.*[A-Z])(?=.*\d)[A-Za-z\d@$!%*#?&]{8,})$';
    RegExp regExp = new RegExp(pattern);
    if (regExp.hasMatch(sPassword)) {
      return true;
    } else {
      return false;
    }
}

void mostrarAlerta(BuildContext context, String mensaje) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Información incorrecta'),
          content: Text(mensaje),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      });
}
