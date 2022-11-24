import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/states.dart';

import 'package:news_app/shared/components/components.dart';
import 'package:shimmer/shimmer.dart';

import '../../layout/cubit/cubit.dart';
import '../../shared/styles/colors.dart';
import '../categories/postsByCategoryId.dart';

class UserProfile extends StatelessWidget {
  final int id;
  const UserProfile({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: AppCubit.get(context)..getAuthorInfo(id),
      // create: (BuildContext context) => AppCubit()..getAuthorInfo(id),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);

          debugPrint('id: $id');
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back)),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: state is! LoadingAuthorInfoState
                  ? SingleChildScrollView(
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            defualtImage(
                              height: 120,
                              width: 120,
                              borderRadius: 60,
                              imageUrl: cubit.authorInfo?.meta?.avatar ?? '',
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flag.fromString(
                                    cubit.authorInfo!.meta!.country ?? '',
                                    height: 25,
                                    width: 25),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: Text(
                                    cubit.authorInfo?.name ?? '',
                                    style: TextStyle(
                                      fontSize: 32.0,
                                      fontWeight: FontWeight.w700,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color,
                                      letterSpacing: 1,
                                    ),
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.email,
                                  color: defaultColorGrey,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  cubit.authorInfo?.meta?.email ?? '',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: defaultColorGrey),
                                ),
                              ],
                            ),
                            myDivider(verticalPadding: 16),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        cubit.authorInfo?.meta?.followersCount
                                                .toString() ??
                                            '',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color,
                                        ),
                                      ),
                                      const Text(
                                        'المتابعين',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: defaultColorGrey),
                                      ),
                                      myDivider(
                                          verticalPadding: 0,
                                          horizontalPadding: 10),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        cubit.authorInfo?.meta?.followingCount
                                                .toString() ??
                                            '',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color,
                                        ),
                                      ),
                                      const Text(
                                        'يتابع',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: defaultColorGrey),
                                      ),
                                      myDivider(
                                          verticalPadding: 0,
                                          horizontalPadding: 10),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        cubit.authorInfo?.meta?.points
                                                .toString() ??
                                            '',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color,
                                        ),
                                      ),
                                      const Text(
                                        'النقاط',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: defaultColorGrey),
                                      ),
                                      myDivider(
                                          verticalPadding: 0,
                                          horizontalPadding: 10),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ' النبذة الشخصية',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color,
                                    ),
                                  ),
                                  myDivider(verticalPadding: 10, width: 200),
                                  Text(
                                    cubit.authorInfo?.description ?? '',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: defaultColorGrey,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'مقالات الكاتب',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color,
                                    ),
                                  ),
                                  myDivider(verticalPadding: 16, width: 200),
                                ],
                              ),
                            ),
                            const CategoriPostList(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                            )
                          ],
                        ),
                      ),
                    )
                  : Shimmer.fromColors(
                      baseColor: const Color.fromRGBO(196, 196, 196, 1),
                      highlightColor: defaultColorWhite,
                      child: SingleChildScrollView(
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              defualtImage(
                                height: 120,
                                width: 120,
                                borderRadius: 60,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 250,
                                    height: 25,
                                    color: defaultColorWhite,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 250,
                                    height: 25,
                                    color: defaultColorWhite,
                                  ),
                                ],
                              ),
                              myDivider(verticalPadding: 16),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 75,
                                          height: 25,
                                          color: defaultColorWhite,
                                        ),
                                        const Text(
                                          'المتابعين',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: defaultColorGrey),
                                        ),
                                        myDivider(
                                            verticalPadding: 0,
                                            horizontalPadding: 10),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 75,
                                          height: 25,
                                          color: defaultColorWhite,
                                        ),
                                        const Text(
                                          'يتابع',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: defaultColorGrey),
                                        ),
                                        myDivider(
                                            verticalPadding: 0,
                                            horizontalPadding: 10),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 75,
                                          height: 25,
                                          color: defaultColorWhite,
                                        ),
                                        const Text(
                                          'النقاط',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: defaultColorGrey),
                                        ),
                                        myDivider(
                                            verticalPadding: 0,
                                            horizontalPadding: 10),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ' النبذة الشخصية',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color,
                                      ),
                                    ),
                                    myDivider(verticalPadding: 10, width: 200),
                                    Container(
                                      width: double.infinity,
                                      height: 100,
                                      color: defaultColorWhite,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'مقالات الكاتب',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color,
                                      ),
                                    ),
                                    myDivider(verticalPadding: 16, width: 200),
                                  ],
                                ),
                              ),
                              loadingBuildNewsItem(),
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
