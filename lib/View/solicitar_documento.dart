import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seetec_projeto/Model/Curso.dart';
import 'package:seetec_projeto/Model/colors.dart';
import 'package:seetec_projeto/Model/config_file.dart';
import 'package:http/http.dart' as http;

const urlCurso = "https://api-seetec.herokuapp.com/api/curso";
List<Curso> listaCurso = [];

class EnviarDocumentos extends StatefulWidget {
  @override
  _EnviarDocumentosState createState() => _EnviarDocumentosState();
}

class _EnviarDocumentosState extends State<EnviarDocumentos> {
  TextEditingController _controllerRA = TextEditingController();
  TextEditingController _controllerNome = TextEditingController();

  final formKey = new GlobalKey<FormState>();

  Gradient gradiente() {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [corFinalGradiente, corInicioGradiente],
      tileMode: TileMode.repeated,
    );
  }

  Widget criarBotao(
      String titulo, TextEditingController controller, String hint,
      [TextInputType keyboard]) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboard,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.black, width: 1.0)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0)),
        labelText: titulo,
        labelStyle: TextStyle(color: Colors.white),
        hintText: hint,
      ),
      style: TextStyle(
          color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w300),
    );
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

  String _arquivo;
  String _caminho;
  Map<String, String> _caminhos;
  String _extensao;
  bool _carregandoCaminho = false;
  FileType _escolhendoTipo = FileType.any;
  TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => _extensao = _controller.text);
    carregaCurso();
  }

  void _abrirDocumentos() async {
    setState(() => _carregandoCaminho = true);
    try {
      _caminhos = null;
      _caminho = await FilePicker.getFilePath(
          type: _escolhendoTipo,
          allowedExtensions: (_extensao?.isNotEmpty ?? false)
              ? _extensao?.replaceAll(' ', '')?.split(',')
              : null);
    } on PlatformException catch (e) {
      print("Operação não suportada" + e.toString());
    }
    if (!mounted) return;
    setState(() {
      _carregandoCaminho = true;
      _arquivo = _caminho != null
          ? _caminho.split('/').last
          : _caminhos != null ? _caminhos.keys.toString() : '...';
      print(_arquivo);
      nomeDoArquivo = _arquivo;
      return nomeDoArquivo = _arquivo;
    });
  }

  String nomeDoArquivo = '';

  var _valorSelecionado;
  bool pressionado;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Theme(
      data: ThemeData(hintColor: Colors.white, primaryColor: Colors.black),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Enviar Documentos'),
          centerTitle: true,
          backgroundColor: corPrimaria,
        ),
        resizeToAvoidBottomPadding: false,
        body: Container(
          height: SizeConfig.screenHeight,
          padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 30.0),
          decoration: BoxDecoration(
            gradient: gradiente(),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: Image.asset(
                  'assets/logo_app.png',
                  height: 160.0,
                ),
              ),
              
              criarBotao('Nome', _controllerNome, 'Insira seu nome'),
              criarBotao('RA', _controllerRA, 'Insira seu RA', TextInputType.number),

              FormField<String>(
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Cursos',
                      labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0)),
                    ),
                    isEmpty: _valorSelecionado == '',
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Text('Selecione seu curso'),
                        dropdownColor: corPrimaria,
                        iconEnabledColor: Colors.white,
                        iconSize: 30.0,
                        style: TextStyle(color: Colors.white),
                        value: _valorSelecionado,
                        isDense: true,
                        onChanged: (String newValue) {
                          setState(() {
                            _valorSelecionado = newValue;
                            state.didChange(newValue);
                          });
                        },
                        items: listaCurso.map((Curso map) {
                          return DropdownMenuItem<String>(
                            value: map.id.toString(),
                            child: Text(
                              map.nome,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 16.0),
                child: Container(
                  width: 300,
                  height: 100,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 50.0, right: 15.0),
                        child: SvgPicture.asset(
                          'assets/upload_botao.svg',
                          color: Colors.black,
                          width: 30,
                          height: 30,
                        ),
                      ),
                      Expanded(
                        child: RaisedButton(
                          padding: EdgeInsets.only(
                              right: 10.0, bottom: 12.0, top: 12.0),
                          textColor: Colors.white,
                          color: corBotao,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          onPressed: _abrirDocumentos,
                          child: Text(
                            '   Clique para selecionar seu  \n documento',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Center(
                  child: Text(
                    _carregandoCaminho
                        ? 'Arquivo ' +
                            '"' +
                            nomeDoArquivo +
                            '"' +
                            ' selecionado'
                        : 'Nenhum arquivo selecionado',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 4),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 10.0, right: 10.0, bottom: 10.0),
                      height: 50.0,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        color: corBotao,
                        textColor: Colors.white,
                        onPressed: () {},
                        child: Text(
                          'Enviar Documento',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
