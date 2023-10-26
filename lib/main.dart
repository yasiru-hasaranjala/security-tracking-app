import 'package:flutter/material.dart';
import 'package:tracking/modules/home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tracking/modules/login/login.dart';
import 'package:tracking/modules/map/map.dart';
import 'package:tracking/modules/signup/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey:'AIzaSyDfl6-mqzU3z2IQbLqe4242NzODaMO4jWo',
          appId:'1:879894640795:android:7be665559cf8f8ea11ee3e',
          messagingSenderId:'879894640795',
          projectId:'car-security-system-8d7b1'
      )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData(),
      initialRoute: 'welcome_screen',
      routes: {
        'welcome_screen': (context) => const HomeScreen(),
        'registration_screen': (context) => const SignUpScreen(),
        'login_screen': (context) => const LoginScreen(),
        'home_screen': (context) => const Map()
      },
    );
  }
}
