import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/auth_error_model.dart';
import 'package:news_app/modules/register/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

import '../../../layout/news_app_layout.dart';
import '../../../models/register_model.dart';
import '../../../shared/network/local/chache_helper.dart';
import '../../../shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  RegisterModel? registerModel;
  ErrorModel? registerErrorModel;

  void userRegister({
    required String? email,
    required String? password,
    required String? name,
    BuildContext? context,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: '?rest_route=/simple-jwt-login/v1/users',
      query: {
        'AUTH_KEY': 'A>D&M/PYk2+34epB',
      },
      data: {
        'user_login': name,
        'email': email,
        'password': password,
      },
    ).then((value) {
      if (value.statusCode == 200) {
        registerModel = RegisterModel.fromJson(value.data);
        emit(RegisterSuccessState(registerModel!));
        CacheHelper.saveData(
          key: 'token',
          value: registerModel!.jwt,
        ).then((value) {
          navigateAndFinish(context, const NewsAppLayout());
        });
      } else {
        debugPrint('value: $value');
        registerErrorModel = ErrorModel.fromJson(value.data);
        throw Exception(registerErrorModel!.data!.message);
      }
    }).catchError((error) {
      // print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterChangePasswordVisibilityState());
  }
}
