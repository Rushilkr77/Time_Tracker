import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/landing_page.dart';
import 'package:time_tracker/app/sign_in/sign_in_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';

import 'package:time_tracker/services/auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<Authbase>(
      create: (context) => Auth(),
      child: MaterialApp(
        title: 'Time tracker',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: LandingPage(),
      ),
    );
  }
}
