import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../estilos.dart';
import '../models/concesionario_model.dart';
import '../pages/bloc/citas_bloc.dart';
import '../utils/dialogs.dart';
import '../utils/responsive.dart';
import '../app_config.dart';
import '../constantes.dart';
import '../pages/maps_permission.dart';
import '../preferencias_usuario/preferencias_usuario.dart';
import '../comportamiento_usuario/comportamiento_usuario.dart';

/// @author Daniel Carpio
class ContainerConcesionarioCitasLoading extends StatefulWidget {

  const ContainerConcesionarioCitasLoading(
      {Key key})
      : super(key: key);

  @override
  _ContainerConcesionarioCitasLoading createState() => _ContainerConcesionarioCitasLoading();
}

class _ContainerConcesionarioCitasLoading extends State<ContainerConcesionarioCitasLoading> {
  List<Map> listOfMa;
  bool isExpanded = false;
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: _buildConcesionarioList,
      itemCount: 3,
      shrinkWrap: true,
    );
  }

  Widget _buildConcesionarioList(
    BuildContext context,
    int index) {
    final _responsive = Responsive(context);

// return  Container(
//         //  height: _responsive.wp(40),
//           // width: _responsive.wp(40),
//           // margin: EdgeInsets.all(8),
    
//           decoration: BoxDecoration(
//             image: DecorationImage(
//           image: AssetImage(
//               'assets/campania/iconoCarga.gif'),
//           fit: BoxFit.cover,
//         ),
//             borderRadius: BorderRadius.circular(5),
//             color: Colors.white,
//             boxShadow: [AppConfig.boxShadow],
//           ),
//     );



    return Stack(
      children: <Widget>[
        Container(
          
          margin: EdgeInsets.only(bottom: 20.0),
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    child:  Image.asset('assets/campania/iconoCarga.gif'),
                        
                  ),
                ],
              ),
             
            ]
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: [AppConfig.boxShadow],
          ),
        ),
        
      ],
    );
  }

}
