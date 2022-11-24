import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shimmer/shimmer.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../models/posts_model.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';
import '../news_details/news_details_screen.dart';

class StickyPosts extends StatelessWidget {
  const StickyPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return cubit.stickyPosts != null
              ? SizedBox(
                  height: 260,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => buildPopularListItem(
                      context: context,
                      model: cubit.stickyPosts![index],
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 24.0,
                    ),
                    itemCount: cubit.stickyPosts!.length,
                  ),
                )
              : SizedBox(
                  height: 260,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return loadingBuildPopularListItem();
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 24.0,
                    ),
                    itemCount: 3,
                  ),
                );
        });
  }

  Widget buildPopularListItem({required context, required PostModel? model}) =>
      InkWell(
        onTap: () {
          navigateTo(
            context,
            NewsDetailsScreen(id: model?.id ?? 0),
          );
        },
        child: SizedBox(
          width: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              defualtImage(
                height: 164.0,
                imageUrl: model?.embedded?.wpFeaturedmedia?.isNotEmpty ?? false
                    ? model?.embedded?.wpFeaturedmedia?.first.mediaDetails
                            ?.sizes?.singlePost?.sourceUrl ??
                        ''
                    : '',
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                model?.author?.fullname ?? '',
                style: const TextStyle(
                  color: defaultColorGrey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              // Text(
              //   model?.title?.rendered ?? '',
              //   style: const TextStyle(
              //     fontSize: 24,
              // ),
              Html(
                data: model?.title?.rendered ?? '',
                style: {
                  'body': Style(
                    fontSize: FontSize(18),
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                    letterSpacing: -1,
                    maxLines: 2,
                    //margin: Margins.zero,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                },
              ),
            ],
          ),
        ),
      );
}

Widget loadingBuildPopularListItem() => Shimmer.fromColors(
      baseColor: const Color.fromRGBO(196, 196, 196, 1),
      highlightColor: defaultColorWhite,
      child: SizedBox(
        width: 130,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 164.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: defaultColorWhite,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              height: 25,
              width: 73,
              color: defaultColorWhite,
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              height: 30,
              width: 120,
              color: defaultColorWhite,
            ),
          ],
        ),
      ),
    );
