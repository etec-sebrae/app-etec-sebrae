import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:seetec_projeto/Model/Status.dart';
import 'package:seetec_projeto/Model/colors.dart';
import 'package:http/http.dart' as http;

class StatusPage extends StatefulWidget {
  @override
  _StatusPage createState() => _StatusPage();
}

class _StatusPage extends State<StatusPage> {
  @override
  void initState() {
    super.initState();
    setState(() {
      carregaDados();
    });
  }

  List<Status> _listStatus = [];

  Future<List<Status>> _getDados() async {
    try {
      List<Status> _listDados = List();
      final response =
          await http.get('https://api-seetec.herokuapp.com/api/solicitacoes');
      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body)['content'];
        decodeJson.forEach((item) => _listDados.add(Status.fromJson(item)));
        return _listDados;
      } else {
        print("Erro ao carregar lista");
        return null;
      }
    } catch (e) {
      print("Erro ao carregar lista");
      return null;
    }
  }

  Future<dynamic> carregaDados() {
    _getDados().then((map) {
      setState(() {
        _listStatus = map;
      });
    });
  }

  String transformarData(String dataEvento) {
    DateTime todayDate = DateTime.parse(dataEvento);
    String dataFormatada =
        (formatDate(todayDate, [dd, '/', mm, '/', yyyy, ' ', hh, ':', nn]));
    return dataFormatada;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corPrimaria,
      appBar: AppBar(
          title: Text('Meus Documentos'),
          centerTitle: true,
          backgroundColor: corPrimaria,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () => Navigator.pop(context, false),
          )),
      body: SafeArea(
        child: ListView.builder(
          itemCount: _listStatus.length,
          itemBuilder: (context, index) {
            //   DateTime now = _api[index].dataAbertura as DateTime;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.only(left: 10),
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.person,
                          size: 60.0,
                        ),
                        title: Text("Data Pedido: " +
                            transformarData(_listStatus[index].dataAbertura.toString())),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text("Status: "),
                                Text(_listStatus[index].status == 1
                                    ? "Pedido encaminhado"
                                    : "Pronto "),
                              ],
                            ),
                            Text("Documento : " +
                                _listStatus[index].documento.descricao),
                          ],
                        ),
                        isThreeLine: true,
                      ),
                    ),
                    //    Text(DateFormat('dd/MM/yyyy').format(now)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
