import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app_layout.dart';
import 'package:news_app/models/auth_error_model.dart';
import 'package:news_app/models/reset_password_model.dart';
import 'package:news_app/modules/login/cubit/states.dart';

import '../../../models/login_model.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network/local/chache_helper.dart';
import '../../../shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;
  ErrorModel? loginErrorModel;

  void userLogin({
    required String email,
    required String password,
    BuildContext? context,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: '?rest_route=/simple-jwt-login/v1/auth',
      query: {
        'AUTH_KEY': 'A>D&M/PYk2+34epB',
      },
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      // print(value.data);
      if (value.statusCode == 200) {
        loginModel = LoginModel.fromJson(value.data);
        emit(LoginSuccessState(loginModel!));
        //save token in shared preferences
        CacheHelper.saveData(
          key: 'token',
          value: loginModel!.data!.jwt,
        ).then((value) {
          navigateAndFinish(context, const NewsAppLayout());
        });
      } else {
        debugPrint('value: $value');
        loginErrorModel = ErrorModel.fromJson(value.data);
        throw Exception(loginErrorModel!.data!.message);
      }
    }).catchError((error) {
      // print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
    //print token
  }

  ErrorModel? resetPasswordErrorModel;
  ResetPasswordModel? resetPasswordModel;
  void resetPassword({
    required String email,
    BuildContext? context,
  }) {
    emit(ResetPasswordLoadingState());
    DioHelper.postData(
      url: '?rest_route=/simple-jwt-login/v1/user/reset_password',
      query: {
        'AUTH_KEY': 'A>D&M/PYk2+34epB',
      },
      data: {
        'email': email,
      },
    ).then((value) {
      // print(value.data);

      if (value.statusCode == 200) {
        resetPasswordModel = ResetPasswordModel.fromJson(value.data);
        emit(ResetPasswordSuccessState(resetPasswordModel!));
        // navigateAndFinish(context, const NewsAppLayout());
      } else {
        resetPasswordErrorModel = ErrorModel.fromJson(value.data);
        throw Exception(resetPasswordErrorModel!.data!.message);
      }
    }).catchError((error) {
      print(error.toString());
      emit(ResetPasswordErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }
}
