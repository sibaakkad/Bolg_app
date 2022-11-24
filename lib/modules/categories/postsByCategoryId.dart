import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:news_app/layout/cubit/states.dart';

import '../../layout/cubit/cubit.dart';
import '../../models/posts_model.dart';
import '../../shared/components/components.dart';

class CategoriPostList extends StatefulWidget {
  final ScrollPhysics physics;
  final bool shrinkWrap;
  const CategoriPostList(
      {super.key, required this.physics, required this.shrinkWrap});

  @override
  State<CategoriPostList> createState() => _CategoriPostListState();
}

class _CategoriPostListState extends State<CategoriPostList> {
  PagingController<int, PostModel> pageController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    AppCubit.get(context).initState(pagingController: pageController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is GetCategoryPostsSuccessState) {
          pageController.refresh();
        }
        return PagedListView<int, PostModel>.separated(
          physics: widget.physics,
          shrinkWrap: widget.shrinkWrap,
          pagingController: pageController,
          builderDelegate: PagedChildBuilderDelegate<PostModel>(
            itemBuilder: (context, item, index) =>
                buildNewsItem(model: item, context: context),
          ),
          separatorBuilder: (context, index) => myDivider(),
        );
      },
    );
  }
}
