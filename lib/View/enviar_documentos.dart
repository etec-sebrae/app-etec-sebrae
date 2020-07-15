import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:seetec_projeto/Model/Curso.dart';
import 'package:seetec_projeto/Model/Documento.dart';
import 'dart:convert' show utf8;

import 'package:seetec_projeto/Model/colors.dart';
import 'package:seetec_projeto/Model/config_file.dart';

const urlCurso = "https://api-seetec.herokuapp.com/api/curso";
const urlDocumento = "https://api-seetec.herokuapp.com/api/documentos";

class DocumentoPage extends StatefulWidget {
  @override
  _DocumentoPageState createState() => _DocumentoPageState();
}

class _DocumentoPageState extends State<DocumentoPage> {
  List<Documento> listaDocumentos = [];
  List<Curso> listaCurso = [];
  var _docItemSelected;
  String _docSelection;
  var _curItemSelected;
  String _curSelection;

  List<Documento> parseDocumentos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Documento>((json) => Documento.fromJson(json)).toList();
  }

  Future<List<Documento>> carregaDocumento() async {
    final response = await http.get(urlDocumento);
    String source = Utf8Decoder().convert(response.bodyBytes);
    final responsebody = parseDocumentos(source);
    setState(() {
      listaDocumentos = responsebody;
    });
    return parseDocumentos(response.body);
  }

  List<Curso> parseCursos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Curso>((json) => Curso.fromJson(json)).toList();
  }

  Future<List<Curso>> carregaCurso() async {
    final response = await http.get(urlCurso);
    String source = Utf8Decoder().convert(response.bodyBytes);
    final responsebody = parseCursos(response.body);
    setState(() {
      listaCurso = responsebody;
    });
    return parseCursos(response.body);
  }

  @override
  void initState() {
    super.initState();
    carregaCurso();
    carregaDocumento();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Theme(
      data: ThemeData(hintColor: Colors.white),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Solicitar Documento'),
          backgroundColor: corPrimaria,
          centerTitle: true,
        ),
        resizeToAvoidBottomPadding: false,
        body: Container(
          padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 30.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [corFinalGradiente, corInicioGradiente],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: 160,
                child: Image.asset('assets/logo_app.png'),
              ),
              TextFormField(
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 16.00,
                ),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Nome",
                  labelStyle: TextStyle(color: Colors.white, fontSize: 20.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                    borderRadius: BorderRadius.circular(13.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                    borderRadius: BorderRadius.circular(13.0),
                  ),
                ),
              ),
              TextFormField(
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 16.00),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "RA",
                  labelStyle: TextStyle(color: Colors.white, fontSize: 18.00),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.2),
                    borderRadius: BorderRadius.circular(13.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.2),
                    borderRadius: BorderRadius.circular(13.0),
                  ),
                ),
              ),
              cursoList(),
              documentoList(),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {},
                        child: Text("Solicitar documento  ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold)),
                        color: corBotao,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget cursoList() {
    return Container(
      // color: Colors.black,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Cursos',
          labelStyle: TextStyle(
              color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w500),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: Colors.black, width: 2.0)),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            hint: Text('Selecione seu curso'),
            dropdownColor: corPrimaria,
            iconEnabledColor: Colors.white,
            iconSize: 30.0,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
            isDense: true,
            items: listaCurso.map((Curso map) {
              return DropdownMenuItem<String>(
                value: map.id.toString(),
                child: Text(
                  map.nome,
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              );
            }).toList(),
            onChanged: (String newValueSelected) {
              setState(() {
                this._curItemSelected = newValueSelected;
              });
            },
            value: _curItemSelected,
          ),
        ),
      ),
    );
  }

  Widget documentoList() {
    return Container(
      // color: Colors.black,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Documentos',
          labelStyle: TextStyle(
              color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w500),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: Colors.black, width: 2.0)),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            hint: Text('Selecione seu documento'),
            dropdownColor: corPrimaria,
            iconEnabledColor: Colors.white,
            iconSize: 30.0,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
            isDense: true,
            items: listaDocumentos.map((Documento map) {
              return DropdownMenuItem<String>(
                value: map.id.toString(),
                child: Text(
                  map.nome,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
            }).toList(),
            onChanged: (String newValueSelected) {
              setState(() {
                this._docItemSelected = newValueSelected;
              });
            },
            value: _docItemSelected,
          ),
        ),
      ),
    );
  }
}
