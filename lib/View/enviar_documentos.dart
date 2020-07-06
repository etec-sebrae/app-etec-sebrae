import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seetec_projeto/Model/config_file.dart';
import 'package:seetec_projeto/Model/colors.dart';

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

  Widget criarBotao(String titulo, TextEditingController controller, String hint,[TextInputType keyboard]) {
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

  var _cursos = [
    "Informática",
    "Redes",
    "Administração",
    "Mecatrônica",
    "Enfergagem",
    "Análise e Desenvolvimento de Sistemas",
    "Design Interiores",
    "Especialização mobile"
  ];

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
    Theme(
      data: ThemeData(hintColor: Colors.white,primaryColor: Colors.black),
      child: Container(),
    );
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Enviar Documentos'),
        centerTitle: true,
        backgroundColor: corPrimaria,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: gradiente(),
        ),
        child: SingleChildScrollView(
            child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 10.0),
                child: Image.asset(
                  'assets/logo_app.png',
                  height: 140.0,
                ),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical*1),
              Padding(
                padding: EdgeInsets.only(
                    left: 40.0, right: 40.0, bottom: 8.0),
                child: criarBotao('Nome', _controllerNome, 'Insira seu nome'),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical*1),
              Padding(
                padding: EdgeInsets.only(
                    left: 40.0, right: 40.0, top: 8.0, bottom: 8.0),
                child: criarBotao('RA', _controllerRA, 'Insira seu RA',TextInputType.number),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical*1),
              Padding(
                padding: EdgeInsets.only(
                    left: 40.0, right: 40.0, top: 8.0, bottom: 12.0),
                child: FormField<String>(
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
                          items: _cursos.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 16.0),
                child: Container(
                  width: 400,
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
                      RaisedButton(
                        padding: EdgeInsets.only(right: 10.0, bottom: 12.0,top: 12.0),
                        textColor: Colors.white,
                        color: corBotao,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        onPressed: _abrirDocumentos,
                        child: Text('   Clique para selecionar seu documento'),
                      ),
                    ],
                  ),
                ), 
              ),
              Text(_carregandoCaminho ? 'Arquivo ' + '"'+ nomeDoArquivo + '"' + ' selecionado' : 'Nenhum arquivo selecionado',style: TextStyle(
                color: Colors.white,
                fontSize: 18.0
              ),),
              SizedBox(height: SizeConfig.blockSizeVertical*4),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 8.0,right: 8.0,top: 28.0),
                    child: SizedBox(
                      width: SizeConfig.blockSizeHorizontal*96,
                      height: SizeConfig.blockSizeVertical*5,
                      child: RaisedButton(
                        color: corBotao,
                        textColor: Colors.white,
                        onPressed: (){},
                        child: Text('Enviar Documento',
                        style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
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
