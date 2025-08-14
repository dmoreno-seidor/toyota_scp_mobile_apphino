import 'package:flutter/material.dart';
import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';
// import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';

import '../app_config.dart';
// import 'package:toyota_scp_mobile_apphino/src/utils/responsive.dart';

class ContainerNoticias extends StatefulWidget {
  final List aNoticias;

  const ContainerNoticias({Key key, this.aNoticias}) : super(key: key);

  @override
  _ContainerNoticiasState createState() => _ContainerNoticiasState();
}

class _ContainerNoticiasState extends State<ContainerNoticias> {
  //  int id;

  @override
  Widget build(BuildContext context) {
    return widget.aNoticias.length == 0
        ? _noBuildNoticiaList()
        : ListView.builder(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: _buildNoticiaList, //iterar
            itemCount: widget.aNoticias.length,
            shrinkWrap: true,
          );
  }

  Widget _noBuildNoticiaList() {
    Responsive _responsive = new Responsive(context);
    return Container(
      margin: EdgeInsets.only(left: 22, bottom: 16.0),
      child: Text(
        'Por el momento no tenemos Noticias disponibles para ti.',
        //'No hay Noticias Vigentes',
        // style: AppConfig.styleSubCabecerasPaginas,
        style: TextStyle(
            // fontFamily: 'HelveticaNeue',
            fontFamily: "HelveticaNeue",
            fontSize: _responsive.ip(2.4), //16,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            color: Colors.white),
      ),
    );
  }

  Widget _buildNoticiaList(BuildContext context, int index) {
    //  final _responsive = Responsive(context);
    print(widget.aNoticias[index].id);
    Responsive _responsive = new Responsive(context);
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: _responsive.wp(6), right: _responsive.wp(6), bottom: 16.0),
// margin: EdgeInsets.only(bottom: 20.0),
          width: MediaQuery.of(context).size.width,
          child: Column(children: <Widget>[
            Hero(
              tag: '${widget.aNoticias[index].id}-noticia',
                  child:
                ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        topRight: Radius.circular(5.0)),
                    child: FadeInImage.assetNetwork(
                      image: widget.aNoticias[index].imagen.replaceAll(
                          '/bridge/', "${AppConfig.api_host_docService}"),
                      placeholder: 'assets/campania/iconoCarga.gif',
                      fadeInDuration: Duration(milliseconds: 200),
                      // fit: BoxFit.cover,
                      fit: BoxFit.fitWidth,
                      width: double.infinity,
                      // height: 192,
                      // width: 320,
                    ))
                    
          ),
              
            
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'noticiasDetalle',
                  arguments: widget.aNoticias[index]),
              child: Container(

                // margin: EdgeInsets.only(top: _responsive.ip(30.0) // 158
                //     ),
                // margin: EdgeInsets.only(top:
                // _responsive.ip(26.7)// 158
                
                // ),

                    
                color: Colors.white,
                child: Container(
// padding: EdgeInsets.all(16),
                    child: ListTile(
                         dense:true,
                  // dense:true,
                  // contentPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                  title: Container(
                    // margin: EdgeInsets.only(bottom: 1),
                    child: Text(
                      "${widget.aNoticias[index].nombre}",
                      style: TextStyle(
                          fontFamily: 'HelveticaNeue',
                          fontSize: _responsive.ip(2.1),//14.0,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF000000)),
                    ),
                  ),
                  subtitle: Text(
                    "Publicada el ${widget.aNoticias[index].publicadoDesde}",
                    style: TextStyle(
                        fontFamily: 'HelveticaNeue',
                        fontSize: _responsive.ip(1.8),//12.0,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        color: Color(0xFF94949A)),
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: Color(0xFFE60012),
                    size: _responsive.ip(5.25)//30,
                  ),
                )),
              ),
            )
          ]),
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: [AppConfig.boxShadow],
          ),
        ),
      ],
    );

    // return  Container(
    //   margin:EdgeInsets.only(left:16.0, right: 16.0, bottom: 16.0),
    //   // height: 227,
    //   // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
    //   child:Card(

    //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.stretch,
    //         children: <Widget>[
    //         Hero(
    //           tag: '${widget.aNoticias[index].id}-noticia',
    //               child: ClipRRect(
    //               borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0),topRight: Radius.circular(5.0)),
    //               child: FadeInImage.assetNetwork(
    //                   image: widget.aNoticias[index].imagen.replaceAll('/bridge/',
    //                           "${AppConfig.api_host_docService}"),
    //                   placeholder: 'assets/campania/iconoCarga.gif',
    //                   fadeInDuration: Duration(milliseconds: 200),
    //                   // fit: BoxFit.cover,
    //                   fit: BoxFit.fitWidth,
    //                   width: double.infinity,
    //                   // height: 192,
    //                   // width: 320,

    //                 )
    //             ),
    //           ),
    //           GestureDetector(
    //             onTap: ()=>Navigator.pushNamed(context, 'noticiasDetalle', arguments: widget.aNoticias[index]),
    //               child: ListTile(
    //                 // dense:true,
    //               // contentPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
    //               title:Container(
    //                 margin: EdgeInsets.only(bottom:1),
    //                 child: Text("${widget.aNoticias[index].nombre}",
    //                   style: TextStyle(
    //                     fontFamily: 'HelveticaNeue',
    //                     fontSize: 14.0,
    //                     fontStyle: FontStyle.normal,
    //                     fontWeight: FontWeight.bold,
    //                     color: Color(0xFF000000)
    //                   ),
    //                 ),
    //               ),
    //               subtitle:Text("Publicada el ${widget.aNoticias[index].publicadoDesde}",
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
    //                 size: 30,
    //               ),
    //             ),
    //           )
    //         ],
    //       ),
    //     ),
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.all(Radius.circular(5.0)),
    //     // border: Border.all(color: Colors.pinkAccent)
    //     // color: Colors.white,
    //     // boxShadow: [AppConfig.boxShadow],
    //   ),
    // );
  }
}
