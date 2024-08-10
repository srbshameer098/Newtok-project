import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:newtok/view/Authentication/Login/Login.dart';



import 'package:flutter_bloc/flutter_bloc.dart';


import 'bloc/weather_bloc.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (
        context) => WeatherBloc(),
      child:
      MaterialApp(debugShowCheckedModeBanner: false,
      title: 'Newtok Project',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  LoginPage(),
      ),
    );
  }
}