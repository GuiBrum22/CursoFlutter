import 'package:flutter/material.dart';
import 'package:projeto_api_clima_licalizacao/Controller/weather_controller.dart';

import 'citydetail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _cityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final WeatherController _controller = WeatherController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Search City"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: Form(
                  key: _formKey,
                  child: Column(children: [
                    TextFormField(
                      controller: _cityController,
                      decoration: const InputDecoration(
                        labelText: 'Enter City',
                      ),
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Please enter city';
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _findCity(_cityController.text);
                        }
                      },
                      child: const Text('Search'),
                    )
                  ]))),
        ));
  }

  Future<void> _findCity(String city) async {
    if (await _controller.findCity(city)) {
      //Mensagem snackbar
      ScaffoldMessenger.of(context)
         .showSnackBar(const SnackBar(
          content: Text('City found'),
          duration:Duration(seconds: 1)));
      //Chamando a tela CityDetailsScreen
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CityDetailsScreen(city: city)));
    }else{
      _cityController.clear();
      //Mensagem snackbar
      ScaffoldMessenger.of(context)
         .showSnackBar(const SnackBar(
          content: Text('City not found'),
          duration:Duration(seconds: 2)));
          setState(() {
          });
    }
  }
}
