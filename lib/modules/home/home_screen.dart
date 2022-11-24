import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/home/search_screen.dart';
import 'package:news_app/modules/home/sticky_posts.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 75,
            title: defualtappBar(
              title: 'تواصل',
              // widget: Row(
              //   children: const [
              //     Text(
              //       'Today’s Reading',
              //       style: TextStyle(
              //           fontSize: 14,
              //           color: defaultColorGrey,
              //           fontWeight: FontWeight.w500),
              //     ),
              //     SizedBox(
              //       width: 8,
              //     ),
              //     Text(
              //       '25 min left',
              //       style: TextStyle(
              //         fontSize: 14,
              //         fontWeight: FontWeight.w500,
              //       ),
              //     ),
              //   ],
              // ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  defaultFormField(
                    autofocus: false,
                    readOnly: true,
                    label: 'بحث',
                    onTap: () {
                      navigateTo(
                        context,
                        const SearchScreen(),
                      );
                    },
                    prefix: Icons.search_outlined,
                  ),
                  title(text: 'الأكثر شهرة', context: context),
                  const StickyPosts(),
                  title(text: 'احدث المقالات', context: context),
                  cubit.posts != null
                      ? ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return buildNewsItem(
                              context: context,
                              model: cubit.posts![index],
                            );
                          },
                          separatorBuilder: (context, index) => myDivider(),
                          itemCount: cubit.posts!.length,
                        )
                      : ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return loadingBuildNewsItem();
                          },
                          separatorBuilder: (context, index) => myDivider(),
                          itemCount: 3,
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
