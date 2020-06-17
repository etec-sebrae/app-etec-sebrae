import 'package:flutter/material.dart';
import 'package:seetec_projeto/View/main_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Color corInicioGradiente = const Color(0xff3747B2);
  Color corFinalGradiente = const Color(0xff5165CB);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [corFinalGradiente, corInicioGradiente],
            tileMode: TileMode.repeated,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 30.0),
              child: Image.asset('assets/etec_sebrae.png'),
            ),
            SizedBox(
              height: 100.0,
            ),
            Container(
              width: 300,
              height: 45,
              child: RaisedButton(
                onPressed: (){
                  Navigator.push(
                    context, 
                  MaterialPageRoute(builder: (context) => PaginaInicial()),
                  );
                },
                color: Colors.white,
                textColor: Colors.grey,
                child: Text('Entrar'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.grey)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
