import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'blocs/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // For normal use or Single Global Instance of BLOC use
    //======================================================
    // return MaterialApp(
    //   title: 'Log Me In Using BLOC',
    //   home: Scaffold(
    //     body: LoginScreen(),
    //   ),
    // );

    // For Scoped Instances use
    //======================================================
    return Provider(
      // Now every widget inside this Provider widget can get access to every property define inside Provider class.
      child: MaterialApp(
        title: 'Log Me In Using BLOC',
        home: Scaffold(
          body: LoginScreen(),
        ),
      ),
    );
  }
}
