import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seetec_projeto/View/alerta.dart';
//import 'package:seetec_projeto/View/alerta.dart';
import 'package:seetec_projeto/View/main_page.dart';
//import 'package:seetec_projeto/View/cadastro_page.dart';
import 'package:seetec_projeto/connection/login_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ResetSenha.dart';
//import 'cadastro_page.dart';


class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Color corInicioGradiente = const Color(0xff3747B2);
  Color corFinalGradiente = const Color(0xff5165CB);
  Color corPrimaria = const Color(0xff223249);
  Color corSecundaria = const Color(0xff5263BB);
  Color corContainer = const Color(0xff394BB1);
  Color corContainerDescricaoInicio = const Color(0xff5264CB);
  Color corContainerDescricaoFim = const Color(0xff3A4BB5);
  Color corSegundoIcon = const Color(0xff394BB3);
  Color corTerceiroIcone = const Color(0xff5165C6);
  Color corQuartoIcone = const Color(0xff627BF2);
  Color corQuintoIcone = const Color(0xff6BB5FE);
  TextEditingController login = TextEditingController();
  TextEditingController senha = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  void _alertSnackBar(
    TextEditingController login, TextEditingController senha
    ){
  
    final snackbar = SnackBar(
      content: Text('email digitado= '+ login.text + '\nsenha digitada= '+ senha.text,
          textAlign: TextAlign.left, 
          style: TextStyle(color: Colors.white,
          backgroundColor: corPrimaria,)
        ),
      );
      scaffoldKey.currentState.showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
  var size = MediaQuery.of(context).size;
  var appBar = AppBar (title: Text("Etec SEBRAE v0.1"),
                        centerTitle: true,
                        backgroundColor: corPrimaria,);
  
  return  Scaffold(
    key: scaffoldKey,
    appBar: appBar,
    body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter, end: Alignment.bottomCenter,
                      colors: [corFinalGradiente, corInicioGradiente],
                      tileMode: TileMode.repeated,
                    )
                ),
            child: Column(
              children: <Widget>[ 
              Container(
                padding: EdgeInsets.only(top: 30.0),
                child: Image.asset('assets/logo_app.png'),
              ),
              Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: TextField(
                  autofocus: true,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Usuário:",
                    hintText: "Digite o Email",
                    labelStyle: TextStyle (color: Colors.white, fontSize: 24.0,),
                  ),
                  controller: login,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: TextField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Senha:",
                    labelStyle: TextStyle (color: Colors.white, fontSize: 24.0,),
                    hintText: "Digite a senha"
                  ),
                  controller: senha,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(0),
                child: FlatButton(
                  child: Text ("Esqueci a senha", textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.blue, fontSize: 20.0),),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ResetSenha()));
                  },
                )
              ),
              SizedBox (height: 10.0,),
              Container (
                height: 50.0, width: MediaQuery.of(context).size.width/3,
                child: RaisedButton(
                  onPressed: () async {
                    bool retorno = await LoginApi.postLogin(login.text, senha.text);
                    var prefs = await SharedPreferences.getInstance();
                    final token = prefs.getString('tokenjwt') ?? '';
                    if (retorno){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PaginaInicial()));
                    } else {
                      _alertSnackBar(login, senha);
                    }
                  },
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0),),
                  child:Ink (
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: <Color>[corTerceiroIcone, corQuintoIcone,],),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text("Logar", style: TextStyle(color: Colors.white, fontSize: 25.0)),
                    ),
                  )
                ),
              ),
   /*            SizedBox (height: 10.0,),
              Container(
                height: 50.0, width: MediaQuery.of(context).size.width/3,
                child: RaisedButton(
                  onPressed: () async {
                    await Navigator.push(context, MaterialPageRoute(builder: (context) => PaginaCadastrar()));
                  },   // onPressed
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0),),
                  child:Ink (
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: <Color>[corTerceiroIcone, corQuintoIcone,],),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text("Cadastrar", style: TextStyle(color: Colors.white, fontSize: 25.0)),
                    ),
                  ),
                ),
              ), */
              ],
            ),
          ),
        ],
      ),
    ),
  ); 
  }

}
