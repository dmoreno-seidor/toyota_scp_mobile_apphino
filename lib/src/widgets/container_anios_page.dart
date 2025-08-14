import 'package:flutter/material.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/mis_premios_bloc.dart';

class ContainerAnios extends StatefulWidget {
  final List aAnios;
  final MisPremiosBloc misPremiosBloc;

  const ContainerAnios({Key key, this.aAnios, this.misPremiosBloc})
      : super(key: key);

  @override
  _ContainerAnios createState() => _ContainerAnios();
}

class _ContainerAnios extends State<ContainerAnios> {
  List<Map> listOfMa;
  bool isExpanded = false;
  int selected = 0;
  String _seleccionado = "Todos";
  String respuesta = "";
  @override
  Widget build(BuildContext context) {
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
    return Column(
      children: <Widget>[
        RadioListTile(
          dense: false,
          
          value: widget.aAnios[index].anio,
          groupValue: widget.misPremiosBloc.sFilterRespuestaAnioLastValue == ""
              ? _seleccionado
              : widget.misPremiosBloc
                  .sFilterRespuestaAnioLastValue, //_seleccionado, //widget.aAnios[index].anio,
          onChanged: (ind) {
            setState(() {
              _seleccionado = widget.aAnios[index].anio;
              if (_seleccionado == "Todos") {
                respuesta = _seleccionado;
                widget.misPremiosBloc.changeRespuestaAnio("");
              } else {
                respuesta = _seleccionado;
                widget.misPremiosBloc.changeRespuestaAnio(respuesta);
              }
            });
          },
          activeColor: Color(0xFFE60012),
          title: Text(
            widget.aAnios[index].anio,
            style: TextStyle(
              fontSize: 14,
              fontFamily: "HelveticaNeue",
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
            ),
          ),
          selected: false,
        ),
        Divider(
          color: Color(0xff96969b),
        )
      ],
    );
  }
}
