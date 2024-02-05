import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetable_info_app/providers/search_provider.dart';
import 'package:timetable_info_app/screens/main_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SearchProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timetable Info App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: MainScreen(),
      ),
    );
  }
}
