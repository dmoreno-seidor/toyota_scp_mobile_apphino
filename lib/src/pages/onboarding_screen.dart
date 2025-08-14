import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toyota_scp_mobile_apphino/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';

import '../constantes.dart';
import '../comportamiento_usuario/comportamiento_usuario.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with WidgetsBindingObserver {
  final prefs = new PreferenciasUsuario();
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    final responsive = Responsive(context);
    return Container(
      // margin: EdgeInsets.only(top: responsive.ip(7.2)),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        margin: EdgeInsets.all(8),
        height: responsive.ip(1.2),
        width: isActive ? responsive.ip(6):responsive.ip(6),
        decoration: BoxDecoration(
          color: isActive ? Color(0xFFE60012) : Color(0xFFDADADC),
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
      ),
    );
  }

  _guardarPrefsOmitirOnboardinScreen() {
    prefs.ocultarOnBoardingScreen = '1';

    Navigator.pushReplacementNamed(context, 'login');
  }

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
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: [
                Color(0xFFFFFFFF),
                Color(0xFFFFFFFF),
                Color(0xFFFFFFFF),
                Color(0xFFFFFFFF),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(top :responsive.ip(12.15), left: responsive.ip(3.75), right: responsive.ip(3.75),), //40.0),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: responsive.ip(51.5), //600.0,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                     Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: Image(
                                  image: AssetImage(
                                    'assets/onBoardingScreen/Icono-1.png',
                                  ),
                                  height: responsive.ip(25.2),//responsive.hp(28), //300.0,
                                  width: responsive.ip(25.2),//responsive.wp(60) //300.0,
                                  ),
                            ),
                            SizedBox(height: 40.0),
                            Text(
                              Constantes.tituloPrimerOutBoarding,
                              style: TextStyle(
                                  fontFamily: "HelveticaNeue",
                                  color: Color(0xFF1C1C1C),
                                  fontSize: responsive.ip(2.7),//responsive.hp(2.5), //26.0,
                                  // height: 1.5,
                                  fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              Constantes.detallePrimerOutBoarding,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "HelveticaNeue",
                                color: Color(0xFF1C1C1C),
                                fontSize: responsive.ip(2.1),//responsive.hp(2.2), //18.0,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            // SizedBox(height: 48.0),
                          ],
                        ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: Image(
                                  image: AssetImage(
                                    'assets/onBoardingScreen/Icono-2.png',
                                  ),
                                  height: responsive.ip(25.2),//responsive.hp(28), //300.0,
                                  width: responsive.ip(25.2),
                                  ),
                            ),
                            SizedBox(height: 40.0),
                            Text(
                              Constantes.tituloSegundoOutBoarding,
                              style: TextStyle(
                                fontFamily: "HelveticaNeue",
                                  color: Color(0xFF1C1C1C),
                                  fontSize: responsive.ip(2.7),//responsive.hp(2.5), //26.0,
                                  // height: 1.5,
                                  fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              Constantes.detalleSegundoOutBoarding,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "HelveticaNeue",
                                color: Color(0xFF1C1C1C),
                                fontSize: responsive.ip(2.1),
                                fontWeight: FontWeight.w500
                                //responsive.hp(2.2), //18.0,
                                // height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: Image(
                                  image: AssetImage(
                                    'assets/onBoardingScreen/Icono-3.png',
                                  ),
                                height: responsive.ip(25.2),//responsive.hp(28), //300.0,
                                  width: responsive.ip(25.2),)//)
                            ),
                            SizedBox(height: 40.0),
                            Text(
                              Constantes.tituloTercerOutBoarding,
                              // 'Get a new experience\nof imagination',
                              style: TextStyle(
                                fontFamily: "HelveticaNeue",
                                  color: Color(0xFF1C1C1C),
                                  fontSize: responsive.ip(2.7),//responsive.hp(2.5), //20.0,
                                  // height: 1.5,
                                  fontWeight: FontWeight.bold
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 8.0),
                            Container(
                              // padding: EdgeInsets.symmetric(horizontal: responsive.wp(1)),
                              child: Text(
                                Constantes.detalleTercerOutBoarding,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "HelveticaNeue",
                                  color: Color(0xFF1C1C1C),
                                fontSize: responsive.ip(2.1),//responsive.hp(2.2), //18.0,
                                  // height: 1.2,
                                ),
                              ),
                            )
                          ],
                        ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage == _numPages - 1
                    ? Container(
                      margin:
                            EdgeInsets.only( top: responsive.ip(8.4)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: responsive.ip(6), //60,
                              width: responsive.width*0.80, //285,
                              child: RaisedButton(
                                  child: Container(
                                      child: RichText(
                                          text: TextSpan(children: <TextSpan>[
                                    TextSpan(
                                        text: "Empezar",
                                        style: TextStyle(
                                            fontSize: responsive.ip(2.4), //16.0,
                                            fontStyle: FontStyle.normal,
                                            color: Colors.white,
                                            fontFamily: 'HelveticaNeue'),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap =
                                              _guardarPrefsOmitirOnboardinScreen),
                                  ]))),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(100.0)),
                                  elevation: 0.0,
                                  color: Color(0xffE60012),
                                  textColor: Colors.white,
                                  onPressed:
                                      _guardarPrefsOmitirOnboardinScreen),
                            ),
                          ],
                        ),
                      )
                    :Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    margin:
                            EdgeInsets.only( top: responsive.ip(9.75)),
                                    child: RichText(
                                        text: TextSpan(children: <TextSpan>[
                                      TextSpan(
                                          text: 'Saltar',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                              fontSize:
                                                 responsive.ip(1.8),
                                              color: Color(0xffE60012),
                                              fontFamily: 'HelveticaNeue'),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap =
                                                _guardarPrefsOmitirOnboardinScreen),
                                    ])),
                                  ),
                                ],
                              )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
