import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/bloc/car/cubit/car_cubit.dart';
import 'package:flutter_application_1/feat/home/screen/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CarCubit()..initCar(),
      lazy: false,
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
