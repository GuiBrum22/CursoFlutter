import 'package:http/http.dart' as http;
import 'dart:convert';

class CurrencyConverter {
  final String apiKey;

  CurrencyConverter({required this.apiKey});

  Future<double> convertToUSD(double amount, String currencyCode) async {
    final response = await http.get(Uri.parse('https://api.exchangerate-api.com/v4/latest/USD'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final rates = data['rates'];
      final exchangeRate = rates[currencyCode];
      if (exchangeRate != null) {
        return amount / exchangeRate;
      } else {
        throw Exception('Currency code not found');
      }
    } else {
      throw Exception('Failed to load exchange rates');
    }
  }
}
