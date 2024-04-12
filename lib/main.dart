import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:karshi/auth%20files/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:karshi/backend/models/models.dart';
import 'package:karshi/backend/services/auth.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return StreamProvider<UserAuth?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        title: 'Krashi',
        // theme: ThemeData(),
        home: SigninScreen(),
      ),
    );
  }
}
