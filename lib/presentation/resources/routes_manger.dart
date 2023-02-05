import 'package:egyptianrc/presentation/resources/string_manager.dart';
import 'package:egyptianrc/presentation/view/auth_view/sign_in_view/sign_in_view.dart';
import 'package:egyptianrc/presentation/view/auth_view/sign_up_view/sign_up_view.dart';
import 'package:egyptianrc/presentation/view/landing_view/user_view/edit_views/edit_address.dart';
import 'package:egyptianrc/presentation/view/landing_view/user_view/edit_views/edit_email.dart';
import 'package:egyptianrc/presentation/view/landing_view/user_view/edit_views/edit_name.dart';
import 'package:egyptianrc/presentation/view/landing_view/user_view/edit_views/edit_password.dart';
import 'package:egyptianrc/presentation/view/landing_view/user_view/edit_views/edit_phone.dart';
import 'package:flutter/material.dart';

import '../view/auth_view/fast_sign_in_view/fast_sign_in_view.dart';
import '../view/auth_view/first_view/first_view.dart';
import '../view/auth_view/sign_up_view/otp_view.dart';
import '../view/chat_view/chat_view.dart';
import '../view/landing_view/landing_view.dart';
import '../view/user_view/post_disaster_view/post_disaster.dart';

class Routes {
  static const String first = "/";
  static const String fastLogin = "/fastsignin";
  static const String login = "/signin";
  static const String signup = "/signup";
  static const String otp = "/otp";
  static const String home = "/home";
  static const String user = "/user";
  static const String chat = "/chat";
  static const String post = "/post";

  static const String editName = "/editName";
  static const String editEmail = "/editEmail";
  static const String editPassword = "/editPass";
  static const String editPhone = "/editPhone";
  static const String editAddress = "/editAddress";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.first:
        return MaterialPageRoute(builder: (_) => const FirstLoginView());
      case Routes.fastLogin:
        return MaterialPageRoute(builder: (_) => const FastSignInView());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const SignInView());
      case Routes.otp:
        return MaterialPageRoute(builder: (_) => const OtpView());
      case Routes.chat:
        return MaterialPageRoute(builder: (_) => ChatView());
      case Routes.signup:
        return MaterialPageRoute(builder: (_) => const SignUpView());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const LandingView());
      case Routes.post:
        return MaterialPageRoute(
            builder: (_) =>
                PostDisasterView(settings.arguments as DisasterGridItem));
      case Routes.editPhone:
        return MaterialPageRoute(builder: (_) => EditPhoneView());
      case Routes.editAddress:
        return MaterialPageRoute(builder: (_) => EditAddressView());
      case Routes.editPassword:
        return MaterialPageRoute(builder: (_) => EditPasswordView());
      case Routes.editEmail:
        return MaterialPageRoute(builder: (_) => EditEmailView());
      case Routes.editName:
        return MaterialPageRoute(builder: (_) => EditNameView());
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
