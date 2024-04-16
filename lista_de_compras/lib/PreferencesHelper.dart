import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static const String currencyKey = 'selected_currency';

  // Método para obter a moeda selecionada armazenada nas preferências
  static Future<String?> getSelectedCurrency() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(currencyKey);
  }

  // Método para definir a moeda selecionada nas preferências
  static Future<void> setSelectedCurrency(String currency) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(currencyKey, currency);
  }

  // Outros métodos relacionados às preferências podem ser adicionados conforme necessário
}
