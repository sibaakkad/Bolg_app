import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';

import '../shared/components/constants.dart';

class NewsAppLayout extends StatelessWidget {
  const NewsAppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: SizedBox(
            height: 78,
            child: BottomNavigationBar(
              selectedFontSize: 0,
              unselectedFontSize: 0,
              onTap: (index) {
                cubit.changeBottom(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    myIcons['Home']!,
                    color: cubit.currentIndex == 0
                        ? Theme.of(context).iconTheme.color
                        : null,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    myIcons['Favorite']!,
                    color: cubit.currentIndex == 1
                        ? Theme.of(context).iconTheme.color
                        : null,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    myIcons['Categoris']!,
                    color: cubit.currentIndex == 2
                        ? Theme.of(context).iconTheme.color
                        : null,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    myIcons['Settings']!,
                    color: cubit.currentIndex == 3
                        ? Theme.of(context).iconTheme.color
                        : null,
                  ),
                  label: '',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
