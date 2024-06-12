import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobimall/admin/add_food.dart';
import 'package:mobimall/admin/admin_login.dart';
import 'package:mobimall/pages/bottomnav.dart';
import 'package:mobimall/pages/details.dart';
import 'package:mobimall/pages/home.dart';
import 'package:mobimall/pages/login.dart';
import 'package:mobimall/pages/onboard.dart';
import 'package:mobimall/pages/signup.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:mobimall/widget/app_constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  Stripe.publishableKey = publishableKey;
  await Firebase.initializeApp(options: FirebaseOptions(
      apiKey: 'AIzaSyDi3ZCN0C36JHyxGKVSaQrsgbvOshmTZRk',
      appId: '1:761961568576:android:fa7a34de9c5efb0d7902a5',
      messagingSenderId: '761961568576',
      projectId: 'fooddeliveryapp-f4242',
      storageBucket: 'fooddeliveryapp-f4242.appspot.com'
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AdminLogin(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold();
  }
}
