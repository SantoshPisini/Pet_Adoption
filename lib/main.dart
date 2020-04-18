import 'package:flutter/material.dart';
import 'package:pet_adoption/Constants.dart';
import 'package:pet_adoption/Routes.dart' as route;
import 'package:pet_adoption/RoutingConstants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kColor_GUNMETAL,
        accentColor: kColor_BLUEPURPLE,
      ),
      onGenerateRoute: route.generateRoute,
      //todo:change to splash
      initialRoute: HomeViewRoute,
    );
  }
}
