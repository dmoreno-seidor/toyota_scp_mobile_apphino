import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:toyota_scp_mobile_apphino/src/app_config.dart';
import 'package:toyota_scp_mobile_apphino/src/models/usuario_model.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/Provider.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/usuario_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/providers/usuario_provider.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/utils.dart' as utils;
import 'package:toyota_scp_mobile_apphino/src/widgets/text_form_crear_cuenta.dart';

import '../comportamiento_usuario/comportamiento_usuario.dart';
import '../preferencias_usuario/preferencias_usuario.dart';

class RecuperarContrasenaPage extends StatefulWidget {
  
  @override
  _RecuperarContrasenaPageState createState() =>
      _RecuperarContrasenaPageState();
}

class _RecuperarContrasenaPageState extends State<RecuperarContrasenaPage> with WidgetsBindingObserver {
  final _formKeyRecuperarPassword = GlobalKey<FormState>();
  final prefs = new PreferenciasUsuario();
  UsuarioBloc usuarioBloc = new UsuarioBloc();
  UsuarioModel usuarioModel = UsuarioModel();
  final usuarioProvider = new UsuarioProvider();
  var _isFetching = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
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
    usuarioBloc = Provider.usuarioBloc(context);

    return Scaffold (
          resizeToAvoidBottomInset: false,
          body: Stack(
          children: <Widget>[
            Container(
              // padding: EdgeInsets.only(
              //     left: 20.0, top: 20.0, right: 20.0), //EdgeInsets.all(20.0),
              child: Form(
                  key: _formKeyRecuperarPassword,
                  child: Column(
                  children: <Widget>[
                    _crearBanner(context),
                    Container(
                        margin: EdgeInsets.only(left: responsive.wp(6)),
                        child: Divider(
                          color: Color(0xFFE60012),
                          endIndent: responsive.wp(85.0),
                          thickness: 1.0,
                        )),
                    // SizedBox(height: 17),
                    _crearBody(context),
                    Expanded(child: Container()),
                    _crearButtonEnviarMensaje(context),
                  ],
                ),
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
                                      color:
                                          index.isEven ? Colors.red : Colors.red,
                                    ),
                                  );
                                }),
                            Text(
                              "Enviando mensaje..",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ))
                : Container()
          ],
        ),
    );
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
                                     left: responsive.wp(6), right: responsive.wp(6), bottom: 7),
                        child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                                        child: Container(
                            // padding: EdgeInsets.only(bottom: 10),
                            height: responsive.ip(1.536),
                            width: responsive.ip(2.4),
                            decoration: new BoxDecoration(
                                                image: DecorationImage(
                                                  image: new AssetImage(
                                                      'assets/campania/iconArrow.png'),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                          ),
                          onTap: () => Navigator.of(context).pop(),
                        ),
                SizedBox(height: 18.76),
                        Text(
                            'Olvidé mi contraseña',
                            style: TextStyle(
                                fontFamily: "HelveticaNeue",
                                fontWeight: FontWeight.bold,
                                fontSize: responsive.ip(3.3),
                                color: Color(0xFF000000)
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

  Widget _crearBody(BuildContext context){
    final responsive = Responsive(context);
    return Container(
       margin: EdgeInsets.only(left: responsive.wp(6), right: responsive.wp(6), top: 12),
      child: Column(
        children: <Widget>[
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                   'Para poder restablecer tu contraseña necesitamos validar tu número de teléfono y tu correo electrónico asociados a tu cuenta Hino.',
                  //  textAlign: TextAlign.justify,
                   style: 
                   TextStyle(
                     height: 1.4,
                     fontFamily: "HelveticaNeue",
                     fontStyle: FontStyle.normal,
                     fontWeight: FontWeight.w500,
                     fontSize: responsive.ip(2.1),
                     color: Color(0xFF1C1C1C)
                   ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          _crearInputCelular(context),
          _crearInputCorreo(context),
        ],
      )
    );
  }

  Widget _crearInputCelular(BuildContext buildContext) {
    final responsive = new Responsive(context);
    var maskFormatter = new MaskTextInputFormatter(
        mask: '###-###-###', filter: {"#": RegExp(r'[0-9]')});
    TextField(inputFormatters: [maskFormatter]);
    return Container(
      margin: EdgeInsets.only(bottom: 8),
        child: TextFormField(
          initialValue: usuarioModel.sCelular,
          onSaved: (value) {
            usuarioModel.sCelular = value;
          },
          onChanged: (value){
          usuarioModel.sCelular = value;
        },
          keyboardType: TextInputType.number,
          inputFormatters: [maskFormatter],
          decoration: InputDecoration(
             contentPadding: new EdgeInsets.symmetric(vertical: responsive.ip(2.5), horizontal: 10.0),
            border: OutlineInputBorder(),
               hintStyle: TextStyle(
           fontSize: responsive.ip(2.1),
          fontFamily: "HelveticaNeue",
          fontWeight: FontWeight.w500,
          color: Color(0xFF94949A)
         ),
         labelStyle: TextStyle(
           fontSize: responsive.ip(2.2),
          fontFamily: "HelveticaNeue",
          fontWeight: FontWeight.w500,
          color: Color(0xFF94949A)
         ),
            hintText: '###-###-###',
            labelText: 'Celular',
          ),
          validator: (String value) {
            if (utils.validarCelular(value)) {
              return null;
            } else {
              return "El número es de 9 dígitos";
            }
          },
        ));
  }


  Widget _crearInputCorreo(BuildContext context){
    // final responsive = Responsive(context);
    return Container(
         
        child: TextFormCrearCuenta(
          initialValue: usuarioModel.sCorreo,
          keyboardType: TextInputType.emailAddress,
          border: OutlineInputBorder(),
          hintText: "ejemplo@correo.com.pe",
          labelText: "Correo electrónico",
          onSaved: (value) {
            usuarioModel.sCorreo = value;
          },
          onChange: (value){
          usuarioModel.sCorreo = value;
        },
          // errorText: snapshot.error,
          validator: (String value) {
            if (utils.validarCorreo(value)) {
              return null;
            } else {
              return "Correo incorrecto";
            }
          },
        ));
  }



  Widget _crearButtonEnviarMensaje(BuildContext context) {
    final responsive = Responsive(context);

    return Container(
     margin: EdgeInsets.only(left: responsive.wp(6), right: responsive.wp(6), bottom:16),
      child: SizedBox(
            height: responsive.ip(7.2),
           width: double.infinity,
            child: RaisedButton(
                child: Container(
                    child: Text(
                  "Continuar",
                 style: TextStyle(
                    fontSize: responsive.ip(2.4), //16.0,
                    fontStyle: FontStyle.normal,
                    color: Colors.white,
                    fontFamily: 'HelveticaNeue',
                    fontWeight: FontWeight.bold
                  )
                )),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0)),
                elevation: 0.0,
                color: Color(0xffE60012),
                textColor: Colors.white,
                onPressed: () {
                  //  Navigator.pushReplacementNamed(context, 'validacionSmsRecuperarContrasena');
                  // _validarCelular(context, usuarioModel);
                  if (_formKeyRecuperarPassword.currentState.validate() 
                      ) {
                    print("validate");
                    _validarCelular(context, usuarioModel);
                    _validarCorreo(context, usuarioModel);
                  }
                    
                }),
          ),
        //
      );
    
  }

  _validarCelular(BuildContext context, UsuarioModel usuarioModel) async {
    //  Navigator.pushReplacementNamed(context, 'validacionSmsRecuperarContrasena');
    if (_isFetching) {
      return;
    } else {
      setState(() {
        _isFetching = true;
      });
      // usuarioModel.sCorreo = '@';
      final isValid =
          await usuarioProvider.validarCelular(context, usuarioModel.sCelular, usuarioModel.sCorreo);
      if (isValid) {
        String sActivationCode = await usuarioProvider.enviarCodigoValidacion(
            context, usuarioModel.sCorreo, usuarioModel.sCelular);
        // String sActivationCode = await usuarioProvider.enviarCodigoValidacion(
        //   context, usuarioModel.sCelular);
        if (sActivationCode != "") {
          print(usuarioModel);
          var oParam = jsonEncode(
              {"oUsuario": usuarioModel.toJson(), "iActivacionCode": sActivationCode});
          Navigator.pushReplacementNamed(context, 'validacionSmsRecuperarContrasena',
              arguments: oParam);
        }
        setState(() {
          _isFetching = false;
        });
      } else {
        setState(() {
          _isFetching = false;
        });
      }
      setState(() {
        _isFetching = false;
      });
    }
  }

  _validarCorreo(BuildContext context, UsuarioModel usuarioModel) async {
    if (_isFetching) {
      return;
    } else {
      setState(() {
        _isFetching = true;
      });
      final isValid =
          await usuarioProvider.validarCorreo(context, usuarioModel.sCorreo);
      if (isValid) {
        String sActivationCode = await usuarioProvider.enviarCodigoValidacion(
            context, usuarioModel.sCorreo, usuarioModel.sCelular);
        if (sActivationCode != "") {
          print(usuarioModel);
          
          var oParam = jsonEncode(
              {"oUsuario": usuarioModel.toJson(), "iActivacionCode": sActivationCode});
          Navigator.pushReplacementNamed(context, 'validacionSmsRecuperarContrasena',
              arguments: oParam);
        }
        setState(() {
          _isFetching = false;
        });
      } else {
        setState(() {
          _isFetching = false;
        });
      }
      setState(() {
        _isFetching = false;
      });
    }
  }

}
