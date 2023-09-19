import 'package:flutter/material.dart';
import 'package:unada_interview/screens/home/view.dart';

class AppRoutes {
  static route(route) => MaterialPageRoute(builder: (_) => route);

  static const homePage = "/";

  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return route(HomePage());

    }
    return null;
  }
}
