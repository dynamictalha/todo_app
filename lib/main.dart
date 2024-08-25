
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'pages/start_page.dart';





void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyC7lblP4287aCki8_su9GK7RknjRW7nxy0",
          appId: "1:408508067182:android:fbb918a2afa6b10d77a57f",
          messagingSenderId: "408508067182",
          projectId: "mytodoapp-e9ce5"));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ToDo App 2024",
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,  // Background color for all screens
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,        // AppBar color
          iconTheme: IconThemeData(color: Colors.black), // AppBar icons color
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 20), // AppBar title color
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,        // BottomNavigationBar color
          selectedItemColor: Color(0xFF0C36CC),      // Selected item color
          unselectedItemColor: Color(0xFF000000),     // Unselected item color
        ),
      ),
      
      home: const StartPage(),
    );
  }
}
