import 'package:egyptianrc/presentation/view/user_view/post_disaster_view/post_disaster.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc/auth_bloc/auth_status_bloc.dart';
import 'bloc/home_bloc/home_bloc.dart';
import 'bloc/my_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

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
  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = true;
  }

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCpHOJR0jXHno5Ipue_tlUKQQ6xd43c3tA",
            authDomain: "egyptianrc-41529.firebaseapp.com",
            databaseURL: "https://egyptianrc-41529-default-rtdb.firebaseio.com",
            projectId: "egyptianrc-41529",
            storageBucket: "egyptianrc-41529.appspot.com",
            messagingSenderId: "462455386900",
            appId: "1:462455386900:web:c4d8f9a4bb61ec2e59c801",
            measurementId: "G-3EZ9RQ2ZBE"));
  } else {
    await Firebase.initializeApp();
    FireNotificationHelper(print);
  }

  Bloc.observer = MyBlocObserver();

  String? userData = PreferenceRepository.getData(key: PreferenceKey.userData);
  AppUser? user = userData == null ? null : AppUser.fromJson(userData);
  runApp(MyApp(user));
}

class MyApp extends StatelessWidget {
  const MyApp(this.user, {super.key});
  final AppUser? user;

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthBloc(user), lazy: false),
          BlocProvider(create: (context) => HomeBloc()),
        ],
        child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (BuildContext context, Widget? child) {
            return MaterialApp(
              builder: (context, child) => Directionality(
                textDirection: TextDirection.rtl,
                child: child!,
              ),
              // useInheritedMediaQuery: true,
              title: StringManger.appName,
              theme: lightThemeData,
              debugShowCheckedModeBanner: false,
              themeMode: ThemeMode.light,
              // onGenerateRoute: RouteGenerator.getRoute,
              // //TODO: don't forget to change this {user == null ? Routes.first : }
              // initialRoute: Routes.home,
              home: PostDisasterView(),
              // ),
            );
          },
        ),
      );
}
