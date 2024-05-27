import 'package:http/http.dart' as http;
import 'dart:convert';

// Classe responsável por converter moedas
class CurrencyConverter {
  final String apiKey; // Chave da API de conversão de moedas

  // Construtor da classe CurrencyConverter
  CurrencyConverter({required this.apiKey});

  // Método para converter um valor para dólares americanos (USD)
  Future<double> convertToUSD(double amount, String currencyCode) async {
    // Faz uma requisição GET para a API de taxas de câmbio
    final response = await http.get(Uri.parse('https://api.exchangerate-api.com/v4/latest/USD'));

    // Verifica se a requisição foi bem-sucedida (status code 200)
    if (response.statusCode == 200) {
      // Decodifica o corpo da resposta JSON
      final data = json.decode(response.body);
      
      // Obtém as taxas de câmbio a partir dos dados
      final rates = data['rates'];
      
      // Obtém a taxa de câmbio da moeda especificada
      final exchangeRate = rates[currencyCode];
      
      // Verifica se a taxa de câmbio foi encontrada
      if (exchangeRate != null) {
        // Calcula e retorna o valor convertido para dólares americanos (USD)
        return amount / exchangeRate;
      } else {
        // Lança uma exceção se o código da moeda não foi encontrado
        throw Exception('Currency code not found');
      }
    } else {
      // Lança uma exceção se a requisição falhar
      throw Exception('Failed to load exchange rates');
    }
  }
}