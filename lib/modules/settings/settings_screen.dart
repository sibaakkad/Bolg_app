import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/settings/cubit/cubit.dart';
import 'package:news_app/modules/settings/cubit/states.dart';
import 'package:news_app/shared/styles/colors.dart';

import '../../shared/components/components.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingCubit, SettingsStates>(
      listener: (context, state) {
        state is LogOutErrorState
            ? showToast(
                text: state.error,
                state: ToastStates.ERROR,
              )
            : null;
      },
      builder: (context, state) {
        var cubit = SettingCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            // leading: const Icon(Icons.arrow_back),
            title: const Text(
              'الاعدادات',
              // style: TextStyle(

              //   fontSize: 20,
              //   fontWeight: FontWeight.w700,
              //   letterSpacing: -0.01,
              // ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sectionTitle(title: 'المعلومات الشخصية', context: context),
                settingsItem(
                    icon: Icons.person, text: 'حسابك الشخصي', context: context),
                settingsItem(
                    icon: Icons.lock,
                    text: 'تغير كلمة المرور',
                    context: context),
                sectionTitle(title: 'اعدادات المظهر', context: context),
                settingsItem(
                  icon: Icons.brightness_medium_outlined,
                  text: 'المظهر',
                  context: context,
                  OnTap: () {
                    popup(
                      context: context,
                      title: 'اختيار المظهر',
                      list: ThemeItems.entries.map<Theme>((element) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            unselectedWidgetColor: defaultColorGrey,
                          ),
                          child: RadioListTile(
                            activeColor: Colors.blue,
                            title: Text(
                              element.value,
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color),
                            ),
                            value: element.key,
                            groupValue: cubit.theme,
                            onChanged: (value) {
                              cubit.changeTheme(themeData: value!);
                              Navigator.pop(context);
                            },
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
                settingsItem(
                  icon: Icons.font_download,
                  text: ' حجم الخط',
                  context: context,
                  OnTap: () {
                    popup(
                      context: context,
                      title: 'اختيار حجم خط المقالات',
                      list: items.entries.map<Theme>((element) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            unselectedWidgetColor: defaultColorGrey,
                          ),
                          child: RadioListTile(
                            activeColor: Colors.blue,
                            title: Text(
                              element.value,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                                fontSize: element.key,
                              ),
                            ),
                            value: element.key,
                            groupValue: cubit.fontSize,
                            onChanged: (value) {
                              cubit.changeFontSize(value: value);
                              Navigator.pop(context);
                            },
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
                // const Spacer(),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: defaultTextButton(
                    function: () {
                      cubit.signOut(context);
                    },
                    text: 'تسجيل الخروج',
                    color: const Color.fromRGBO(235, 87, 87, 1),
                  ),
                ),

                // const SizedBox(
                //   height: 64,
                // ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget sectionTitle({required String title, required context}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).textTheme.bodyText1!.color,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.03,
          ),
        ),
      );

  Widget settingsItem({
    required IconData icon,
    required String text,
    required context,
    void Function()? OnTap,
  }) =>
      Column(
        children: [
          ListTile(
            onTap: OnTap,
            leading: Icon(
              icon,
              color: defaultColorGrey,
            ),
            title: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.03,
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
            ),
          ),
          myDivider(verticalPadding: 0),
        ],
      );
}
