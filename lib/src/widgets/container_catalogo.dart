import 'package:flutter/material.dart';
import 'package:toyota_scp_mobile_apphino/src/estilos.dart';
// import 'package:toyota_scp_mobile_apphino/src/models/unidad_model.dart';
import 'package:toyota_scp_mobile_apphino/src/pages/bloc/catalogo_bloc.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';

import '../app_config.dart';

class ContainerCatalogo extends StatefulWidget {
  final List aCatalogo;
  final CatalogoBloc catalogoBloc;

  const ContainerCatalogo({Key key, this.aCatalogo, this.catalogoBloc}) : super(key: key);

  @override
  _ContainerCatalogo createState() => _ContainerCatalogo();
}

class _ContainerCatalogo extends State<ContainerCatalogo> {
  List<Map> listOfMa;
  bool isExpanded = false;
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    Responsive _responsive = new Responsive(context);
    return 
    widget.aCatalogo.length==0?_noBuildCatalogoList():
    Container(
       margin: EdgeInsets.only(
                          left: _responsive.wp(3),
                          right: _responsive.wp(3),
                          ),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        
        itemBuilder: _buildCategoriaList,
        itemCount: widget.aCatalogo.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
            childAspectRatio: //0.7

            // childAspectRatio : MediaQuery.of(context).size.height / 1000
            MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 1.369),
            
                ),

                
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        
      ),
    );
  }

   Widget _noBuildCatalogoList(){
    Responsive _responsive = new Responsive(context);
    return Container(
      // margin: EdgeInsets.all(8),
      margin:EdgeInsets.only(left:16.0, right: 16.0, bottom: 16.0),
      child: Text(
        'No existen premios en esta categoría.',
                   // 'No hay Eventos Vigentes',
                    // style: AppConfig.styleSubCabecerasPaginas,
                    style: TextStyle(
      // fontFamily: 'HelveticaNeue',
      fontFamily: "HelveticaNeue",
      fontSize: _responsive.ip(2.4),//16,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
      color: Colors.black),

                  ),
    );
  }

  Widget _buildCategoriaList(
    BuildContext context,
    int index,
  ) {
    final _responsive = Responsive(context);
    print(widget.aCatalogo[index].codigo);
    return GestureDetector(
      onTap: (){
        widget.catalogoBloc.changeCodigoPremio(widget.aCatalogo[index].codigo);
        Navigator.pushNamed(context, 'detallePremio',arguments: widget.aCatalogo[index]);
      },
          child: Container(
            height: 100,
          width: _responsive.wp(40),
          margin: EdgeInsets.all(8),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Center(
                      child: Container(
                        // width: _responsive.ip(15),//89,
                        height: _responsive.ip(15),
                                                //  width: 89,
                          // margin: EdgeInsets.only(
                          //     top: 25, left: 26, right: 26, bottom: 10),
                              margin: EdgeInsets.only(
                              top: 15,//_responsive.ip(3.75), 
                              left:15, right: 15, 
                              bottom: _responsive.ip(1.5)),
                          child: Hero(
                          
                              tag:
                                  '${widget.aCatalogo[index].codigo}-catalogo', //"id",
                              child: 


FadeInImage.assetNetwork(
                          image: 
                                                widget.aCatalogo[index].imagen
                                                    .replaceAll('/bridge/',
                                                        "${AppConfig.api_host_docService}"),
                                  //"${AppConfig.api_host_docService}"),
                          placeholder: 'assets/campania/iconoCarga.gif',
                          fadeInDuration: Duration(milliseconds: 200),
                           fit: BoxFit.fill,
                        )







                              // Image.network(
                              //         widget.aCatalogo[index].imagen!=""?
                              //                   widget.aCatalogo[index].imagen
                              //                       .replaceAll('/bridge/',
                              //                           "${AppConfig.api_host_docService}")
                                                        
                              //                           :"",
                              //                   fit: BoxFit.fill,
                                                 
                              //                 )
                              ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),

                            //  color: Colors.blue,
                            // image: DecorationImage(

                            //     image: new NetworkImage(
                            //         "https://http2.mlstatic.com/polos-de-moda-D_NQ_NP_590315-MPE25203895704_122016-F.webp"),
                            //     fit: BoxFit.fill))),
                          ))),
                  Container(
                    padding: EdgeInsets.only(left: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                                                  child: Column(
                            children: <Widget>[
                               Row(
                                 children: <Widget>[
                                   Container(
                                    
                                    child: Text(
                                    
                                      widget.aCatalogo[index]
                                        .codigo,
                                        // style: AppConfig.styleCodigoCatalogoPremio,
                                        style: TextStyle(
                                        color: Color(0xFF94949A),
                                        // fontFamily: 'HelveticaNeue',
                                        fontFamily: "HelveticaNeue",
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FontStyle.normal,
                                        fontSize: _responsive.ip(1.5)),
                                        ), 
                              ),
                                 ],
                               ),
                              //  SizedBox(height: 2.5,),
                              Container(height: _responsive.ip(0.375),),

                              Row(
                                children: <Widget>[
                                  Container(
                                    
                                    child: Flexible( 
                                                                          child: Text(
                                      
                                        widget.aCatalogo[index]
                                          .descrip,maxLines: 2, overflow: TextOverflow.ellipsis,
                                          // style: AppConfig.styleTituloCatalogoPremio,
                                        style:  TextStyle(
                                          color: Color(0xFF000000),
                                          // fontFamily: 'HelveticaNeue',
                                          fontFamily: "HelveticaNeue",
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.normal,
                                          fontSize: _responsive.ip(1.8))
                                          ),
                                    ), //Text("CASACA DEPORTIVA GHZ89"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              new Positioned(
                  top: _responsive.ip(1.5),//10.0,
                  right: 0.0,
                  child: 
                  // Container(
                  //   height: 30,
                  //   // width: 100,
                  //   padding: EdgeInsets.only(left: 5,right: 5),
                  //   child: Center(
                  //       child: Text(
                  //     "${widget.aCatalogo[index].puntos} Puntos",
                  //     textAlign: TextAlign.center,
                  //     style: TextStyle(
                  //         fontFamily: 'HelveticaNeue',
                  //         fontSize: 12.0,
                  //         fontWeight: FontWeight.bold,
                  //         color: Color(0xFF1C1C1C))
                  //   )),
                  //   decoration: BoxDecoration(
                  //     color: Color(0xffFFC837),
                  //     borderRadius: BorderRadius.only(
                  //         topLeft: Radius.circular(25),
                  //         bottomLeft: Radius.circular(25)),
                  //   ),
                  // )

                  Container(
                padding: EdgeInsets.only(left: 7.0, right: 4.0),
                height: _responsive.ip(3.6),//24,
                // width: 98,
                                    decoration: BoxDecoration(
                      color: Color(0xffFFC837),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          bottomLeft: Radius.circular(25)),
                    ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "${widget.aCatalogo[index].puntos} Puntos",
                      style: TextStyle(
                          fontFamily: 'HelveticaNeue',
                          fontSize: _responsive.ip(1.5),//10.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1C1C1C)),
                    ),
                  ],
                ),
              )
                  
                  
                  
                  ),
            ],
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: [AppConfig.boxShadow],
          )),
    );
  }
}
