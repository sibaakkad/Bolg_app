import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/login/cubit/cubit.dart';
import 'package:news_app/modules/login/cubit/states.dart';
import 'package:news_app/shared/styles/colors.dart';

import '../../shared/components/components.dart';
import '../register/pic_register_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var resetPasswordEmailController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (BuildContext context, state) {
          if (state is LoginErrorState) {
            showToast(
              text: state.error,
              state: ToastStates.ERROR,
            );
          }
          if (state is LoginSuccessState) {
            showToast(
                text: 'تم تسجيل الدخول بنجاح', state: ToastStates.SUCCESS);
          }
          if (state is ResetPasswordSuccessState) {
            Navigator.pop(context);
            showToast(
                text: state.resetPasswordModel.message ?? 'تم ارسال الرابط',
                state: ToastStates.SUCCESS);
          }
          if (state is ResetPasswordErrorState) {
            showToast(text: state.error, state: ToastStates.ERROR);
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'تسجيل الدخول',
                          style:
                              Theme.of(context).textTheme.headline4?.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color,
                                  ),
                        ),
                        Text(
                          'الرجاء تسجيل الدخول للمتابعة',
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          // validate: (value) {
                          //   if (value!.isEmpty) {
                          //     // return 'please enter your email address';
                          //     return'';
                          //   }
                          //   return null;
                          // },
                          label: 'البريد الإلكتروني',
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 24.0,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          label: 'كلمة المرور',
                          // validate: (value) {
                          //   if (value!.isEmpty) {
                          //     // return 'passsword is too short';
                          //     return '';
                          //   }

                          // },
                          prefix: Icons.lock_outlined,
                          suffix: cubit.suffix,
                          suffixPressed: () {
                            cubit.changePasswordVisibility();
                          },
                          isPassword: cubit.isPassword,
                          // onSubmit: (value) {
                          //   if (formKey.currentState!.validate()) {
                          //     LoginCubit.get(context).userLogin(
                          //       email: emailController.text,
                          //       password: passwordController.text,
                          //     );
                          //   }
                          // },
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        defaultTextButton(
                          function: () {
                            popup(
                              context: context,
                              title: '  تحديث كلمة المرور',
                              list: [
                                // state is! ResetPasswordLoadingState
                                //     ? defaultFormField(
                                //         controller:
                                //             resetPasswordEmailController,
                                //         type: TextInputType.emailAddress,
                                //         label: 'البريد الإلكتروني',
                                //         prefix: Icons.email_outlined,
                                //       )
                                //     : defualtLoading(),
                                defaultFormField(
                                    controller: resetPasswordEmailController,
                                    label: 'البريد الالكتروني',
                                    prefix: Icons.email_outlined),
                                const SizedBox(
                                  height: 24.0,
                                ),
                                defaultButton(
                                  background: defaultColorBlue,
                                  function: () {
                                    cubit.resetPassword(
                                        email:
                                            resetPasswordEmailController.text);
                                  },
                                  text: 'تحديث',
                                ),
                              ],
                            );
                          },
                          text: 'هل نسيت كلمة المرور؟',
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        state is! LoginLoadingState
                            ? defaultButton(
                                background: defaultColorBlue,
                                function: () {
                                  cubit.userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    context: context,
                                  );
                                  // if (formKey.currentState!.validate()) {
                                  //   cubit.userLogin(
                                  //     email: emailController.text,
                                  //     password: passwordController.text,
                                  //     context: context,
                                  //   );
                                  // }
                                },
                                text: 'تسجيل الدخول',
                              )
                            : defualtLoading(),
                        const SizedBox(
                          height: 24.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'اذا لم يكن لديك حساب؟',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                              ),
                            ),
                            defaultTextButton(
                              function: () {
                                navigateTo(context, RegisterScreen());
                              },
                              text: 'انشاء حساب',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
