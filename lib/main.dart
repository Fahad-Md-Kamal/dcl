import 'package:flutter/material.dart';
import 'package:starterApp/views/formView.dart';
import 'package:starterApp/views/informationView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fahad Md Kamal',
      theme: ThemeData(
        buttonColor: Colors.teal.shade500,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.teal.shade400,
          // textTheme: ButtonTextTheme.accent,
        ),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: FormView.routeName,
      routes: {
        FormView.routeName: (context) => FormView(),
        InformationView.routeName: (context) => InformationView(),
      },
    );
  }
}
