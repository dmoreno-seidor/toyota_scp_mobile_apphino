import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:toyota_scp_mobile_apphino/src/models/usuario_model.dart';
import 'package:toyota_scp_mobile_apphino/src/providers/usuario_provider.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/dialogs.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/utils.dart' as utils;

import '../preferencias_usuario/preferencias_usuario.dart';
import '../comportamiento_usuario/comportamiento_usuario.dart';

class NuevaContrasenaPage extends StatefulWidget {
  @override
  _NuevaContrasenaPageState createState() => _NuevaContrasenaPageState();
}

class _NuevaContrasenaPageState extends State<NuevaContrasenaPage> with WidgetsBindingObserver {
  final _formKeyNuevoPassword = GlobalKey<FormState>();
  final prefs = new PreferenciasUsuario();
  UsuarioModel usuarioModel = UsuarioModel();
  final usuarioProvider = new UsuarioProvider();
  

  bool passwordVisible1 = false;
  bool passwordVisible2 = false;
  TextEditingController _valorInputNuevoPassword = TextEditingController();
  TextEditingController _valorInputConfirmarNuevoPassword = TextEditingController();
  var _isFetching = false;
  Map usuarioEnvio;

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
    Map<String, dynamic> usuarioEnvio =
        jsonDecode(ModalRoute.of(context).settings.arguments);
    
    final responsive = Responsive(context);

    return Scaffold(
          resizeToAvoidBottomInset: false,
      body: Stack(
          children: <Widget>[
            Form(
              key: _formKeyNuevoPassword,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _crearBanner(context),
                  Container(
                        margin: EdgeInsets.only(left: responsive.wp(6)),
                        child: Divider(
                          color: Color(0xFFE60012),
                          endIndent: responsive.wp(85.0),
                          thickness: 1.0,
                        )),
                  //  SizedBox(height: 17),
                  _crearBody(),
                   Expanded(child: Container()),
                  _crearButton(usuarioEnvio),
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
                                      color:
                                          index.isEven ? Colors.red : Colors.red,
                                    ),
                                  );
                                }),
                            Text(
                              "Actualizando contraseña..",
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
                                     left: responsive.wp(6), right: responsive.wp(6), top: 7),
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
                      'Nueva contraseña',
                      style: TextStyle(
                                fontFamily: "HelveticaNeue",
                                fontWeight: FontWeight.bold,
                                fontSize: responsive.ip(3.3),
                                color: Color(0xFF000000)
                            )
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearBody(){
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
                   'Ingresa y confirma tu nueva contraseña para poder terminar',
                  //  textAlign: TextAlign.justify,
                   style: TextStyle(
                     height: 1.4,
                     fontFamily: "HelveticaNeue",
                     fontStyle: FontStyle.normal,
                     fontWeight: FontWeight.w500,
                     fontSize: responsive.ip(2.1),
                     color: Color(0xFF1C1C1C)
                   ),
                ),
                SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
          _crearCajasPasswords(),
        ],
      )
    );
  }

  Widget _crearCajasPasswords() {
    final responsive = new Responsive(context);
    return Container(
      // margin: EdgeInsets.only(bottom: 8),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 8),
            child: TextFormField(
              // controller: _valorInputNuevoPassword,
              initialValue: _valorInputNuevoPassword.text,
              onSaved: (value) {
                _valorInputNuevoPassword.text = value;
              },
              onChanged: (value){
               _valorInputNuevoPassword.text = value;
            },
              textCapitalization: TextCapitalization.sentences,
              textAlign: TextAlign.start,
              obscureText: !passwordVisible1,
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
                hintText: 'Escribir tu contraseña',
                labelText: 'Nueva contraseña',
                suffixIcon: IconButton(
                  icon: Icon(
                    passwordVisible1 ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: (() {
                    setState(() {
                      passwordVisible1 = !passwordVisible1;
                    });
                  }),
                ),
                 
                // onChanged: (value) => usuarioBloc.changePassword(value),
              ),
              validator: (String value) {
              if (utils.validarRecuperarPassword(value)) {
                return null;
              } else {
                return "Más de 6 caracteres por favor";
              }
            },
            ),
          ),
          Container(
          //  margin: EdgeInsets.only(bottom: 8),
            child: TextFormField(
              // controller: _valorInputConfirmarNuevoPassword,
              initialValue: _valorInputConfirmarNuevoPassword.text,
               onSaved: (value) {
               _valorInputConfirmarNuevoPassword.text = value;
              },
              onChanged: (value){
              _valorInputConfirmarNuevoPassword.text = value;
            },
              textCapitalization: TextCapitalization.sentences,
              textAlign: TextAlign.start,
              obscureText: !passwordVisible2,
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
                hintText: 'Escribir tu contraseña',
                labelText: 'Confirmar nueva contraseña',
                suffixIcon: IconButton(
                  icon: Icon(
                    passwordVisible2 ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: (() {
                    setState(() {
                      passwordVisible2 = !passwordVisible2;
                    });
                  }),
                ),
                // onChanged: (value) => usuarioBloc.changePassword(value),
              ),
               validator: (String value) {
              if (utils.validarRecuperarPassword(value)) {
                return null;
              } else {
                return "Más de 6 caracteres por favor";
              }
            },
            ),
          )
        ],
      ),
    );
  }

  Widget _crearButton(Map<String,dynamic> usuarioEnvio) {
    final responsive = Responsive(context);
    
    return Container(
      margin: EdgeInsets.only(left: responsive.wp(6), right: responsive.wp(6), bottom:16),
      child: SizedBox(
            height: responsive.ip(7.2),
           width: double.infinity,
            child: RaisedButton(
                child: Container(
                    child: Text(
                  "Actualizar",
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
                // onPressed: () => _validacion(context),
                onPressed: () {
                  final parentContext = context;
                  if( _formKeyNuevoPassword.currentState.validate()){
                    
                    // print("validate");
                    if( _valorInputNuevoPassword.text != _valorInputConfirmarNuevoPassword.text){
                      //  Dialogs.alertDialog(context,
                      // title: "¡Ups...!",
                      // message: "Las contraseñas no son iguales",
                      // onOk: () {});
                      Dialogs.succedDialog(context,
                      title: "Aviso",
                      message: "Las contraseñas no son iguales",
                      onOk: () {
                        Navigator.pop(parentContext);
                      });

                    }else {
                      _restablecerPassword(context, usuarioEnvio);
                      print(Text('Claves iguales'));
                      
                    }
                  }
                  
                }),
          ),
    );
  }


  _restablecerPassword(BuildContext context, Map usuarioEnvio) async{
     if (_isFetching) {
      return;
    } else {
      setState(() {
        _isFetching = true;
      });

      var email = usuarioEnvio["oUsuario"]["sCorreo"];
      
      final isValid =
          await usuarioProvider.actualizarUserPassword(context, email ,_valorInputNuevoPassword.text);
      if (isValid) {
           Dialogs.succedDialog(context,
              title: "¡Excelente!",
              message: "Tu contraseña ha sido restablecida con éxito, ahora solo regresa al login e inicia sesión con tus nuevas credenciales", 
              onOk: () {
                Navigator.pushReplacementNamed(context, "login");
            });
        //     var timer = Timer(Duration(seconds: 3), () {
        //     Navigator.pushReplacementNamed(context, "login");
        // });

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
