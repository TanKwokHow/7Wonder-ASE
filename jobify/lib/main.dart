import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'Screens/Login/splash.dart';
import 'config/palette.dart';

// Important to add below code for firebase_core >= ^0.5.0
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase
      .initializeApp(); // this method is only for firebase_core >= ^0.5.0
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LitAuthInit(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App Bar',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          accentColor: Palette.darkOrange,
          appBarTheme: const AppBarTheme(
            brightness: Brightness.dark,
            color: Palette.darkBlue,
          ),
        ),
        // home: LitAuthState(
        //   authenticated: HomeScreen(),
        //   unauthenticated: AuthScreen(),
        // ),
        home: SplashScreen(),
      ),
    );
  }
}
