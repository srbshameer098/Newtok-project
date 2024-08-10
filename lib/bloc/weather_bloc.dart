import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../Repository/API/Weather_api/Weather_api.dart';
import '../Repository/Model_Class/weather_model.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  weatherApi WeatherApi = weatherApi();
  late Weather_Model weather_model;
  WeatherBloc() : super(WeatherInitial()) {
    on<WeatherEvent>((event, emit) async {

      emit(WeatherblocLoading());
      try {
        weather_model = await WeatherApi.getWeather();
        emit(WeatherblocLoaded());
      } catch (e) {
        print(e);
        emit(WeatherblocError());
      }
      // TODO: implement event handler
    });
  }
}
