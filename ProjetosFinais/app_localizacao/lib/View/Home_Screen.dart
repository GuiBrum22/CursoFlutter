import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../Controller/weather_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //
  WeatherController _controller = new WeatherController();

  @override
  void initState() {
    super.initState();
    _getWeather();
  }
  Future<void> _getWeather() async {
    try {
      //geoLocator
      Position _locator = await Geolocator.getCurrentPosition();
      _controller.getFromWeatherServiceLocation(
        _locator.latitude, _locator.longitude
        );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Previsão do Tempo'),
        //criar icone de busca no appbar
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: (){}, 
                  child: const Text("Search")),
                ElevatedButton(
                  onPressed: (){}, 
                  child: const Text("Favorite")),
              ],
            ),
            SizedBox(height: 12),
            _controller.listWeather.isEmpty 
            ?
            Column(
              children: [
                Text("Carregando..."),
                IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  _getWeather();
                   },
                )
              ],
            )
            :
            Column(
              children:[
                Text(_controller.listWeather[0].city),
                Text(_controller.listWeather[0].description),
                Text(_controller.listWeather[0].Temp as String),
                Text(_controller.listWeather[0].tempMin as String),
                Text(_controller.listWeather[0].tempMax as String),
                IconButton(
                icon:  const Icon(Icons.refresh),
                onPressed: () {
                  _getWeather();
                   },
                )
              ]
            )
            


          ],

        )
      ),
    );
  }
}