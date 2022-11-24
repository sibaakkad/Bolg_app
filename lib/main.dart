import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:news_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:news_app/layout/news_app_layout.dart';
import 'package:news_app/modules/login/pic_login_screen.dart';
import 'package:news_app/modules/settings/cubit/cubit.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/shared/components/constants.dart';
import 'package:news_app/shared/network/local/chache_helper.dart';
import 'package:news_app/shared/styles/themes.dart';

import 'layout/cubit/cubit.dart';
import 'modules/settings/cubit/states.dart';
import 'shared/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  // splash screen
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();

  int themeNumber = CacheHelper.getData(key: 'theme') ?? 0;
  double fontSize = CacheHelper.getData(key: 'fontSize') ?? 11.0;
  ThemeMode? themeData = convertToThemeMode(themeNumber);
  Widget widget;

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  debugPrint('onBoarding: $onBoarding');

  token = CacheHelper.getData(key: 'token') ?? '';
  debugPrint('token: $token');

  if (onBoarding != null) {
    if (token != '') {
      widget = const NewsAppLayout();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }

  runApp(MyApp(
    themeData: themeData,
    fontSize: fontSize,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final ThemeMode themeData;
  final double fontSize;
  final Widget startWidget;

  const MyApp(
      {super.key,
      required this.themeData,
      required this.fontSize,
      required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AppCubit()
              ..getCategories()
              ..getPostsData()
              ..getstickyPostsData()
              ..getfavoriteList(),
            // value: AppCubit()
            //   ..getCategories()
            //   ..getPostsData()
            //   ..getstickyPostsData()
            //   ..getfavoriteList(),
          ),
          BlocProvider(
            create: (BuildContext context) => SettingCubit()
              ..changeTheme(themeData: themeData)
              ..changeFontSize(value: fontSize),
            // value: SettingCubit()
            //   ..changeTheme(themeData: themeData)
            //   ..changeFontSize(value: fontSize),
          ),
        ],
        child: BlocConsumer<SettingCubit, SettingsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = SettingCubit.get(context);
            return MaterialApp(
              localizationsDelegates: const [
                GlobalCupertinoLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale(
                    "ar", "AE"), // OR Locale('ar', 'AE') OR Other RTL locales
              ],
              locale: const Locale(
                  "ar", "AE"), // OR Locale('ar', 'AE') OR Other RTL locales,
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: cubit.theme,
              home: const NewsAppLayout(),
            );
          },
        ));
  }
}
