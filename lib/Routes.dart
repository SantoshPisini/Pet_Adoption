import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption/screens/CreateUser.dart';
import 'package:pet_adoption/screens/HomeScreen.dart';
import 'package:pet_adoption/screens/LoginScreen.dart';
import 'package:pet_adoption/screens/SplashScreen.dart';
import 'package:pet_adoption/RoutingConstants.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  var view;
  switch (settings.name) {
    case SplashViewRoute:
      view = SplashView();
      break;
    case LoginViewRoute:
      view = LoginScreen();
      break;
    case CreateUserRoute:
      view = CreateUser();
      break;
    case HomeViewRoute:
      view = HomeScreen();
      break;
    default:
    // view = SplashView();
  }
  return MaterialPageRoute(builder: (context) => view);
}
