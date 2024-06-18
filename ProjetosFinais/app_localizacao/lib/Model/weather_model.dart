class Weather{
  //atributos
  final String city;
  final String description;
  final double Temp;
  final double tempMin;
  final double tempMax;

  Weather({required this.city, required this.description, required this.Temp, required this.tempMin, required this.tempMax});
  

  //map from
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      city: json['name'],
      description: json['weather'][0]['description'],
      Temp: json['main']['temp'],
      tempMin: json['main']['temp_min'],
      tempMax: json['main']['temp_max'],
    );
  }


}