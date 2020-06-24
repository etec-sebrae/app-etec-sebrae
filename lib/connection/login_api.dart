import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginApi {


  static Future<bool> postLogin (String login, String senha) async {
    var client = http.Client();
    var jsonBody = jsonEncode({
      'nome':'',        // os campos vazios não necessitam ser
      'rg':'',          // passados, estamos passando para ficar
      'cpf':'',         // mais amigavel em relação a montagem
      'email': login,   // do dto,
      'data_nasc': '',  // em tese, basta passar os dados
      'id_curso':'',    // que precisamos trabalhar, ou seja,
      'senha': senha    // email e senha
    });
    print("json entrada $jsonBody");

    final encoding = Encoding.getByName('utf-8');

    var header = {'Content-Type': 'application/json', "Accept": "application/json", };

    var url = 'https://api-seetec.herokuapp.com/aluno/logar';

    try {
      var response = await client.post(url, body: jsonBody,
          encoding: encoding, headers:header);
      if (response.body.isNotEmpty) {          // o body não pode ser vazio, senão aborta
        Map mapResponse = json.decode(response.body);  // transf. em json e poe no mapResponse
        if (mapResponse['email'] == login && mapResponse['senha'] == senha){
          return true;
        }
      }
      var Lista = [];
    }
    finally {         // finally sempre é executado
      client.close();
    }
    return false;     // usuário inválido
  }

}