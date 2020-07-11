import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:seetec_projeto/Model/colors.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Enviar Documentos'),
        centerTitle: true,
        backgroundColor: corPrimaria,
      ),
      resizeToAvoidBottomPadding: false,
      body: Container(
        padding: EdgeInsets.all(30.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [corFinalGradiente, corInicioGradiente],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: 150.0,
              child: Image.asset('assets/logo_app.png'),
            ),
            TextFormField(
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 16.00),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Nome",
                labelStyle: TextStyle(color: Colors.white, fontSize: 18.00),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(13.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(13.0),
                ),
              ),
            ),
            TextFormField(
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 16.00),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "RA",
                labelStyle: TextStyle(color: Colors.white, fontSize: 18.00),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(13.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(13.0),
                ),
              ),
            ),
            cursoList(),
            documentoList(),
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Container(
                height: 40.0,
                width: 400.00,
                child: RaisedButton(
                  onPressed: () {},
                  child: Text("Solicitar documento  ",
                      style: TextStyle(color: Colors.white, fontSize: 18.0)),
                  color: Colors.indigoAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                    side: BorderSide(color: Colors.indigoAccent),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cursoList() {
    return Container(
      // color: Colors.black,
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          hintText: 'Selecione o curso',
          contentPadding: EdgeInsets.all(8),
          hintStyle: TextStyle(color: Colors.white, fontSize: 18.00),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(13.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(13.0),
          ),
        ),
        items: listaCurso.map((Curso map) {
          return DropdownMenuItem<String>(
            value: map.id.toString(),
            child: Text(
              map.nome,
              style: TextStyle(
                color: Colors.black,
              ),
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
    );
  }

  Widget documentoList() {
    return Container(
      // color: Colors.black,
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          hintText: 'Selecione o documento',
          contentPadding: EdgeInsets.all(8),
          hintStyle: TextStyle(color: Colors.white, fontSize: 18.00),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(13.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(13.0),
          ),
        ),
        items: listaDocumentos.map((Documento map) {
          return DropdownMenuItem<String>(
            value: map.id.toString(),
            child: Text(
              map.nome,
              style: TextStyle(
                color: Colors.black,
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
    );
  }
}

class Curso {
  int id;
  String nome;
  String descricao;

  Curso({this.id, this.nome, this.descricao});

  factory Curso.fromJson(Map<String, dynamic> json) {
    return Curso(
      id: json['id'],
      nome: json['nome'],
      descricao: json['descricao'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "descricao": descricao,
      };
}

class Documento {
  int id;
  String nome;
  String descricao;

  Documento({this.id, this.nome, this.descricao});

  factory Documento.fromJson(Map<String, dynamic> json) {
    return Documento(
      id: json['id'],
      nome: json['nome'],
      descricao: json['descricao'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "descricao": descricao,
      };
}
