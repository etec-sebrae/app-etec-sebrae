import 'dart:convert';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:seetec_projeto/View/perfil_page.dart';

import 'documento_page.dart';

const urlEvento = "https://api-seetec.herokuapp.com/api/evento";

class PaginaInicial extends StatefulWidget {
  @override
  _PaginaInicialState createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  Color corPrimaria = const Color(0xff223249);
  Color corSecundaria = const Color(0xff5263BB);
  Color corContainer = const Color(0xff394BB1);
  Color corContainerDescricaoInicio = const Color(0xff5264CB);
  Color corContainerDescricaoFim = const Color(0xff3A4BB5);
  Color corSegundoIcon = const Color(0xff394BB3);
  Color corTerceiroIcone = const Color(0xff5165C6);
  Color corQuartoIcone = const Color(0xff627BF2);
  Color corQuintoIcone = const Color(0xff6BB5FE);
  List eventos = [];

  Widget construirContainer(String titulo, String data, String descricao) {
    return Container(
      padding: EdgeInsets.only(right: 5.0),
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.0)),
                  title: Text(
                    titulo,
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: corPrimaria,
                  content: Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                corContainerDescricaoInicio,
                                corContainerDescricaoFim
                              ]),
                        ),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 20.0, 0.0, 10.0),
                              child: Text(
                                descricao,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.0),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 300.0),
                              child: RaisedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Voltar1'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              });
        },
        child: Container(
          decoration: BoxDecoration(
            color: corSecundaria,
            borderRadius: BorderRadius.circular(15.0),
          ),
          height: 220,
          width: 240,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15.0, 20.0, 0.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  titulo,
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
                SizedBox(height: 10.0),
                Text(
                  data,
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget construirBotao(Color cor, String texto) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0)),
            color: cor,
            child: Stack(
              children: <Widget>[
                SizedBox(
                  height: 60,
                  width: 200,
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 25, 0.0, 0.0),
                    child: Text(
                      texto,
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(280.0, 20, 0.0, 0.0),
                    child: SvgPicture.asset(
                      'assets/papel.svg',
                      color: Colors.white,
                      width: 30,
                      height: 30,
                    ))
              ],
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DocumentoPage()),
              );
            },
          ),
        ),
      ],
    );
  }

  Future<List<dynamic>> carregarLista() async {
    Response response = await get(urlEvento);

    if (response.body.isNotEmpty) {
      Map retorno = json.decode(response.body);
      eventos = [];
      for (int x = 0; x < retorno['content'].length; x++) {
        Map<String, dynamic> evento = Map();
        retorno['content'][x].forEach((k, v) => evento[k] = v);
        eventos.add(evento);
      }
      return eventos;
    }
  }

  String transformarData(String dataEvento) {
    DateTime todayDate = DateTime.parse(dataEvento);
    String dataFormatada =
        (formatDate(todayDate, [dd, '/', mm, '/', yyyy, ' ', hh, ':', nn]));
    return dataFormatada;
  }


  @override
  Widget build(BuildContext context) {
    timeDilation = 3.0;
    return Scaffold(
      backgroundColor: corPrimaria,
      appBar: AppBar(
        title: Text('Etec SEBRAE'),
        centerTitle: true,
        backgroundColor: corPrimaria,
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.account_circle),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PerfilPage()),
              );
            },
          ),
        ],
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        textTheme: TextTheme(
            title: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            )
        ),
    ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10.0, left: 10.0),
            child: Text(
              'Eventos na sua ETEC',
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
          ),
          Container(
            padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 10.0),
            height: 150,
            child: FutureBuilder<dynamic>(
              future: carregarLista(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: eventos.length,
                    itemBuilder: (context, index) {
                      return construirContainer(
                          snapshot.data[index]['nome'],
                          transformarData(snapshot.data[index]['dataInicio']),
                          snapshot.data[index]['descricao']);
                    },
                  );
                } else {
                  return Container(
                    padding: EdgeInsets.only(left: 100.0),
                    width: 200.0,
                    height: 200.0,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 5.0,
                    ),
                  );
                }
              },
            ),
          ),
          SizedBox(height: 10.0),
          //------Tentando inserir barra para cada container
          // Stack(
          //   children: <Widget>[
          //     Padding(
          //       padding: EdgeInsets.only(left: 10.0, right: 10.0),
          //       child: Container(
          //         decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(5.0),
          //             color: Colors.green),
          //         height: 10,
          //         width: double.infinity,
          //       ),
          //     ),
          //     AnimatedPositioned(

          //       child: Padding(
          //         padding: EdgeInsets.only(left: 10.0, right: 10.0),
          //         child: Container(
          //           decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(5.0),
          //               color: corPrimaria),
          //           height: 10,
          //           width: 40,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          construirBotao(corSegundoIcon, 'Solicitar Documentos'),
          construirBotao(corTerceiroIcone, 'Enviar Documentos'),
          construirBotao(corQuartoIcone, 'Todos Documentos'),
          construirBotao(corQuintoIcone, 'Meus Documentos'),
        ],
      ),

    );
  }
}
