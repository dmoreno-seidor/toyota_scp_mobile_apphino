import 'package:flutter/material.dart';
import 'package:toyota_scp_mobile_apphino/src/app_config.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';
// import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';
// import 'package:toyota_scp_mobile_apphino/src/utils/formatters.dart';
// import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';

class ContainerCampanias extends StatefulWidget {
  final List aCampanias;

  const ContainerCampanias({Key key, this.aCampanias}) : super(key: key);

  @override
  _ContainerCampanias createState() => _ContainerCampanias();
}

class _ContainerCampanias extends State<ContainerCampanias> {
  //bool isExpanded = false,

  @override
  Widget build(BuildContext context) {
    return  widget.aCampanias.length==0?
    _noBuildCampaniaList()
    :
    
    ListView.builder(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: _buildCampaniaList,//iterar
      itemCount: widget.aCampanias.length,
      shrinkWrap: true,
    );
  }
  Widget _noBuildCampaniaList(){
    Responsive _responsive = new Responsive(context);
    return Container(
      margin:EdgeInsets.only( bottom: 16.0),
      child: Text(
                    // 'No hay campañas vigentes',
                    'Por el momento no tenemos campañas disponibles para ti.',
                    // style: AppConfig.styleSubCabecerasPaginas,
                    style: TextStyle(
      // fontFamily: 'HelveticaNeue',
      fontFamily: "HelveticaNeue",
      fontSize: _responsive.ip(2.4),//16,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
      color: Colors.white),

                  ),
    );
  }

    Widget _buildCampaniaList(
      BuildContext context,
      int index,
    ) {
    final _responsive = Responsive(context);
    print(widget.aCampanias[index].id);



    return Stack(
      children: <Widget>[
        Container(
           margin:EdgeInsets.only( bottom: 16.0),
          // margin: EdgeInsets.only(bottom: 20.0),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                 ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(4.0),topRight: Radius.circular(4.0)),
                child: Hero(
                  tag: '${widget.aCampanias[index].id}-campania',
                    child: FadeInImage.assetNetwork(
                          image: widget.aCampanias[index].imagen.replaceAll('/bridge/',
                          "${AppConfig.api_host_docService}"),
                                  //"${AppConfig.api_host_docService}"),
                          placeholder: 'assets/campania/iconoCarga.gif',
                          fadeInDuration: Duration(milliseconds: 200),
                          fit: BoxFit.fitWidth,
                          width: double.infinity,
                          // height: 192,
                        ),
                )
              )
                ],
              ),

                GestureDetector(  
                onTap: ()=>Navigator.pushNamed(context, 'campaniasDetalle',arguments: widget.aCampanias[index]),
                  child:  Container(
                    // height: 65,
                // margin: EdgeInsets.only(top:
                // _responsive.ip(30.0)// 158
                // margin: EdgeInsets.only(top:
                // _responsive.ip(26.7)// 158
                
                // ),
                color: Colors.white,
                    
                    child: Container(
                      // margin: EdgeInsets.only(bottom: 8,top: 8),
                      child: ListTile(
                        dense:true,
                      // contentPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
                      title:Text("${widget.aCampanias[index].nombre}",
                        style: TextStyle(
                          fontFamily: 'HelveticaNeue',
                          fontSize: _responsive.ip(2.1),//14.0,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF000000)
                        ),
                      ),
                      subtitle:Text("Vigencia hasta el ${widget.aCampanias[index].vigencia}",
                        style: TextStyle(
                          fontFamily: 'HelveticaNeue',
                          fontSize: _responsive.ip(1.8),//12.0,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          color: Color(0xFF94949A)
                        ),
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        color: Color(0xFFE60012),
                        size: _responsive.ip(5.25),//35,
                      ),
                ),
                    ),
                  ),
              )
              

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




    // return Container(
    //   margin:EdgeInsets.only(left:16.0, right: 16.0, bottom: 16.0),
      
    //   child:Card(
        
    //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
    //       child: Column(
            
    //         children: <Widget>[
    //           ClipRRect(
    //             borderRadius: BorderRadius.only(topLeft: Radius.circular(4.0),topRight: Radius.circular(4.0)),
    //             child: Hero(
    //               tag: '${widget.aCampanias[index].id}-campania',
    //                 child: FadeInImage.assetNetwork(
    //                       image: widget.aCampanias[index].imagen.replaceAll('/bridge/',
    //                       "${AppConfig.api_host_docService}"),
    //                               //"${AppConfig.api_host_docService}"),
    //                       placeholder: 'assets/campania/iconoCarga.gif',
    //                       fadeInDuration: Duration(milliseconds: 200),
    //                       fit: BoxFit.fitWidth,
    //                       width: double.infinity,
    //                       height: 192,
    //                     ),
    //             )
    //           ),
    //           GestureDetector(  
    //             onTap: ()=>Navigator.pushNamed(context, 'campaniasDetalle',arguments: widget.aCampanias[index]),
    //               child: ListTile(
    //                 dense:true,
    //               contentPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
    //               title:Text("${widget.aCampanias[index].nombre}",
    //                 style: TextStyle(
    //                   fontFamily: 'HelveticaNeue',
    //                   fontSize: 14.0,
    //                   fontStyle: FontStyle.normal,
    //                   fontWeight: FontWeight.bold,
    //                   color: Color(0xFF000000)
    //                 ),
    //               ),
    //               subtitle:Text("Vigencia hasta el ${widget.aCampanias[index].vigencia}",
    //                 style: TextStyle(
    //                   fontFamily: 'HelveticaNeue',
    //                   fontSize: 12.0,
    //                   fontWeight: FontWeight.w500,
    //                   fontStyle: FontStyle.normal,
    //                   color: Color(0xFF94949A)
    //                 ),
    //               ),
    //               trailing: Icon(
    //                 Icons.keyboard_arrow_right,
    //                 color: Color(0xFFE60012),
    //                 size: 35,
    //               ),
    //             ),
    //           )
    //         ],
    //       ),
    //     ),
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.all(Radius.circular(4.0)),
    //     // color: Colors.white,
    //     // boxShadow: [AppConfig.boxShadow],
    //   ),
    // );
}

}
