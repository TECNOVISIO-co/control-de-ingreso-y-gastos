import 'package:http/http.dart' as http;
import 'dart:convert';

class CurrencyConverter {
  static const String API_KEY = 'YOUR_API_KEY'; // Reemplaza con tu clave de API
  static const String BASE_URL = 'https://api.exchangerate-api.com/v4/latest/';

  static Future<double> convert(String from, String to, double amount) async {
    final response = await http.get(Uri.parse('$BASE_URL$from'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final rate = data['rates'][to];
      return amount * rate;
    } else {
      throw Exception('Failed to load exchange rates');
    }
  }
}