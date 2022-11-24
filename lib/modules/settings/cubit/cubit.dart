import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/settings/cubit/states.dart';
import 'package:news_app/shared/components/constants.dart';
import 'package:news_app/shared/network/local/chache_helper.dart';

import '../../../models/auth_error_model.dart';
import '../../../shared/components/components.dart';
import '../../login/pic_login_screen.dart';

// List<String> items = ['One', 'Two', 'Three', 'Four', 'Five'];

Map<double, String> items = {
  16.0: 'الخط 1',
  20.0: 'الخط 2',
  24.0: 'الخط 3',
  28.0: 'الخط 4',
  32.0: 'الخط 5'
};
Map<ThemeMode, String> ThemeItems = {
  ThemeMode.system: 'الوضع الافتراضي للنظام',
  ThemeMode.light: 'فاتح',
  ThemeMode.dark: 'داكن'
};

class SettingCubit extends Cubit<SettingsStates> {
  SettingCubit() : super(SettingsInitialState());
  static SettingCubit get(context) => BlocProvider.of(context);

  ThemeMode? theme;

  void changeTheme({ThemeMode? themeData}) {
    theme = themeData!;
    CacheHelper.saveData(key: 'theme', value: convertToThemeNumber(themeData));
    emit(ChangeThemeState());
  }

  double? fontSize;
  void changeFontSize({double? value}) {
    fontSize = value;
    CacheHelper.saveData(key: 'fontSize', value: value);
    emit(ChangeFontSizeState());
  }

  ErrorModel? errorModel;
  void signOut(
    BuildContext? context,
  ) {
    CacheHelper.removeData(
      key: 'token',
    ).then((value) {
      if (value) {
        // print token from cache
        print(CacheHelper.getData(key: 'token'));
        navigateAndFinish(
          context,
          LoginScreen(),
        );
      }
    });
    // emit(LogOutLoadingState());
    // DioHelper.postData(
    //   url: '?rest_route=/simple-jwt-login/v1/auth/revoke',
    //   query: {
    //     'AUTH_KEY': 'A>D&M/PYk2+34epB',
    //   },
    //   data: {
    //     'JWT': CacheHelper.getData(key: 'token'),
    //   },
    // ).then((value) {
    //   if (value.statusCode == 200) {
    //     emit(LogOutSuccessState());
    //     CacheHelper.removeData(
    //       key: 'token',
    //     ).then((value) {
    //       if (value) {
    //         navigateAndFinish(
    //           context,
    //           LoginScreen(),
    //         );
    //       }
    //     });
    //   } else {
    //     debugPrint('value: $value');
    //     errorModel = ErrorModel.fromJson(value.data);
    //     throw Exception(errorModel!.data!.message);
    //   }
    // }).catchError((error) {
    //   // print(error.toString());
    //   emit(LogOutErrorState(error.toString()));
    // });
  }
}
