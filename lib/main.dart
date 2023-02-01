import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/auth_bloc/auth_status_bloc.dart';
import 'bloc/my_bloc_observer.dart';

import 'data/data_sources/fcm.dart';
import 'data/data_sources/pref_repository.dart';
import 'data/models/app_user.dart';
import 'presentation/resources/routes_manger.dart';
import 'presentation/resources/string_manager.dart';
import 'presentation/resources/theme/theme_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceRepository.init();
  await Firebase.initializeApp();
  FireNotificationHelper(print);
  Bloc.observer = MyBlocObserver();

  String? userData = PreferenceRepository.getData(key: PreferenceKey.userData);
  CompleteUser? user =
      userData == null ? null : CompleteUser.fromJson(userData);
  runApp(MyApp(user));
}

class MyApp extends StatelessWidget {
  const MyApp(this.user, {super.key});
  final CompleteUser? user;

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthBloc(user), lazy: false),
        ],
        child: MaterialApp(
          title: StringManger.appName,
          theme: lightThemeData,
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: user == null ? Routes.login : Routes.landing,
          // ),
        ),
      );
}
