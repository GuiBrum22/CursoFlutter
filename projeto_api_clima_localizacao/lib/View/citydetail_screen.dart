import 'package:flutter/material.dart';
import 'package:projeto_api_clima_licalizacao/Controller/weather_controller.dart';

class CityDetailsScreen extends StatefulWidget {
  final String city;
  const CityDetailsScreen({super.key, required this.city});

  @override
  State<CityDetailsScreen> createState() => _CityDetailsScreenState();
}

class _CityDetailsScreenState extends State<CityDetailsScreen> {
  final WeatherController _controller = WeatherController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.city),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child:Center(
          child: FutureBuilder(
            future: _controller.getFromWeatherService(widget.city), 
            builder: (context,snapshot){
              if(_controller.listWeather.isEmpty){
                return CircularProgressIndicator();
              }else{
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_controller.listWeather.last.city),
                        //favorite icon
                        IconButton(
                          icon: const Icon(Icons.favorite_border),
                          onPressed: (){
                            //criar a função para favoritar
                          },
                        )
                      ],
                    ),
                    SizedBox(height: 12,),
                    Text(_controller.listWeather.last.description),
                    SizedBox(height: 12,),
                    Text((_controller.listWeather.last.temp-273).toStringAsFixed(2)),
                    SizedBox(height: 12,),
                  ],
                );
              }
            }),
        )),
      
    );
  }
}