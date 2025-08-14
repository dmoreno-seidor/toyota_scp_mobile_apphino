import 'package:flutter/material.dart';
import 'package:toyota_scp_mobile_apphino/src/app_config.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';
// import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';
// import 'package:toyota_scp_mobile_apphino/src/utils/formatters.dart';
// import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';

class ContainerConcesionarioPremioLoading extends StatefulWidget {
  

  const ContainerConcesionarioPremioLoading({Key key, }) : super(key: key);

  @override
  _ContainerConcesionarioPremioLoading createState() => _ContainerConcesionarioPremioLoading();
}

class _ContainerConcesionarioPremioLoading extends State<ContainerConcesionarioPremioLoading> {
  //bool isExpanded = false,

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: _buildConcesionarioDetallePremioList,//iterar
      itemCount: 2,
      shrinkWrap: true,
    );
  }

    Widget _buildConcesionarioDetallePremioList(
      BuildContext context,
      int index,
    ) {
    final _responsive = Responsive(context);
    return Stack(
      children: <Widget>[
        Container(
           margin:EdgeInsets.only( bottom: 16.0),
          // margin: EdgeInsets.only(bottom: 20.0),
          width: MediaQuery.of(context).size.width,
          child:  Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    child:  Image.asset('assets/campania/iconoCarga.gif'
                    ,fit: BoxFit.fitWidth,
                          width: double.infinity,),
                    
                        
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
