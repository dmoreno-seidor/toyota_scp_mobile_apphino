import 'dart:async';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  //Recuperar los datos del Stream
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);

  Stream<bool> get formValidStream =>
      Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);

// The Observable can be replaced by Stream as
// I mentioned in the question but if you are
// using methods like combineLatest2 from Observable,
// then just replace Observable by abstract
// class Rx so you can use Rx.combineLatest2

  //Insertar valores als tring
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  //Obtener ultimo valor ingresado
  String get email => _emailController.value;
  String get password => _passwordController.value;

  dispose() {
    _emailController?.close();
    _passwordController?.close();
  }
}
