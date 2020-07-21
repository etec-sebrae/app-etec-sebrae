import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seetec_projeto/Model/Curso.dart';
import 'package:seetec_projeto/Model/Login.dart';
import 'package:seetec_projeto/Model/colors.dart';
import 'package:seetec_projeto/Model/config_file.dart';
import 'package:http/http.dart' as http;
import 'package:seetec_projeto/connection/enviar_foto_documento_api.dart';

const urlCurso = "https://api-seetec.herokuapp.com/api/curso";
List<Curso> listaCurso = [];

class EnviarDocumentos extends StatefulWidget {
  @override
  _EnviarDocumentosState createState() => _EnviarDocumentosState();
}

class _EnviarDocumentosState extends State<EnviarDocumentos> {
  TextEditingController _controllerDescricao = TextEditingController();
  File minhaImagemAtual;
  String nomeDoArquivo = '';
  String _arquivo;
  String _caminho;
  Map<String, String> _caminhos;
  String _extensao;
  bool _carregandoCaminho = false;
  FileType _escolhendoTipo = FileType.any;
  TextEditingController _controller = new TextEditingController();
  File _minhaImagem;
  static File meuDocumentoBytes;
  var _valorSelecionado;
  bool pressionado;

  Gradient gradiente() {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [corFinalGradiente, corInicioGradiente],
      tileMode: TileMode.repeated,
    );
  }

  Widget criarCampo(
      String titulo, TextEditingController controller, String hint,
      [TextInputType keyboard,
      String valorInicial,
      int maximoLinhas,
      int minimoLinhas,
      GlobalKey<FormState> _minhaChave]) {
    return TextFormField(
      key: _minhaChave,
      initialValue: valorInicial,
      maxLines: maximoLinhas,
      controller: controller,
      keyboardType: keyboard,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.black, width: 1.0)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.circular(13.0),
        ),
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
    final responsebody = parseCursos(source);
    setState(() {
      listaCurso = responsebody;
    });
    return parseCursos(response.body);
  }

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
      _minhaImagem = await FilePicker.getFile(
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
      minhaImagemAtual = _minhaImagem;
      meuDocumentoBytes = _minhaImagem;
      retornoImagem();
      return _minhaImagem;
    });
  }

  String retornoImagem() {
    Uint8List bytes = meuDocumentoBytes.readAsBytesSync();
    String imagem64 = base64Encode(bytes);
    return imagem64;
  }

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
        body: SingleChildScrollView(
          child: Container(
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
                criarCampo(
                  'Nome',
                  null,
                  'Insira seu nome',
                  TextInputType.emailAddress,
                  Login.nome,
                  null,
                  null,
                ),
                criarCampo('RA', null, 'Insira seu RA', TextInputType.number,
                    Login.id.toString(), null, null),
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
                          hint: _valorSelecionado == null
                              ? Text('Escolha um curso')
                              : Text(_valorSelecionado),
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
                criarCampo('Descricao Documento', _controllerDescricao, null,
                    TextInputType.multiline, null, 2, null),
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
                          ? 'Arquivo ' + 'selecionado'
                          : 'Nenhum arquivo selecionado',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.blockSizeVertical * 2),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 10.0, right: 10.0, bottom: 5.0),
                        height: 50.0,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          color: corBotao,
                          textColor: Colors.white,
                          onPressed: () async {
                            bool retorno = await EnviarImagem.enviarImagemDoc(
                                Login.nome,
                                Login.id,
                                retornoImagem(),
                                _controllerDescricao.text);
                            if (retorno) {
                              mensagem(context, 'Enviado com sucesso');
                              _controllerDescricao.clear();
                              _valorSelecionado = null;
                            } else {
                              mensagem(context, 'Erro ao enviar');
                            }
                          },
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
      ),
    );
  }
}

void mensagem(BuildContext context, String msg) {
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  AlertDialog alerta = AlertDialog(
    title: Text("Atenção"),
    content: Text(msg),
    actions: [
      okButton,
    ],
  );
  // exibe o dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alerta;
    },
  );
}
