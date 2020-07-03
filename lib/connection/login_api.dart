import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginApi {


  static Future<bool> postLogin (String login, String senha) async {
    var client = http.Client();
    var jsonBody = jsonEncode({
      'email': login,   // do dto,
      'senha': senha    // email e senha
    });
    print("json entrada $jsonBody");

    final encoding = Encoding.getByName('utf-8');
    var header = {'Content-Type': 'application/json', "Accept": "application/json", };
    //var header = {'Content-Type': 'application/json', 'Accept": "application/json', 'token': 'tokenjwt'};
    var url = 'https://api-seetec.herokuapp.com/api/auth';
    var prefs = await SharedPreferences.getInstance();

    try {
      var response = await client.post(url, body: jsonBody,
          encoding: encoding, headers:header);
      if (response.statusCode == 200) {          // testa se o usuario foi encontrado: 200 = ok
        Map mapResponse = json.decode(response.body);  // transf. em json e poe no mapResponse
        prefs.setString("tokenjwt", mapResponse['toque']);
        print (mapResponse['toque']);
        return true;
      }
    }
    finally {         // finally sempre é executado
      client.close();
    }
    return false;     // usuário inválido
  }
}