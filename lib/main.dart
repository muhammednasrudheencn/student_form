import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:studentform/model/data_model.dart';
import 'package:studentform/screens/screen_home.dart';

Future<void> main() async {
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentformAdapter().typeId)) {
    Hive.registerAdapter(StudentformAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
