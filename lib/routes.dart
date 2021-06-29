import 'package:amazon/routes/product_page.dart';
import 'package:flutter/material.dart';
import 'package:amazon/routes/auth.dart';
import 'package:amazon/routes/home.dart';
import 'package:amazon/routes/initNavigator.dart';

class RouteGenerator {
  static const String initNavigator = "/";
  static const String home = "/home";
  static const String login = "/login";
  static const String productPage = "/productPage";

  RouteGenerator._() {}

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initNavigator:
        return MaterialPageRoute(builder: (_) => const InitNavigator());

      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());

      case login:
        return MaterialPageRoute(builder: (_) => const AuthPage());

      case productPage:
        return MaterialPageRoute(builder: (_) => const ProductPage());

      default:
        throw FormatException("Route not found");
    }
  }
}

class RouteException {
  final String message;
  const RouteException(this.message);
}
