import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  Widget construirContainer(String titulo, String descricao) {
    return Container(
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
                                'ETEC-SEBRAE estará fechada a partir do dia 24/02 até o dia 26/02 por conta dos feriados de carnaval, voltaremos com aulas normalmente dia 27/02',
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
                                child: Text('Voltar'),
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
                  descricao,
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
          padding: EdgeInsets.all(10.0),
          child: FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0)),
            color: cor,
            child: Stack(
              children: <Widget>[
                SizedBox(
                  height: 80,
                  width: 350,
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 35, 0.0, 0.0),
                    child: Text(
                      texto,
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(323.0, 25, 0.0, 0.0),
                    child: SvgPicture.asset(
                      'assets/papel.svg',
                      color: Colors.white,
                      width: 30,
                      height: 30,
                    ))
              ],
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
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
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                construirContainer('Carnaval', '24/02 até 26/02'),
                SizedBox(width: 8.0),
                construirContainer('Palestra', '30/02 as 14:00'),
                SizedBox(width: 8.0),
                construirContainer('Feriado Nacional', 'Tiradentes')
              ],
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Cabeçalho Drawer'),
              decoration: BoxDecoration(
                color: corSecundaria,
              ),
            ),
            ListTile(
              title: Text('Item Teste'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item Teste'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
