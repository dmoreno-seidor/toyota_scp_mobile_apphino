import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:toyota_scp_mobile_apphino/src/app_config.dart';
import 'package:toyota_scp_mobile_apphino/src/models/usuario_model.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/usuario_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/providers/usuario_provider.dart';
import 'package:toyota_scp_mobile_apphino/src/widgets/imput_codigo_sms.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/dialogs.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';

import '../utils/responsive.dart';
import '../comportamiento_usuario/comportamiento_usuario.dart';
import '../preferencias_usuario/preferencias_usuario.dart';

class ValidarSmsPage extends StatefulWidget {
  @override
  _ValidarSmsPageState createState() => _ValidarSmsPageState();
}

class _ValidarSmsPageState extends State<ValidarSmsPage>
    with WidgetsBindingObserver {
  FocusNode myFocusNode0;
  FocusNode myFocusNode;
  FocusNode myFocusNode1;
  FocusNode myFocusNode2;
  FocusNode myFocusNode3;
  FocusNode myFocusNode4;
  FocusNode myFocusNode5;

  Map<String, dynamic> usuario;

  TextEditingController _valorInputCod = TextEditingController();
  TextEditingController _valorInputCod1 = TextEditingController();
  TextEditingController _valorInputCod2 = TextEditingController();
  TextEditingController _valorInputCod3 = TextEditingController();
  TextEditingController _valorInputCod4 = TextEditingController();
  TextEditingController _valorInputCod5 = TextEditingController();
  // String _iActivacionCode;
  // String _nombreUsuario;
  final usuarioProvider = new UsuarioProvider();
  UsuarioModel usuarioData;
  UsuarioBloc usuarioBloc;
  bool _isFetching = false;
  final prefs = new PreferenciasUsuario();

  String codigoSms;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    myFocusNode0 = FocusNode();
    myFocusNode = FocusNode();
    myFocusNode1 = FocusNode();
    myFocusNode2 = FocusNode();
    myFocusNode3 = FocusNode();
    myFocusNode4 = FocusNode();
    myFocusNode5 = FocusNode();

    Future.delayed(Duration.zero, () {
      setState(() {
        usuario = jsonDecode(ModalRoute.of(context).settings.arguments);
      });
    });
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    WidgetsBinding.instance.removeObserver(this);

    myFocusNode0.dispose();
    myFocusNode.dispose();
    myFocusNode1.dispose();
    myFocusNode2.dispose();
    myFocusNode3.dispose();
    myFocusNode4.dispose();
    myFocusNode5.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      // went to Background
      ComportamientoUsuario.registrarEvento(prefs, cierreApp: true);
    }
    if (state == AppLifecycleState.resumed) {
      // came back to Foreground
      print('On resume...');
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    TextStyle linkStyle = TextStyle(
      fontSize: responsive.ip(1.8),
      color: Color(0xFFE60012),
      fontWeight: FontWeight.normal,
      fontFamily: "HelveticaNeue",
    );
    TextStyle defaultStyle = TextStyle(
      color: Color(0xff1C1C1C),
      fontSize: responsive.ip(1.8),
      fontFamily: "HelveticaNeue",
    );

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  _crearBanner(context),
                  Container(
                      margin: EdgeInsets.only(left: responsive.wp(6)),
                      child: Divider(
                        color: Color(0xFFE60012),
                        endIndent: responsive.wp(80),
                        thickness: 1.0,
                      )),
                  _crearBody(),
                  Container(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _crearInputCodigo(),
                        _crearInputCodigo1(),
                        _crearInputCodigo2(),
                        _crearInputCodigo3(),
                        _crearInputCodigo4(),
                        _crearInputCodigo5(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  RichText(
                    text: TextSpan(style: defaultStyle, children: <TextSpan>[
                      TextSpan(
                          text: 'Si no has recibido el código ',
                          style: TextStyle(
                              fontSize: responsive.ip(1.8),
                              fontFamily: "HelveticaNeue",
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF1C1C1C))),
                      TextSpan(
                          text: 'Reenvialo aquí',
                          style: linkStyle,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              _reenviarCodigo(usuario);
                            }),
                    ]),
                  ),
                  SizedBox(
                    height: responsive.ip(28),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    height: responsive.ip(7.2),
                    width: double.infinity,
                    child:
                        //Row(
                        //  mainAxisAlignment: MainAxisAlignment.center,
                        // children: <Widget>[
                        _crearButtonEnviarMensaje(usuario),
                    //  ],
                    // ),
                  ),
                ],
              ),
            ),
            _isFetching
                ? Positioned.fill(
                    child: Container(
                    color: Colors.black45,
                    child: Center(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SpinKitThreeBounce(
                                size: 35,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: index.isEven
                                          ? Colors.red
                                          : Colors.red,
                                    ),
                                  );
                                }),
                            Text("Cargando...",
                                style: AppConfig.styleTextCargado),
                          ],
                        ),
                      ),
                    ),
                  ))
                : Container()
          ],
        ));
  }

  Widget _crearBanner(BuildContext context) {
    final responsive = Responsive(context);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SafeArea(
            child: Container(
              margin: EdgeInsets.only(
                  left: responsive.wp(6), right: responsive.wp(6)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 18.76),
                      height: responsive.ip(1.536),
                      width: responsive.ip(2.4),
                      decoration: new BoxDecoration(
                        image: DecorationImage(
                          image:
                              new AssetImage('assets/campania/iconArrow.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  SizedBox(height: 7),
                  Text(
                    'Validación por SMS',
                    style: TextStyle(
                        fontFamily: "HelveticaNeue",
                        fontWeight: FontWeight.bold,
                        fontSize: (responsive.ip(3.5)) //(28.0),
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearBody() {
    final responsive = Responsive(context);
    return Container(
      margin: EdgeInsets.only(
          left: responsive.wp(2), right: responsive.wp(2), top: 17),
      child: Column(
        children: <Widget>[
          Text(
              '${usuario["oUsuario"]["sNombres"]} te hemos enviado un código de verificación al siguiente número: ',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "HelveticaNeue",
                  height: 1.5,
                  fontStyle: FontStyle.normal,
                  fontSize: responsive.ip(2.1),
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1C1C1C))),
          SizedBox(
            height: 17,
          ),
          Text(
            '${usuario["oUsuario"]["sCelular"]}',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: "HelveticaNeue",
                fontStyle: FontStyle.normal,
                fontSize: responsive.ip(2.4),
                fontWeight: FontWeight.bold,
                color: Color(0xFF000000)),
          ),
          SizedBox(
            height: 17,
          ),
        ],
      ),
    );
  }

  Widget _crearInputCodigo() {
    final _responsive = Responsive(context);
    return Container(
        width: _responsive.ip(6),
        height: _responsive.ip(6),
        //padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 10.0),

        child: InputTextCodigo(
            controller: _valorInputCod,
            keyboardType: TextInputType.number,
            border: OutlineInputBorder(),
            autofocus: true,
            focusNode: myFocusNode0,
            onChanged: (value) {
              if (value != "") {
                myFocusNode.requestFocus();
              }
              if (Platform.isIOS) {
                _validarCantidadCampos();
              }
            }));
  }

  Widget _crearInputCodigo1() {
    final _responsive = Responsive(context);
    return Container(
      width: _responsive.ip(6),
      height: _responsive.ip(6),
      // padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: InputTextCodigo(
        controller: _valorInputCod1,
        keyboardType: TextInputType.number,
        border: OutlineInputBorder(),
        autofocus: false,
        focusNode: myFocusNode,
        onChanged: (value) {
          if (value != "") {
            myFocusNode1.requestFocus();
          } else {
            myFocusNode0.requestFocus();
          }
          if (Platform.isIOS) {
            _validarCantidadCampos();
          }
        },
      ),
    );
  }

  Widget _crearInputCodigo2() {
    final _responsive = Responsive(context);
    return Container(
      width: _responsive.ip(6),
      height: _responsive.ip(6),
      // padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: InputTextCodigo(
          controller: _valorInputCod2,
          keyboardType: TextInputType.number,
          border: OutlineInputBorder(),
          autofocus: false,
          focusNode: myFocusNode1,
          onChanged: (value) {
            if (value != "") {
              myFocusNode2.requestFocus();
            } else {
              myFocusNode.requestFocus();
            }
            if (Platform.isIOS) {
              _validarCantidadCampos();
            }
          }),
    );
  }

  Widget _crearInputCodigo3() {
    final _responsive = Responsive(context);
    return Container(
      width: _responsive.ip(6),
      height: _responsive.ip(6),
      // padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: InputTextCodigo(
          controller: _valorInputCod3,
          keyboardType: TextInputType.number,
          border: OutlineInputBorder(),
          autofocus: false,
          focusNode: myFocusNode2,
          onChanged: (value) {
            if (value != "") {
              myFocusNode3.requestFocus();
            } else {
              myFocusNode1.requestFocus();
            }
            if (Platform.isIOS) {
              _validarCantidadCampos();
            }
          }),
    );
  }

  Widget _crearInputCodigo4() {
    final _responsive = Responsive(context);
    return Container(
      width: _responsive.ip(6),
      height: _responsive.ip(6),
      // padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: InputTextCodigo(
          controller: _valorInputCod4,
          keyboardType: TextInputType.number,
          border: OutlineInputBorder(),
          autofocus: false,
          focusNode: myFocusNode3,
          onChanged: (value) {
            if (value != "") {
              myFocusNode4.requestFocus();
            } else {
              myFocusNode2.requestFocus();
            }
            if (Platform.isIOS) {
              _validarCantidadCampos();
            }
          }),
    );
  }

  Widget _crearInputCodigo5() {
    final _responsive = Responsive(context);
    return Container(
      width: _responsive.ip(6),
      height: _responsive.ip(6),
      // padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: InputTextCodigo(
          controller: _valorInputCod5,
          keyboardType: TextInputType.number,
          border: OutlineInputBorder(),
          autofocus: false,
          focusNode: myFocusNode4,
          onChanged: (value) {
            if (value != "") {
              myFocusNode5.requestFocus();
            } else {
              myFocusNode3.requestFocus();
            }
            if (Platform.isIOS) {
              _validarCantidadCampos();
            }
          }),
    );
  }

  _validarCantidadCampos() {
    String sCodigoValidacion = codigoSms = _valorInputCod.text +
        _valorInputCod1.text +
        _valorInputCod2.text +
        _valorInputCod3.text +
        _valorInputCod4.text +
        _valorInputCod5.text;
    if (sCodigoValidacion.length == 6) {
      FocusScope.of(context).requestFocus(new FocusNode());
    }
  }

  _comprobarCodigoValidacionSms(String iActivationCode, usuario) async {
    if (_isFetching) {
      return;
    } else {
      setState(() {
        _isFetching = true;
      });

      bool isValid = await usuarioProvider.comprobarCodigoValidacionSms(
          context,
          usuario["oUsuario"]["sCorreo"],
          usuario["oUsuario"]["sCelular"],
          iActivationCode);
      if (isValid) {
        bool isValid = await usuarioProvider.registrarUsuarioMovil(
            context, usuario["oUsuario"]);

        if (isValid) {
          Dialogs.succedDialog(context,
              title: "¡Excelente!",
              message: "Se ha confirmado el código de verificaccion", onOk: () {
            Navigator.pushReplacementNamed(context, 'login');
          });

          print(usuario["oUsuario"]);

          // Navigator.pushReplacementNamed(context, 'validacionSms',
          //     arguments: oParam);
        }
      } else {
        setState(() {
          _isFetching = false;
        });
      }

      setState(() {
        _isFetching = false;
      });

      setState(() {
        _isFetching = false;
      });
    }

    // var timer = Timer(Duration(seconds: 3), () {
    //   Navigator.pushReplacementNamed(context, 'dashboard',
    //       arguments: usuarioData);
    // });
  }

  _reenviarCodigo(Map<String, dynamic> usuario) async {
    var email = usuario["oUsuario"]["sCorreo"];
    var celular = usuario["oUsuario"]["sCelular"];

    final nuevoCodActivacion =
        await usuarioProvider.enviarCodigoValidacion(context, email, celular);

    if (nuevoCodActivacion != '') {
      usuario["iActivacionCode"] = nuevoCodActivacion;
      Dialogs.succedDialog(context,
          title: "¡Excelente!",
          message: "El código a sido reenviado con exito", onOk: () {
        Navigator.pop(context);
      });
    } else {
      Dialogs.alertDialog(context,
          title: "Aviso", message: "Error al reenviar el código", onOk: () {});
    }
  }

  Widget _crearButtonEnviarMensaje(Map<String, dynamic> usuario) {
    final responsive = Responsive(context);
    return RaisedButton(
      child: Container(
          child: Text("Validar",
              style: TextStyle(
                  fontFamily: "HelveticaNeue",
                  fontStyle: FontStyle.normal,
                  fontSize: responsive.ip(2.4),
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFFFFF)))),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
      elevation: 0.0,
      color: Color(0xffE60012),
      textColor: Colors.white,
      onPressed: () {
        final parentContext = context;
        codigoSms = _valorInputCod.text +
            _valorInputCod1.text +
            _valorInputCod2.text +
            _valorInputCod3.text +
            _valorInputCod4.text +
            _valorInputCod5.text;
        if (codigoSms.length == 6 && codigoSms == usuario["iActivacionCode"]) {
          _comprobarCodigoValidacionSms(codigoSms, usuario);
        } else {
          // Dialogs.alertDialog(context,
          //     title: "¡Ups...!",
          //     message: "Ingrese el código completo",
          //     onOk: () {});
          Dialogs.succedDialog(context,
              title: "Aviso", message: "Ingrese el código completo", onOk: () {
            Navigator.pop(parentContext);
          });
        }
      },
    );
  }
}
