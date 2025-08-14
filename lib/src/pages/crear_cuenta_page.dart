import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:toyota_scp_mobile_apphino/src/app_config.dart';
import 'package:toyota_scp_mobile_apphino/src/constantes.dart';
import 'package:toyota_scp_mobile_apphino/src/models/cargo_usuario_model.dart';
import 'package:toyota_scp_mobile_apphino/src/models/tipo_documento_model.dart';
import 'package:toyota_scp_mobile_apphino/src/models/usuario_model.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/cargo_usuario_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/datos_maestros_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/tipo_documento_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/usuario_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/validators.dart';
import 'package:toyota_scp_mobile_apphino/src/providers/usuario_provider.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/dialogs.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';
import 'package:toyota_scp_mobile_apphino/src/widgets/text_form_crear_cuenta.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/utils.dart' as utils;
import 'bloc/Provider.dart';

import '../preferencias_usuario/preferencias_usuario.dart';
import '../comportamiento_usuario/comportamiento_usuario.dart';

class CrearCuentaPage extends StatefulWidget {
  @override
  _CrearCuentaPageState createState() => _CrearCuentaPageState();
}

class _CrearCuentaPageState extends State<CrearCuentaPage>
    with WidgetsBindingObserver {
  final _formKeyCrearCuenta = GlobalKey<FormState>();
  final prefs = new PreferenciasUsuario();
  TipoDocumentoBloc tipoDocumentosBloc = TipoDocumentoBloc();
  CargoUsuarioBloc cargoUsuarioBloc = CargoUsuarioBloc();
  DatosMaestrosBloc datosMaestrosBloc = new DatosMaestrosBloc();
  UsuarioBloc usuarioBloc = new UsuarioBloc();
  final usuarioProvider = new UsuarioProvider();
  UsuarioModel usuarioModel = UsuarioModel();
  Validators validators;

  String _tipoSeleccionadoTipoDocumento;
  // String _tipoSeleccionadoCargoUsuario;
  bool _bloquearCheck1 = false;
  bool _bloquearCheck2 = false;
  bool passwordVisible = false;
  var _isFetching = false;
  String selectedSalutation;

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    // tipoDocumentosBloc.dispose();
    // cargoUsuarioBloc.dispose();
    // usuarioBloc.dispose();
  }

  @override
  void initState() {
    super.initState();
    usuarioBloc = UsuarioBloc();
    WidgetsBinding.instance.addObserver(this);
    tipoDocumentosBloc.cargarTipoDocumento();
    cargoUsuarioBloc.cargarCargoUsuario();
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
    final responsive = new Responsive(context);
    usuarioBloc = Provider.usuarioBloc(context);

    // cargoUsuarioBloc= Provider.cargoUsuarioBloc(context);
    // tipoDocumentosBloc= Provider.tipoDocumentoBloc(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: SingleChildScrollView(
              child: Form(
                key: _formKeyCrearCuenta,
                child: Column(
                  children: <Widget>[
                    _crearBanner(),
                    Container(
                        margin:
                            EdgeInsets.only(left: responsive.wp(6), bottom: 8),
                        child: Divider(
                          color: Color(0xFFE60012),
                          endIndent: responsive.wp(87.0),
                          thickness: 1.0,
                        )),
                    _crearCajasTexto(context),
                    _crearCheckBoxes(context),
                    SizedBox(height: 15),
                    _crearButton(context),
                    SizedBox(height: 16),
                  ],
                  // ),
                  // ),
                  // ],
                ),
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
                            "Cargando...",
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
    // );
    // },
  }

  Widget _crearBanner() {
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
                      // padding: EdgeInsets.only(bottom: 10),
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
                  SizedBox(height: 18.76),
                  Text(
                    'Crear cuenta',
                    style: TextStyle(
                        fontFamily: "HelveticaNeue",
                        fontWeight: FontWeight.bold,
                        fontSize: responsive.ip(3.3),
                        color: Color(0xFF000000)),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _crearCajasTexto(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(right: 10.0, left: 10.0, top: 2.0),
      child: Column(
        children: <Widget>[
          _crearInputCorreo(context),
          _crearDropDownTipoDocumento(context),
          _crearInputDNI(context),
          _crearInputNombre(context),
          _crearInputApaterno(context),
          // _crearInputAmaterno(context),
          // _crearDropDownCargoUsuario(context),
          _crearInputCelular(context),
          _crearPassword(context),
        ],
      ),
    );
  }

  Widget _crearInputCorreo(BuildContext context) {
    final responsive = Responsive(context);
    return Container(
        // height: responsive.ip(9),
        // width: responsive.ip(43.2),
        margin: EdgeInsets.only(
            left: responsive.wp(6), right: responsive.wp(6), bottom: 8),
        child: TextFormCrearCuenta(
          initialValue: usuarioModel.sCorreo,
          keyboardType: TextInputType.emailAddress,
          border: OutlineInputBorder(),
          hintText: "ejemplo@correo.com.pe",
          labelText: "Correo electrónico",
          onSaved: (value) {
            usuarioModel.sCorreo = value;
          },
          onChange: (value) {
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
    // }
    // );
  }

  List<DropdownMenuItem<String>> getOpcionesDropdownTipoDocumento(
      BuildContext context, List<TipoDocumentoModel> tipoDocumentos) {
    Responsive _responsive = new Responsive(context);
    List<DropdownMenuItem<String>> lista = new List();
    if (tipoDocumentos != null) {
      tipoDocumentos.forEach((elemento) {
        lista.add(DropdownMenuItem(
          child: Text(elemento.tipoDocumento,
              style: TextStyle(
                  fontFamily: 'HelveticaNeue',
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  fontSize: _responsive.ip(1.8), //12.0,
                  color: Colors.black)),
          value: elemento.id.toString(),
        ));
        print(elemento);
      });
    }

    return lista;
  }

  List<DropdownMenuItem<String>> getOpcionesDropdownCargoUsuario(
      BuildContext context, List<CargoUsuarioModel> cargoUsuarios) {
    Responsive _responsive = new Responsive(context);
    List<DropdownMenuItem<String>> lista = new List();
    if (cargoUsuarios != null) {
      cargoUsuarios.forEach((elemento) {
        lista.add(DropdownMenuItem(
          child: Container(
              margin: EdgeInsets.only(
                  left: _responsive.wp(6), right: _responsive.wp(6)),
              child: Text(elemento.cargoUsuario,
                  style: TextStyle(
                      fontFamily: 'HelveticaNeue',
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                      fontSize: _responsive.ip(1.8), //12.0,
                      color: Colors.black))),
          value: elemento.id.toString(),
        ));
        print(elemento);
      });
    }

    return lista;
  }

  Widget _crearDropDownTipoDocumento(BuildContext context) {
    final responsive = Responsive(context);
    return StreamBuilder<Object>(
        stream: tipoDocumentosBloc.tipoDocumentosStream,
        builder: (context, snapshot) {
          return Container(
            margin: EdgeInsets.only(
                left: responsive.wp(6), right: responsive.wp(6), bottom: 8),
            child: Container(
              height: responsive.ip(7.8),
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 1,
                          style: BorderStyle.solid,
                          color: Color(0xff9D9D9D)),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)))),
              child: Container(
                // margin: EdgeInsets.only(left: responsive.wp(1), right: responsive.wp(1)),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                      contentPadding: new EdgeInsets.symmetric(horizontal: 2.0),
                      border: InputBorder.none),
                  value: _tipoSeleccionadoTipoDocumento,
                  hint: Text(
                    'Tipo Documento',
                    style: TextStyle(
                        fontSize: responsive.ip(2.1),
                        fontFamily: "HelveticaNeue",
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF94949A)),
                  ),
                  icon: Icon(Icons.keyboard_arrow_down),
                  iconEnabledColor: Color(0xFFE60012),
                  isExpanded: true,
                  onChanged: (opt) {
                    setState(() {
                      _tipoSeleccionadoTipoDocumento = opt;

                      usuarioModel.idTipoDocumento =
                          int.parse(_tipoSeleccionadoTipoDocumento, radix: 10);
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Campo Requerido(*)' : null,
                  items: snapshot.hasData == false
                      ? []
                      : getOpcionesDropdownTipoDocumento(
                          context, snapshot.data),
                ),
              ),
            ),
          );
        });
    // }
    // );
  }

  Widget _crearInputDNI(BuildContext buildContext) {
    final responsive = new Responsive(context);
    return Container(
      // height: responsive.ip(9),
      margin: EdgeInsets.only(
          left: responsive.wp(6), right: responsive.wp(6), bottom: 8),
      child: TextFormCrearCuenta(
        initialValue: usuarioModel.sNumeroDocumento,
        onSaved: (value) {
          usuarioModel.sNumeroDocumento = value;
        },
        onChange: (value) {
          usuarioModel.sNumeroDocumento = value;
        },
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly,
        ],
        border: OutlineInputBorder(),
        hintText: "70546577",
        labelText: 'Número de Documento',
        validator: (String value) {
          if (utils.validarNumeroDocumento(
              value, _tipoSeleccionadoTipoDocumento)) {
            return null;
          } else {
            return "No cumple el formato del tipo de documento";
          }
        },
        // onChanged: (value) => usuarioBloc.changeNumeroDocumento(value),
      ),
      // );
      // }
    );
  }

  Widget _crearInputNombre(BuildContext context) {
    final responsive = new Responsive(context);
    return Container(
      // height: responsive.ip(9),
      margin: EdgeInsets.only(
          left: responsive.wp(6), right: responsive.wp(6), bottom: 8),
      child: TextFormCrearCuenta(
        initialValue: usuarioModel.sNombres,
        onSaved: (value) {
          usuarioModel.sNombres = value;
        },
        keyboardType: TextInputType.text,
        inputFormatters: [WhitelistingTextInputFormatter(RegExp("[a-zA-Z -]"))],
        border: OutlineInputBorder(),
        hintText: "Escribe tu nombre",
        labelText: 'Nombre',
        onChange: (value) {
          usuarioModel.sNombres = value;
        },
        validator: (String value) {
          if (utils.validarNombre(value)) {
            return null;
          } else {
            return "El nombre debe tener por lo menos un carácter";
          }
        },
        // onChanged: (value) => usuarioBloc.changeNombre(value)
      ),
      // );
      // }
    );
  }

  Widget _crearInputApaterno(BuildContext context) {
    final responsive = new Responsive(context);
    return Container(
        //  height: responsive.ip(9),
        margin: EdgeInsets.only(
            left: responsive.wp(6), right: responsive.wp(6), bottom: 8),
        child: TextFormCrearCuenta(
          initialValue: usuarioModel.sApellidoPaterno,
          onSaved: (value) {
            usuarioModel.sApellidoPaterno = value;
          },
          onChange: (value) {
            usuarioModel.sApellidoPaterno = value;
          },
          keyboardType: TextInputType.text,
          inputFormatters: [
            WhitelistingTextInputFormatter(RegExp("[a-zA-Z -]"))
          ],
          border: OutlineInputBorder(),
          hintText: "Escribe tu apellido paterno",
          labelText: 'Apellido paterno',
          // onChanged: (value) =>
          //     usuarioBloc.changeApellidoPaterno(value)
        ));
    // }
    // );
  }

  Widget _crearInputCelular(BuildContext buildContext) {
    final responsive = new Responsive(context);
    var maskFormatter = new MaskTextInputFormatter(
        mask: '###-###-###', filter: {"#": RegExp(r'[0-9]')});
    TextField(inputFormatters: [maskFormatter]);

    // return StreamBuilder<Object>(
    //     stream: usuarioBloc.sCelularStream,
    //     builder: (context, snapshot) {
    return Container(
        margin: EdgeInsets.only(
            left: responsive.wp(6), right: responsive.wp(6), bottom: 8),
        child: TextFormField(
          initialValue: usuarioModel.sCelular,
          onSaved: (value) {
            usuarioModel.sCelular = value;
          },
          onChanged: (value) {
            usuarioModel.sCelular = value;
          },
          keyboardType: TextInputType.number,
          inputFormatters: [maskFormatter],
          decoration: InputDecoration(
            contentPadding: new EdgeInsets.symmetric(
                vertical: responsive.ip(2.5), horizontal: 10.0),
            border: OutlineInputBorder(),
            hintStyle: TextStyle(
                fontSize: responsive.ip(2.1),
                fontFamily: "HelveticaNeue",
                fontWeight: FontWeight.w500,
                color: Color(0xFF94949A)),
            labelStyle: TextStyle(
                fontSize: responsive.ip(2.2),
                fontFamily: "HelveticaNeue",
                fontWeight: FontWeight.w500,
                color: Color(0xFF94949A)),
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
    // }
    // );
  }

  Widget _crearPassword(BuildContext context) {
    final responsive = new Responsive(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          //  height: responsive.ip(9),
          margin: EdgeInsets.only(
              left: responsive.wp(6), right: responsive.wp(6), bottom: 8),
          child: TextFormCrearCuenta(
            initialValue: usuarioModel.sPassword,
            onSaved: (value) {
              usuarioModel.sPassword = value;
            },
            onChange: (value) {
              usuarioModel.sPassword = value;
            },
            obscureText: !passwordVisible,
            border: OutlineInputBorder(),
            hintText: "Escribe tu contraseña",
            labelText: 'Contraseña',
            suffixIcon: IconButton(
              icon: Icon(
                passwordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: (() {
                setState(() {
                  passwordVisible = !passwordVisible;
                });
              }),
            ),
            validator: (String value) {
              if (utils.validarPassword(value)) {
                return null;
              } else {
                return "No cumple con el formato indicado";
              }
            },
            // onChanged: (value) => usuarioBloc.changePassword(value)
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: responsive.wp(6)),
          // child: Text('*Utiliza 8 o más carácteres(números, letras mayúsculas y minúsculas)',
          child: Text(
            '*Utilizar 8 o mas caracteres/números, letras mayúsculos y minúsculas. No incluir nombre, apellido o partes del correo electrónico del usuario.',
            style: TextStyle(
              fontSize: responsive.ip(1.45),
              fontFamily: "HelveticaNeue",
            ),
          ),
        )
      ],
    );
    // }
    // );
  }

  Widget _crearCheckBoxes(BuildContext context) {
    final responsive = new Responsive(context);
    TextStyle defaultStyle = TextStyle(
      color: Color(0xff1C1C1C),
      fontSize: responsive.ip(1.8),
      fontFamily: "HelveticaNeue",
    );
    TextStyle linkStyle = TextStyle(
      fontSize: responsive.ip(1.8),
      color: Color(0xFFE60012),
      fontWeight: FontWeight.normal,
      fontFamily: "HelveticaNeue",
    );

    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Checkbox(
                      activeColor: Color(0xffE60012),
                      value: _bloquearCheck1,
                      onChanged: (bool value) {
                        setState(() {
                          _bloquearCheck1 = value;
                        });
                        usuarioModel.bTerminoCondiciones = _bloquearCheck1;

                        // usuarioBloc
                        //     .changeTerminosCondiciones(_bloquearCheck1);
                      },
                    ),
                    Flexible(
                      child: RichText(
                          text: TextSpan(
                        style: defaultStyle,
                        children: <TextSpan>[
                          TextSpan(
                              text: 'He leído y acepto los ',
                              style: TextStyle(
                                  fontSize: responsive.ip(1.8),
                                  fontFamily: "HelveticaNeue",
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF1C1C1C))),
                          TextSpan(
                              text: 'términos y condiciones',
                              style: linkStyle,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Dialogs.informationDialog(context,
                                      title: "TÉRMINOS Y CONDICIONES",
                                      message: Constantes.terminosYcondiciones,
                                      onOk: () {});
                                }),
                          //  StyledText(
                          //     text: 'Test: <bold>bold</bold> and <red>red color</red> text.',
                          //     styles: {
                          //       'bold': TextStyle(fontWeight: FontWeight.bold),
                          //       'red': TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                          //     },
                          //   ),

                          TextSpan(
                              text: ' del aviso legal ',
                              style: TextStyle(
                                  fontSize: responsive.ip(1.8),
                                  fontFamily: "HelveticaNeue",
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF1C1C1C))),
                        ],
                      )),
                    ),
                  ],
                ),
                !_bloquearCheck1
                    ? Padding(
                        padding: EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                        child: Text('Campo Obligatorio(*)',
                            style: TextStyle(
                                fontFamily: "HelveticaNeue",
                                color: Color(0xFFe53935),
                                fontSize: responsive.ip(1.8))),
                      )
                    : Container()
              ],
            ),
            // );
            // }
          ),
          // StreamBuilder<Object>(
          //     stream: usuarioBloc.bAutorizacionDatosPersonalesStream,
          //     builder: (context, snapshot) {
          //       return
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Checkbox(
                        activeColor: Color(0xffE60012),
                        value: _bloquearCheck2,
                        onChanged: (bool value) {
                          setState(() {
                            _bloquearCheck2 = value;
                          });
                          usuarioModel.bAutorizacionDatosPersonales =
                              _bloquearCheck2;
                        }),
                    Flexible(
                      child: RichText(
                          text: TextSpan(
                        style: defaultStyle,
                        children: <TextSpan>[
                          TextSpan(
                              text:
                                  'Autorización de uso de datos personales y aceptación de ',
                              style: TextStyle(
                                  fontSize: responsive.ip(1.8),
                                  fontFamily: "HelveticaNeue",
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF1C1C1C))),
                          TextSpan(
                              text: 'políticas de privacidad.',
                              style: linkStyle,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Dialogs.informationDialog(context,
                                      title: "POLÍTICAS Y PRIVACIDAD",
                                      message: Constantes.politicasYprivacidad,
                                      onOk: () {});
                                }),
                        ],
                      )),
                    ),
                  ],
                ),
                !_bloquearCheck2
                    ? Padding(
                        padding: EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                        child: Text('Campo Obligatorio(*)',
                            style: TextStyle(
                                fontFamily: "HelveticaNeue",
                                color: Color(0xFFe53935),
                                fontSize: responsive.ip(1.8))),
                      )
                    : Container()
              ],
            ),
          )
          // }
          // ),
        ],
      ),
    );
  }

  Widget _crearButton(BuildContext context) {
    final responsive = Responsive(context);

    return Column(
      // padding: EdgeInsets.all(5.0),
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 16, right: 16),
          child: SizedBox(
            height: responsive.ip(7.2),
            width: double.infinity,
            child: RaisedButton(
                child: Container(
                    child: Text("Continuar",
                        style: TextStyle(
                            fontSize: responsive.ip(2.4), //16.0,
                            fontStyle: FontStyle.normal,
                            color: Colors.white,
                            fontFamily: 'HelveticaNeue',
                            fontWeight: FontWeight.bold))),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0)),
                elevation: 0.0,
                color: Color(0xffE60012),
                textColor: Colors.white,
                // onPressed: () => _validacion(context),
                onPressed: () {
                  if (_formKeyCrearCuenta.currentState.validate() &&
                      _bloquearCheck1 &&
                      _bloquearCheck2) {
                    print("validate");
                    _validarCorreo(context, usuarioModel);
                  }
                }
                // snapshot.hasData
                //     ? () {
                //         // _validacion(context);
                //         _validarCorreo(context, usuarioBloc);
                //       }
                //     : null

                ),
          ),
        ),
      ],
      //
    );
  }

  _validarCorreo(BuildContext context, UsuarioModel usuarioModel) async {
    if (_isFetching) {
      return;
    } else {
      setState(() {
        _isFetching = true;
      });
      final isValidDocumento = await usuarioProvider.validarDocumento(
          context, usuarioModel.idTipoDocumento, usuarioModel.sNumeroDocumento);
      if (isValidDocumento) {
        final isValid =
            await usuarioProvider.validarCorreo(context, usuarioModel.sCorreo);

        if (isValid) {
          String sActivationCode = await usuarioProvider.enviarCodigoValidacion(
              context, usuarioModel.sCorreo, usuarioModel.sCelular);
          if (sActivationCode != "") {
            print(usuarioModel);

            var oParam = jsonEncode({
              "oUsuario": usuarioModel.toJson(),
              "iActivacionCode": sActivationCode
            });
            Navigator.pushReplacementNamed(context, 'validacionSms',
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
      }
      setState(() {
        _isFetching = false;
      });
    }
  }
}
