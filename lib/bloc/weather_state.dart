part of 'weather_bloc.dart';

@immutable
sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}
final class WeatherblocLoading extends WeatherState {}
final class WeatherblocLoaded extends WeatherState {}
final class WeatherblocError extends WeatherState {}