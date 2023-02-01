import 'package:egyptianrc/presentation/resources/string_manager.dart';
import 'package:flutter/material.dart';

import '../view/landing_view/landing_view.dart';
import '../view/login_view/fast_login_view.dart';
import '../view/login_view/first_view.dart';
import '../view/login_view/login_view.dart';
import '../view/login_view/signup_view.dart';

class Routes {
  static const String first = "/first";
  static const String fastLogin = "/fastLogin";
  static const String login = "/login";
  static const String signup = "/signup";
  static const String landing = "/";
  static const String home = "/home";
  static const String user = "/user";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.first:
        return MaterialPageRoute(builder: (_) => const FirstLoginView());
      case Routes.fastLogin:
        return MaterialPageRoute(builder: (_) => const FastLoginView());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.signup:
        return MaterialPageRoute(builder: (_) => const SignupView());
      case Routes.landing:
        return MaterialPageRoute(
            builder: (_) => const LandingView(HomePageStates.splash));
      case Routes.home:
        return MaterialPageRoute(
            builder: (_) => const LandingView(HomePageStates.landing));

      default:
        return _unDefinedRoute();
    }
  }

  static Route<dynamic> _unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(StringManger.noRoutes),
              ),
              body: const Center(child: Text(StringManger.noRoutes)),
            ));
  }
}
