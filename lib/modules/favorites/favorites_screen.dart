import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(listener: (context, state) {
      debugPrint('state: $state');
    }, builder: (context, state) {
      var cubit = AppCubit.get(context);
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 75,
          title: defualtappBar(title: 'المفضلة'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: cubit.favoriteList.isEmpty
              ? const Center(
                  child: Text(
                  ' لا توجد عناصر بالمفضلة',
                ))
              : cubit.favoritePosts != null
                  ? ListView.separated(
                      itemBuilder: (context, index) {
                        return buildNewsItem(
                          context: context,
                          model: cubit.favoritePosts![index],
                        );
                      },
                      separatorBuilder: (context, index) => myDivider(),
                      itemCount: cubit.favoritePosts!.length,
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
        ),
      );
    });
  }
}
