import 'dart:convert';

import 'package:http/http.dart' as http;

class ConversaoProvider {
  final _apiURL = 'https://api.exchangeratesapi.io/latest?';

  Future<dynamic> getConversoes({String moedaBase = ''}) async {
    String requestUrl = this._apiURL + moedaBase;

    try{
      final response = await http.get(requestUrl).timeout(const Duration(seconds: 20));
      final responseJson = json.decode(response.body);
      if(response.statusCode != 200) throw "Erro API";
      return responseJson;
    } catch(ex) {
      rethrow;
    }

  }
}