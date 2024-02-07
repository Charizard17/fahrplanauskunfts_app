import 'package:flutter/material.dart';
import 'package:fahrplanauskunfts_app/screens/main_screen.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fahrplanauskunfts App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: const MainScreen(),
      ),
    );
  }
}
