import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:toyota_scp_mobile_apphino/src/estilos.dart';
// import 'package:toyota_scp_mobile_apphino/src/models/unidad_model.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/catalogo_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';
// import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';

import '../app_config.dart';

class ContainerCatalogoCategorias extends StatefulWidget {
  final List aCategorias;
  final CatalogoBloc catalogoBloc;

  const ContainerCatalogoCategorias({Key key, this.aCategorias, this.catalogoBloc}) : super(key: key);

  @override
  _ContainerCatalogoCategorias createState() => _ContainerCatalogoCategorias();
}

class _ContainerCatalogoCategorias extends State<ContainerCatalogoCategorias> {
  List<Map> listOfMa;
  bool isExpanded = false;
  int selected = 0;
  // CatalogoBloc catalogoBloc = new CatalogoBloc();
  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
                  padding: EdgeInsets.zero,
                  // physics: NeverScrollableScrollPhysics(),
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
    final _responsive = Responsive(context);
    //[{"3":"false"},{"10":"false"},{"11":"false"},{"14":"false"}];

    print(widget.aCategorias[index].codigo);
    return GestureDetector(
          child: Container(
            width: _responsive.ip(9.6),
                                // margin: EdgeInsets.only(right: 16),
                                margin: EdgeInsets.only(left: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        width: _responsive.ip(9.6),//64.0
                                        height: _responsive.ip(9.6),//64.0,
                                        child: widget.aCategorias[index].seleccionado==false?
                                        // Image.network(
                                        //           widget.aCategorias[index].iconoDesactivado
                                        //               .replaceAll('/bridge/',
                                        //                   "${AppConfig.api_host_docService}"),
                                        //           fit: BoxFit.fill,
                                        //         )

                                        Stack(
                                          children: <Widget>[

                                             
                                            CachedNetworkImage(
                                            imageUrl: widget.aCategorias[index].iconoDesactivado
                                                      .replaceAll('/bridge/',
                                                          "${AppConfig.api_host_docService}"),
                                              fit : BoxFit.cover,
                                             
                                              errorWidget: (context,url,error)=>Icon(Icons.error)),
                                              CachedNetworkImage(
                                              width: 0,
                                              height: 0,
                                            imageUrl: widget.aCategorias[index].iconoActivo
                                                      .replaceAll('/bridge/',
                                                          "${AppConfig.api_host_docService}"),
                                              fit : BoxFit.cover,
                                             
                                              errorWidget: (context,url,error)=>Icon(Icons.error))
                                            
                                          ],
                                        )
                                        

                                                :
                                           CachedNetworkImage(
                                            imageUrl: widget.aCategorias[index].iconoActivo
                                                      .replaceAll('/bridge/',
                                                          "${AppConfig.api_host_docService}"),
                                              fit : BoxFit.cover,
                                             
                                              errorWidget: (context,url,error)=>Icon(Icons.error))     
                                                
                                                
                                                // Image.network(
                                                //   widget.aCategorias[index].iconoActivo
                                                //       .replaceAll('/bridge/',
                                                //           "${AppConfig.api_host_docService}"),
                                                //   fit: BoxFit.fill,
                                                // ),
                                        // decoration: BoxDecoration(
                                        //   shape: BoxShape.circle,
                                        //   color: Color(0xffE5E5E5),
                                        // )
                                        ),
                                    Flexible(
                                                                          child: Container(
                                          margin: EdgeInsets.only(top: 5),
                                          child: Text(widget.aCategorias[index].nombre 
                                          ,style: widget.aCategorias[index].seleccionado==false?
                                          // EstilosConfig.styleEtiquetaCategoriaPremio
                                          TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'HelveticaNeue',
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FontStyle.normal,
                                      fontSize: _responsive.ip(1.42))
                                          :
                                          // EstilosConfig.styleEtiquetaCategoriaPremioActivo
                                          TextStyle(
      color: Color(0xffE60012),
      fontFamily: 'HelveticaNeue',
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.normal,
      fontSize: _responsive.ip(1.42))
                                          ,
                                          
                                          
                                          textAlign: TextAlign.center,
                    overflow: TextOverflow.fade,)
                                          
                                          
                                          ),
                                    )
                                        
                                  ],
                                ),
                              ),
         onTap: ()async{
          //  Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
            setState(() {
            if(widget.aCategorias[index].seleccionado==false){
                
                    widget.aCategorias[index].seleccionado = true;
                 
            }else if(widget.aCategorias[index].seleccionado){
                // setState(() {
                    widget.aCategorias[index].seleccionado = false;
                  // });
            }  
            List codigoCategoriasSeleccionadas = new List();
            String filtro;
            widget.aCategorias.forEach((x){
                if(x.seleccionado){
                  codigoCategoriasSeleccionadas.add(x.codigo);
                }
            });
            filtro=codigoCategoriasSeleccionadas.join(',');
            
            // catalogoBloc.changeGrupoFamiliaCatalogo(filtro);
            if(filtro!=""){
                //  setState(() {
                  widget.catalogoBloc.changeGrupoFamiliaCatalogo(filtro); 
                //catalogoBloc.cargarCatalogo("toyota@prueba.com", filtro, 12.00, 12.00, 0);
                  // });
            }else{
               widget.catalogoBloc.changeGrupoFamiliaCatalogo(""); 
              //  widget.catalogoBloc.cargarCatalogo("toyota@prueba.com", filtro, 12.00, 12.00, 0);

            }
            
            
            //catalogoBloc.actualizarFiltro(filtro);

              });
          },
    );
  }
}
