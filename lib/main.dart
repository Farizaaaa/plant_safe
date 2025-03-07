import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:plant_safe/model/image_info_box.dart';
import 'package:plant_safe/model/image_info_model.dart';
import 'package:plant_safe/model/user_model.dart';
import 'package:plant_safe/screens/splash_screen.dart';
import 'package:plant_safe/themes/light_mode.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserDataAdapter());
  await UserDataBox.openBox();
  Hive.registerAdapter(ImageInfoModelAdapter());
  await ImageDatabase.openBox();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Plant Safe",
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: lightMode,
    );
  }
}

