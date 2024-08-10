import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

import '../Authentication/Login/Login.dart';
import '../BottomNavBar.dart';
import '../consts.dart';

class Weatherreportscreen extends StatefulWidget {
  const Weatherreportscreen({super.key});

  @override
  State<Weatherreportscreen> createState() => _WeatherreportscreenState();
}

class _WeatherreportscreenState extends State<Weatherreportscreen> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);
  final TextEditingController _cityController = TextEditingController();
  Weather? _weather;
  List<Weather> _otherCitiesWeather = [];
  final List<String> _otherCities = ['Malappuram', 'Kannur', 'Kozhikode', 'idukki', 'Palakkad'];

  @override
  void initState() {
    super.initState();
    _wf.currentWeatherByCityName("Kochi").then((w) {
      setState(() {
        _weather = w;
_fetchOtherCitiesWeather();
      });
    }

    );
  }
   Future<void> _fetchCurrentLocationWeather() async {
    Position position = await _determinePosition();
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    String cityName = placemarks.first.locality ?? '';

    if (cityName.isNotEmpty) {
      final weather = await _wf.currentWeatherByCityName(cityName);
      setState(() {
        _weather = weather;
      });
    }
  }

  Future<void> _fetchOtherCitiesWeather() async {
    for (String city in _otherCities) {
      final weather = await _wf.currentWeatherByCityName(city);
      setState(() {
        _otherCitiesWeather.add(weather);
      });
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    return await Geolocator.getCurrentPosition();
  }

  void _fetchWeather(String cityName) async {
    final weather = await _wf.currentWeatherByCityName(cityName);
    setState(() {
      _weather = weather;
    });
    _fetchWeather('usa');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black12,
      body: SafeArea(child: _buildUI()),
      bottomNavigationBar: FooterWidget(userRole: comment), // Replace 'comment' with your actual user role.
    );
  }

  Widget _buildUI() {
    if (_weather == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWeatherHeader(),
            const SizedBox(height: 16),
            _buildWeatherIconAndDescription(),
            const SizedBox(height: 16),
            _buildCurrentTemperature(),
            const SizedBox(height: 16),
            _buildAdditionalWeatherInfo(),
            const SizedBox(height: 16),
            _buildNextWeekForecast(),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              _weather?.areaName ?? "",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),
            ),IconButton(onPressed: _showCityInputModal, icon: Icon(Icons.change_circle))
          ],
        ),

        const SizedBox(height: 8),
        Text(
          DateFormat("h:mm a, EEEE, d MMM y").format(_weather!.date!),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400,color: Colors.white),
        ),
      ],
    );
  }
  void _showCityInputModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(
                  labelText: 'Enter City Name',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      if (_cityController.text.isNotEmpty) {
                        _fetchWeather(_cityController.text);
                        Navigator.pop(context);  // Close the modal after selecting a city
                      }
                    },
                  ),
                ),
                onFieldSubmitted: (value) {
                  if (value.isNotEmpty) {
                    _fetchWeather(value);
                    Navigator.pop(context);  // Close the modal after submitting
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWeatherIconAndDescription() {
    return Row(
      children: [
        Image.network(
          "http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png",
          height: 100,
          width: 100,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            _weather?.weatherDescription ?? "",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500,color: Colors.white),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentTemperature() {
    return Center(
      child: Text(
        "${_weather?.temperature?.celsius?.toStringAsFixed(0)}° C",
        style: const TextStyle(fontSize: 80, fontWeight: FontWeight.w500,color: Colors.white),
      ),
    );
  }

  Widget _buildAdditionalWeatherInfo() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.deepPurpleAccent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildWeatherInfoItem("Max Temp", "${_weather?.tempMax?.celsius?.toStringAsFixed(0)}° C"),
              _buildWeatherInfoItem("Min Temp", "${_weather?.tempMin?.celsius?.toStringAsFixed(0)}° C"),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildWeatherInfoItem("Wind", "${_weather?.windSpeed?.toStringAsFixed(0)} m/s"),
              _buildWeatherInfoItem("Humidity", "${_weather?.humidity?.toStringAsFixed(0)}%"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherInfoItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.white70),
        ),
      ],
    );
  }

  Widget _buildNextWeekForecast() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Other Cities',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),
        ),
        const SizedBox(height: 16),
        ListView.builder(

          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _otherCitiesWeather.length,
          itemBuilder: (context, index) {
            final weather = _otherCitiesWeather[index];
            return _buildWeatherCard(weather);
          },
        ),
      ],
    );
  }
  Widget _buildWeatherCard(Weather weather) {
    return Card(color: Colors.blueGrey,
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              weather.areaName ?? "",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Image.network(
                  "http://openweathermap.org/img/wn/${weather.weatherIcon}@4x.png",
                  height: 50,
                  width: 50,
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${weather.temperature?.celsius?.toStringAsFixed(0)}° C",
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      weather.weatherDescription ?? "",
                      style: const TextStyle(fontSize: 14, color: Colors.black45),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForecastCard({required String imageUrl, required String day, required String forecast,required String windspeed,required String humidity,required String temp}) {
    return Card(color: Colors.blueGrey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.network(imageUrl, height: 50),
                    const SizedBox(width: 8),
                    Text(
                      temp,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  day,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  forecast,
                  style: const TextStyle(fontSize: 14, color: Colors.black45),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
