import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seetec_projeto/View/main_page.dart';
import 'package:seetec_projeto/connection/login_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:seetec_projeto/Model/colors.dart';
import 'package:seetec_projeto/Model/Login.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController login = TextEditingController();
  TextEditingController senha = TextEditingController();
  bool _isHidden = true;

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
   

  @override
  Widget build(BuildContext context) {
  var size = MediaQuery.of(context).size;
  var appBar = AppBar (title: Text("Etec SEBRAE v1"),
                        centerTitle: true,
                        backgroundColor: corPrimaria,);
  
  return  Scaffold(
    key: scaffoldKey,
    appBar: appBar,
    body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            height: size.height - size.height/9,
            width: size.width,
            decoration: BoxDecoration(
              color: corQuintoIcone,
            ),
            child: Column(
              children: <Widget>[ 
              Container(
                padding: EdgeInsets.all(30.0),
                child: Image.asset('assets/logo_app.png'),
              ),
              Expanded(
                child: Container(
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(color: corSecundaria,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)), 
                 ),
                child: Column (
                  children: <Widget> [
                    Spacer(flex:1),
                    Container(
                      decoration: BoxDecoration(color: Colors.blue[700],
                        borderRadius: new BorderRadius.circular(20.0)),
                      child: _constroiTextField("Usuário"),
                    ),
                    Spacer(flex:1),
                    Container(
                      decoration: 
                        BoxDecoration (color: Colors.blue[600],
                          borderRadius: new BorderRadius.circular(20.0)),
                      child: _constroiTextField("Senha"),
                    ),
                    Spacer(flex:1),
                    Padding(
                      padding: EdgeInsets.all(0),
                      child: FlatButton(
                        child: Text ("Esqueceu a senha?", textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.blue[100], fontSize: 20.0),),
                          onPressed: () => _alertSnackBar('Esqueci'),
                      ),
                    ),
                    Spacer(flex:1),  
                    Container (
                      child: RaisedButton(
                        onPressed: () async {
                          Login retorno = await LoginApi.postLogin(login.text, senha.text);

                          var prefs = await SharedPreferences.getInstance();
                          final token = prefs.getString('tokenjwt') ?? '';
                          if (Login.login){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => PaginaInicial()));
                          } else {
                            _alertSnackBar('Invalido');
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
                            height: 50.0, width: size.width/3,
                            alignment: Alignment.center,
                            child: Text("Entrar", style: TextStyle(color: Colors.white, fontSize: 25.0)),
                          ),
                        )
                      ),
                    ),
                    Spacer(flex:2),
                  ], 
                ),
              ),
              ),      
              ],
            ),
          ),
        ],
      ),
    ),
  ); 
  }
  
  void _alertSnackBar(String msg) {
  
    var mensagem = new Map();
    mensagem["Invalido"] = "Email ou senha invalida!!"; 
    mensagem["Esqueci"] = "Senha enviada para o email cadastrado";

    final snackbar = SnackBar(
      content: Text(mensagem[msg],
          textAlign: TextAlign.left, 
          style: TextStyle(color: Colors.white,
          backgroundColor: corPrimaria,)
        ),
      );
      scaffoldKey.currentState.showSnackBar(snackbar);
  }

  Widget _constroiTextField(String labelText){
    return TextField(
      keyboardType: TextInputType.text,
      obscureText: labelText == "Senha" ? _isHidden: false,
      decoration: 
        InputDecoration(
        hintText: labelText == "Usuário" ? "Digite o Email": "Digite a Senha",
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        prefixIcon: labelText == "Usuário" ? Icon(Icons.mail):Icon(Icons.lock),
        suffixIcon: labelText == "Senha" ? IconButton(
          onPressed: () {
            setState(() => _isHidden = !_isHidden);
          }, 
          icon: Icon(Icons.visibility_off),
        ):null,
        labelText: labelText == "Usuário" ? "Usuário": "Senha:",
        labelStyle: TextStyle (color: Colors.white, fontSize: 24.0,),
      ),
      controller: labelText == "Usuário" ? login: senha,
    );
  }

}
