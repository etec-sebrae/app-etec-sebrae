import 'dart:convert';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart';
import 'package:seetec_projeto/Model/Widgets/botao.dart';
import 'package:seetec_projeto/Model/Widgets/construir_eventos.dart';
import 'package:seetec_projeto/View/cadastro_page.dart';
import 'package:seetec_projeto/Model/colors.dart';
import 'package:seetec_projeto/View/enviar_documentos.dart';
import 'package:seetec_projeto/View/solicitar_documento.dart';


const urlEvento = "https://api-seetec.herokuapp.com/api/evento";

class PaginaInicial extends StatefulWidget {
  @override
  _PaginaInicialState createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  
  List eventos = [];

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
    timeDilation = 2.0;
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
            child: FutureBuilder<dynamic>(
              future: carregarLista(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: eventos.length,
                    itemBuilder: (context, index) {
                      return construirEventos(
                          snapshot.data[index]['nome'],
                          transformarData(snapshot.data[index]['dataInicio']),
                          snapshot.data[index]['descricao'],context);
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

          construirBotao(corSegundoIcon, 'Solicitar Documentos',DocumentoPage(),context),
          construirBotao(corTerceiroIcone, 'Enviar Documentos',EnviarDocumentos(),context),
          construirBotao(corQuartoIcone, 'Todos Documentos',PaginaCadastrar(),context),
          construirBotao(corQuintoIcone, 'Meus Documentos',PaginaCadastrar(),context),
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
