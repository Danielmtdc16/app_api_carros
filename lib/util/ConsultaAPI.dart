import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:app_api_carros/database/db.dart';

class ConsultaApi {
  static Future<List> request() async {
    const String url = "https://wswork.com.br/cars.json";
    
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = convert.jsonDecode(response.body);
      final List<dynamic> cars = data["cars"];
      return cars;
    } else {
      throw Exception("Erro ao acessar o servidor!");
    }
  }

  static Future<void> sendData() async {
    const String url = 'https://inforpiaui.com.br/teste/carro.php';

    List<Map<String, dynamic>> allPurchases = await DB.instance.getAllPurchases();
    List<Map<String, dynamic>> purchasesToBeShipped = [];

    for (var purchase in allPurchases) {
      if (purchase['foiEnviado'] == 0) {
        purchasesToBeShipped.add(purchase);
      }
    }

    print('Dados que serão enviados para a API: ${purchasesToBeShipped[0]['nomeCarro']}');
    print('Entrei no try');

    if (purchasesToBeShipped.isNotEmpty) {
      try {
        Map<String, String> headers = {"Content-Type":  "application/json; charset=UTF-8"  };

        http.Response response = await http.post(
          Uri.parse(url),
          headers: headers,
          body: convert.jsonEncode(purchasesToBeShipped),
        );
        print('response após o metodo post: ${response.body}');
        if (response.statusCode == 200) {
          print('Dados enviados com sucesso!');

          print('Dados que serão enviados para a API: ${purchasesToBeShipped}');
          DB.instance.updatePurchase(purchasesToBeShipped, 1);
        } else {
          print('Ocorreu um erro ao enviar os dados!');
        }
      } catch (e) {
        print("Erro ao enviar -> $e");
      }
    }
  }

  static Future<void> requestLeads() async {
    const String url = "https://www.wswork.com.br/cars/leads/";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      throw Exception("Erro ao acessar o servidor!");
    }
  }
}