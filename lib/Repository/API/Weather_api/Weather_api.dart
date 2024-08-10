import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model_Class/weather_model.dart';
import 'api_client.dart';

class weatherApi {
  ApiClient apiClient = ApiClient();


  Future<Weather_Model> getWeather() async {
    final preferences = await SharedPreferences.getInstance();
    final location = preferences.getString('location');
    print('Location: $location');
    String trendingpath =  'https://open-weather13.p.rapidapi.com/city/$location/EN ';
    var body = {};

    Response response = await apiClient.invokeAPI(trendingpath, 'GET', body);
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    return Weather_Model.fromJson(jsonResponse);
  }
}