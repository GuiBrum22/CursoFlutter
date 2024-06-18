import '../Model/weather_model.dart';
import '../Service/weather_service.dart';

class WeatherController {
  List<Weather> listWeather = [];
  WeatherService _service = new WeatherService();

  //métodos
  Future<List<Weather>> getFromWeatherService(String city) async{
    Weather weather = Weather.fromJson(await _service.getWeather(city));
    listWeather.add(weather);
    return listWeather;
  }

  Future<List<Weather>> getFromWeatherServiceLocation(double lat, double lon) async{
    Weather weather = Weather.fromJson(await _service.getWeatherByLocation(lat,lon));
    listWeather.add(weather);
    return listWeather;
  }
}