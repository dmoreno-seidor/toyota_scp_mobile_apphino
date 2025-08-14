import 'dart:async';

class Validators {

  final validarEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (regExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError("Email no es correcto");
    }
  });

  final validarPassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 6) {
      sink.add(password);
    } else {
      sink.addError('Más de 6 caracteres por favor');
    }
  });

  final validarCelular = StreamTransformer<String, String>.fromHandlers(
      handleData: (celular, sink) {
    if (celular.length == 11) {
      sink.add(celular);
    } else {
      sink.addError('El número es de 9 dígitos');
    }
  });

  final validarNombre = StreamTransformer<String ,String>.fromHandlers(
    handleData: (nombre, sink) {
    if (nombre.length >0) {
      sink.add(nombre);
    } else {
      sink.addError('El nombre debe tener por lo menos un carácter');
    }
  });

   final validarTerminosCondiciones = StreamTransformer<bool ,bool>.fromHandlers(
    handleData: (terminosCondiciones, sink) {
    if (terminosCondiciones) {
      sink.add(terminosCondiciones);
    } else {
      sink.addError('Campo obligatorio terminos y condiciones');
    }
  });

  final validarAutorizacionDatos = StreamTransformer<bool ,bool>.fromHandlers(
    handleData: (autorizacionDatos, sink) {
    if (autorizacionDatos) {
      sink.add(autorizacionDatos);
    } else {
      sink.addError('Campo obligatorio autorización de datos');
    }
  });
}
