import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';
// import 'package:geolocator/geolocator.dart';

import '../estilos.dart';
import '../pages/bloc/citas_bloc.dart';
import '../app_config.dart';

class ContainerCitasCategorias extends StatefulWidget {
  final List aCategorias;
  final CitasBloc citasBloc;

  const ContainerCitasCategorias({Key key, this.aCategorias, this.citasBloc})
      : super(key: key);

  @override
  _ContainerCitasCategorias createState() => _ContainerCitasCategorias();
}

class _ContainerCitasCategorias extends State<ContainerCitasCategorias> {
  List<Map> listOfMa;
  bool isExpanded = false;
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemBuilder: _buildCategoriaList,
      itemCount: widget.aCategorias.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
    );
  }

  Widget _buildCategoriaList(
    BuildContext context,
    int index,
  ) {
    print(widget.aCategorias[index].codigo);
    Responsive _responsive  = new Responsive(context);
    return GestureDetector(
      child: Container(
        // margin: EdgeInsets.only(right: 16),
        margin: EdgeInsets.only(left: 16),
        width: _responsive.ip(9.6),//64.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: _responsive.ip(9.6),//64.0,
              height: _responsive.ip(9.6),//64.0,
              child: widget.aCategorias[index].seleccionado == false? 
              
              Stack(
                                          children: <Widget>[

                                            CachedNetworkImage(
                                            imageUrl: widget.aCategorias[index].iconoDesactivado.replaceAll(
                          '/bridge/', "${AppConfig.api_host_docService}"),
                                              fit : BoxFit.cover,
                                             
                                              errorWidget: (context,url,error)=>Icon(Icons.error)),
                                            CachedNetworkImage(
                                              width: 0,
                                              height: 0,
                                            imageUrl: widget.aCategorias[index].iconoActivo.replaceAll(
                          '/bridge/', "${AppConfig.api_host_docService}"),
                                              fit : BoxFit.cover,
                                             
                                              errorWidget: (context,url,error)=>Icon(Icons.error)),
                                             
                                            
                                            
                                          ],
                                        )
              
              
              
                  : CachedNetworkImage(
                                            imageUrl: widget.aCategorias[index].iconoActivo.replaceAll(
                          '/bridge/', "${AppConfig.api_host_docService}"),
                                              fit : BoxFit.cover,
                                             
                                              errorWidget: (context,url,error)=>Icon(Icons.error)),
            ),
            Flexible(
                          child: Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text(
                    widget.aCategorias[index].descripcion,
                    style: widget.aCategorias[index].seleccionado == false?
                    TextStyle(
      color: Colors.black,
      fontFamily: 'HelveticaNeue',
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.normal,
      fontSize: _responsive.ip(1.42)):

      TextStyle(
      color: Color(0xffE60012),
      fontFamily: 'HelveticaNeue',
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.normal,
      fontSize: _responsive.ip(1.42)),

                    // EstilosConfig.styleEtiquetaCategoriaPremio:
                    // EstilosConfig.styleEtiquetaCategoriaPremioActivo,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.fade,
                  )),
            )
          ],
        ),
      ),
      onTap: () async {
        // Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        setState(() {
          widget.aCategorias[index].seleccionado = !widget.aCategorias[index].seleccionado;

          List codigoCategoriasSeleccionadas = new List();
          String filtro;
          widget.aCategorias.forEach((x) {
            if (x.seleccionado) {
              // codigoCategoriasSeleccionadas.add(x.codigo);
              codigoCategoriasSeleccionadas.add(x.descripcion);
            }
          });

          filtro = codigoCategoriasSeleccionadas.join(',');
          if (filtro != "") {
            widget.citasBloc.changeServicios(filtro);
            //  widget.citasBloc.consultarConcesionarioxCiudadxServicios(
            //    widget.citasBloc.sFiltroCiudad, widget.citasBloc.sFiltroServicios, position?.latitude, position?.longitude);
          }else{
            widget.citasBloc.changeServicios("");
            // widget.citasBloc.consultarConcesionarioxCiudadxServicios(
            //    widget.citasBloc.sFiltroCiudad, widget.citasBloc.sFiltroServicios, position?.latitude, position?.longitude);
          }
        });
      },
    );
  }
}
