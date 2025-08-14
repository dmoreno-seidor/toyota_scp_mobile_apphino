import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/Provider.dart';
// import 'package:toyota_scp_mobile_apphino/src/pages/splash.dart';
// import 'package:toyota_scp_mobile_apphino/src/pages/bloc/encuesta_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:toyota_scp_mobile_apphino/src/providers/push_notifications_provider.dart';
import 'package:toyota_scp_mobile_apphino/src/routes/routes.dart';
// import 'package:toyota_scp_mobile_apphino/src/utils/dialogs.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp( new MyApp());
} 
 

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
 final prefs = new PreferenciasUsuario();
 final pushProvider = PushNotificationProvider();
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
    // print(_prefs.token);
  
  @override
  Widget build(BuildContext context) {
    // EncuestaBloc encuestaBloc = Provider.encuestaBloc(context);
    int valor =0;
    // final parentContext = context;
    pushProvider.initNotifications(context);
    pushProvider.mensajesCampania.listen( (data){
      // valor = valor + 1;
      // print(valor);
      // navigatorKey.currentState.pushNamedAndRemoveUntil(newRouteName, (route) => false)
      navigatorKey.currentState.pushNamed('campaniasDetalle',arguments: data);
    } ); 
    pushProvider.mensajesEvento.listen( (data){

      navigatorKey.currentState.pushNamed('eventosDetalle',arguments: data);
    } ); 
    pushProvider.mensajesNoticia.listen( (data){

      navigatorKey.currentState.pushNamed('noticiasDetalle',arguments: data);
    } ); 
    return Provider(
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        title: 'App Hino',
        initialRoute: prefs.ultimaPagina,
        // home: SplashPage(),
        routes: getAplicationRoutes(),
      ),
    );
  }
}


