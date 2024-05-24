import '../Model/city_db_model.dart';
import '../Service/city_db_service.dart';

class CityDbController {
  //atributos
  List<CityDb> _cities=[];
  final CityDbService _service = CityDbService();
  //get
  List<CityDb> getCities() => _cities;
  
  //métodos
  Future<List<CityDb>> getAllCities() async {
    try {
      List<Map<String,dynamic>> maps = await _service.getAllCities();
      for(Map<String,dynamic> map in maps){
        _cities.add(CityDb.fromMap(map));
      }
      //_cities = maps.map<CityDb>((e) => CityDb.fromMap(e)).toList();
      
      return _cities;
    } catch (e) {
      print(e);
      return _cities;
    }
  }
  //create
  Future<void> create(CityDb db) async {
    try {
      await _service.insertCity(db);
      print("inserted");
    } catch (e) {
      print(e);
    }
  }
}