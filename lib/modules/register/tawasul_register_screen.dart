import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/register/cubit/cubit.dart';
import 'package:news_app/modules/register/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/styles/colors.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (BuildContext context, state) {
          if (state is RegisterErrorState) {
            showToast(
              text: state.error,
              state: ToastStates.ERROR,
            );
          }
          if (state is RegisterSuccessState) {
            showToast(
                text: state.registerModel.message ?? ' تم انشاء الحساب بنجاح',
                state: ToastStates.SUCCESS);
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'انشاء حساب',
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color,
                                  ),
                        ),
                        Text(
                          'اهلا بك في تواصل',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          // validate: (value) {
                          //   if (value!.isEmpty) {
                          //     return 'please enter your name';
                          //   }
                          //   return null;
                          // },
                          label: 'اسم المستخدم',
                          prefix: Icons.person,
                        ),
                        const SizedBox(
                          height: 24.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          // validate: (value) {
                          //   if (value!.isEmpty) {
                          //     return 'please enter your email address';
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
                          suffix: cubit.suffix,
                          onSubmit: (value) {},
                          isPassword: RegisterCubit.get(context).isPassword,
                          suffixPressed: () {
                            RegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                          // validate: (value) {
                          //   if (value!.isEmpty) {
                          //     return 'password is too short';
                          //   }
                          //   return null;
                          // },
                          label: 'كلمة المرور',
                          prefix: Icons.lock_outline,
                        ),
                        const SizedBox(
                          height: 60.0,
                        ),
                        // const SizedBox(
                        //   height: 30.0,
                        // ),
                        state is! RegisterLoadingState
                            ? defaultButton(
                                background: defaultColorBlue,
                                function: () {
                                  // if (formKey.currentState!.validate()) {
                                  cubit.userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    context: context,
                                  );
                                },
                                // },
                                text: 'انشاء حساب',
                              )
                            : defualtLoading(),
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
