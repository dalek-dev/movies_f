import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies/services/dependency_injector.dart';
import 'package:movies/src/movies/bloc/simple_bloc_observer.dart';
import 'package:movies/src/movies/view/screens/home_screen.dart';

void main() {
  configureDependencies();

  BlocOverrides.runZoned(() {
    runApp(const MyApp());
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }, blocObserver: SimpleBlocObserver());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
