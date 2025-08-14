import 'package:flutter/material.dart';
// import 'package:toyota_scp_mobile_apphino/src/estilos.dart';
// import 'package:toyota_scp_mobile_apphino/src/models/talla_model.dart';
// import 'package:toyota_scp_mobile_apphino/src/models/unidad_model.dart';
// import 'package:toyota_scp_mobile_apphino/src/pages/bloc/mis_premios_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/mis_servicios_bloc.dart';
// import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';
// import '../app_config.dart';

class ContainerAniosServicios extends StatefulWidget {
  final List aAnios;
  final MisServiciosBloc misServiciosBloc;

  const ContainerAniosServicios({Key key, this.aAnios, this.misServiciosBloc}) : super(key: key);

  @override
  _ContainerAniosServicios createState() => _ContainerAniosServicios();
}

class _ContainerAniosServicios extends State<ContainerAniosServicios> {
  List<Map> listOfMa;
  bool isExpanded = false;
  int selected = 0;
  String _seleccionado = "Todos";
  String respuesta ="";
  @override
  Widget build(BuildContext context) {
    // return ListView.builder(
    //   itemBuilder: (context, index) {
    //     return RadioListTile(
    //       value: index,
    //       groupValue: widget.aAnios[index].anio,
    //       onChanged: (ind) => setState(() => widget.aAnios[index].anio = ind),
    //       title: Text("Number $index"),
    //     );
    //     // return Container();
    //   },
    //   itemCount: widget.aAnios.length,
    // );
    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: _buildContainerAnioList,
      itemCount: widget.aAnios.length,
      shrinkWrap: true,
    );
  }

  Widget _buildContainerAnioList(
    BuildContext context,
    int index,
  ) {
    
    return  Column( 
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        RadioListTile(
              value: widget.aAnios[index].anio,
              groupValue: widget.misServiciosBloc.sFilterRespuestaAnioLastValue==""?_seleccionado:widget.misServiciosBloc.sFilterRespuestaAnioLastValue,//_seleccionado, //widget.aAnios[index].anio,
              onChanged: (ind) {
                setState(() {
                  _seleccionado = widget.aAnios[index].anio;
                  if(_seleccionado=="Todos"){
                    respuesta = _seleccionado;
                    widget.misServiciosBloc.changeRespuestaAnio("");
                  }else{
                    respuesta = _seleccionado;
                    widget.misServiciosBloc.changeRespuestaAnio(respuesta);
                  }
                  
                });
              },
              activeColor: Colors.red,
              title: Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 10,
                    child: Text(widget.aAnios[index].anio))
                ],
              ),
              selected: false,
            //   subtitle: Divider(
            //   color: Color(0xff96969b),
            // ),
            ),
      ],
    );
  }
}
