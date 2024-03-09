import 'dart:convert';
import 'package:http/http.dart' as http;

class ConsultaApi {
  static Future<List> request() async {
    const String url = "https://wswork.com.br/cars.json";
    
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> cars = data["cars"];
      return cars;
    } else {
      throw Exception("Erro ao acessar o servidor!");
    }
  }
}