import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mini_project_five/screens/mapPage.dart';
import 'data/getData.dart';
import 'package:mini_project_five/screens/splitscreen.dart';
import 'package:mini_project_five/screens/testmap.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft, // Left-side Landscape
    DeviceOrientation.landscapeRight, // Right-side Landscape
  ]);
  await BusData().loadData();
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;
  void onThemeChanged(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      initialRoute: '/home',
      routes: {
      '/home' : (context) => testMap_Page(),
        // '/home' : (context) => Map_Page(),
      //   '/home' : (context) => SplitScreenMapPage(),
      },
    );
  }
}
