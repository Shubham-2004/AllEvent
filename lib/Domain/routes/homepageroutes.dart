import 'package:allevent/presentation/search/Screen/homepageui.dart';
import 'package:flutter/material.dart';

class HomePageRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePageUI());
      default:
        return MaterialPageRoute(builder: (_) => HomePageUI());
    }
  }
}
