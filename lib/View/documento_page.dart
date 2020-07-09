import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert' show utf8;

const urlCurso = "https://api-seetec.herokuapp.com/api/curso";
const urlDocumento = "https://api-seetec.herokuapp.com/api/documentos";

class DocumentoPage extends StatefulWidget {
  @override
  _DocumentoPageState createState() => _DocumentoPageState();
}

class _DocumentoPageState extends  State<DocumentoPage>{
  Curso _cursoSelecionado;
  String _cursoSelec;
  Documento _documentoSelecionado;

  Color corInicioGradiente = const Color(0xff3747B2);
  Color corFinalGradiente = const Color(0xff5165CB);

  Future<List<Curso>> _cursos() async {
    var response = await get(urlCurso);
    String source = Utf8Decoder().convert(response.bodyBytes);
    if (response.statusCode == 200) {
      final items = json.decode(source).cast<Map<String, dynamic>>();
      List<Curso> listaDeCursos = items.map<Curso>((json) {
        return Curso.fromJson(json);
      }).toList();

      return listaDeCursos;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  Future<List<Documento>> _documentos() async {
    var response = await get(urlDocumento);
    String source = Utf8Decoder().convert(response.bodyBytes);
    if (response.statusCode == 200) {
      final items = json.decode(source).cast<Map<String, dynamic>>();
      List<Documento> listaDeDocumento = items.map<Documento>((json) {
        return Documento.fromJson(json);
      }).toList();

      return listaDeDocumento;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  @override
  void initState() {
    _documentoSelecionado = null;
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              width: 250.00,
              child: Image.asset('assets/etec_sebrae.png'),
            ),
            TextFormField(
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 16.00),
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
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 16.00),
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
            FutureBuilder<List<Curso>>(
                  future: _cursos(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Curso>> snapshot) {
                    if (!snapshot.hasData) return CircularProgressIndicator();
                    return DropdownButtonFormField<Curso>(
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 16.00),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        //hintText: "Selecione seu documento...",
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
                      hint: Text('Selecione o curso'),
                      //value: _cursoSelecionado
                      items: snapshot.data
                          .map((cur) => DropdownMenuItem(
                          child: Text(cur.nome),
                          value: cur,
                          ))
                         .toList(),
                      onChanged: (value) {
                        setState(() {
                          _cursoSelecionado = value;
                        });
                      },
                    );
                  }),
            FutureBuilder<List<Documento>>(
                future: _documentos(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Documento>> snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  return DropdownButtonFormField<Documento>(
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 16.00),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      //hintText: "Selecione seu documento...",
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
                    hint: Text('Selecione o documento'),
                    //value: _documentoSelecionado,
                    items: snapshot.data
                        .map((doc) => DropdownMenuItem(
                        value: doc,
                        child: Text(doc.nome),
                      ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _documentoSelecionado = value;
                      });
                    },

                  );
                }),
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Container(
                height: 40.0,
                width: 400.00,
                child: RaisedButton(
                  onPressed: () {
                  },
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
}