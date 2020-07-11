import 'dart:convert';
import 'package:seetec_projeto/Model/Login.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginApi {


  static Future<Login> postLogin (String email, String senha) async {
    var client = http.Client();
    var jsonBody = jsonEncode({
      'email': email,   // do dto,
      'senha': senha    // email e senha
    });
    print("json entrada $jsonBody");

    final encoding = Encoding.getByName('utf-8');
    var header = {'Content-Type': 'application/json', "Accept": "application/json", };
    //var header = {'Content-Type': 'application/json', 'Accept": "application/json', 'token': 'tokenjwt'};
    var url = 'https://api-seetec.herokuapp.com/api/auth';
    var prefs = await SharedPreferences.getInstance();
    Login login = new Login();

    try {
      var response = await client.post(url, body: jsonBody,
          encoding: encoding, headers:header);
      if (response.statusCode == 200) {          // testa se o usuario foi encontrado: 200 = ok  
        Map mapResponse = json.decode(response.body);  // transf. em json e poe no mapResponse
        prefs.setString("tokenjwt", mapResponse['toque']);
        print (mapResponse['toque']);
        Login.nome = mapResponse['pessoa']['nome'];
        Login.cpf = mapResponse['pessoa']['cpf'];
        Login.email = mapResponse['pessoa']['email'];
        Login.matricula = mapResponse['pessoa']['matricula'];
        Login.rg = mapResponse['pessoa']['rg'];
        Login.data_nasc = mapResponse['pessoa']['data_nasc'];
        login.login = true;

        return login;
      }
    }
    finally {         // finally sempre é executado
      client.close();
    }
    login.login = false;
    return login;     // usuário inválido
  }
}