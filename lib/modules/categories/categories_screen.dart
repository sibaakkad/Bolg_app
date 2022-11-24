import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/categories/postsByCategoryId.dart';
import 'package:news_app/shared/components/components.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/styles/colors.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          // cubit.categoriIdFromUi;
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 70,
              title: defualtappBar(title: 'التصنيفات'),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  cubit.categories != null
                      ? SizedBox(
                          height: 90.0,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: cubit.categories?.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (cubit.categories![index].id ==
                                  cubit.categoriIdFromUi) {
                                return categoryItem(
                                    function: () {
                                      cubit.changeCategoriId(
                                          cubit.categories![index].id ?? 0);
                                    },
                                    textColor: defaultColorWhite,
                                    background: defaultColorBlue,
                                    text:
                                        cubit.categories?[index].name ?? 'null',
                                    boxShadowStatus: false);
                              } else {
                                return categoryItem(
                                    function: () {
                                      cubit.changeCategoriId(
                                          cubit.categories![index].id ?? 0);
                                    },
                                    textColor:
                                        const Color.fromRGBO(159, 159, 160, 1),
                                    background: defaultColorWhite,
                                    text:
                                        cubit.categories?[index].name ?? 'null',
                                    boxShadowStatus: true);
                              }
                            },
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: defualtLoading(),
                        ),

                  const Expanded(
                    child: CategoriPostList(
                      shrinkWrap: false,
                      physics: BouncingScrollPhysics(),
                    ),
                  ),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     firstButtonStatus
                  //         ? defaultButton2(
                  //             function: () {
                  //               // setState(() {
                  //               //   firstButtonStatus = false;
                  //               //   secondButtonStatus = true;
                  //               //   thirdButtonStatus = true;
                  //               // });
                  //             },
                  //             text: 'All')
                  //         : defaultButton2(
                  //             function: () {},
                  //             background: defaultColorBlack,
                  //             textColor: defaultColorWhite,
                  //             text: 'All',
                  //           ),
                  //     const SizedBox(
                  //       width: 22,
                  //     ),
                  //     secondButtonStatus
                  //         ? defaultButton2(
                  //             function: () {
                  //               // setState(() {
                  //               //   firstButtonStatus = true;
                  //               //   secondButtonStatus = false;
                  //               //   thirdButtonStatus = true;
                  //               // });
                  //             },
                  //             text: 'Design')
                  //         : defaultButton2(
                  //             function: () {},
                  //             background: defaultColorBlack,
                  //             textColor: defaultColorWhite,
                  //             text: 'Design',
                  //           ),
                  //     // defaultButton2(function: () {}, text: 'Design'),
                  //     const SizedBox(
                  //       width: 22,
                  //     ),
                  //     // defaultButton2(function: () {}, text: 'History'),
                  //     thirdButtonStatus
                  //         ? defaultButton2(
                  //             function: () {
                  //               // setState(() {
                  //               //   firstButtonStatus = true;
                  //               //   secondButtonStatus = true;
                  //               //   thirdButtonStatus = false;
                  //               // });
                  //             },
                  //             text: 'History')
                  //         : defaultButton2(
                  //             function: () {},
                  //             background: defaultColorBlack,
                  //             textColor: defaultColorWhite,
                  //             text: 'History',
                  //           ),
                  //   ],
                  // ),
                  // if (isClicked!) {
                  //   textColor =
                  //       const Color.fromRGBO(159, 159, 160, 1);
                  //   background = defaultColorWhite;
                  //   boxShadowStatus = true;
                  // } else {
                  //   textColor = defaultColorWhite;
                  //   background = defaultColorBlack;
                  //   boxShadowStatus = false;
                  // }
                ],
              ),
            ),
          );
        });
  }

  Widget categoryItem({
    double? width,
    Color background = defaultColorWhite,
    Color? textColor = const Color.fromRGBO(159, 159, 160, 1),
    double radius = 32.0,
    required Function()? function,
    required String text,
    bool boxShadowStatus = true,
  }) {
    return Center(
      child: Container(
        width: width,
        height: 42.0,
        margin: const EdgeInsets.only(left: 22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            radius,
          ),
          boxShadow: boxShadowStatus
              ? const [
                  BoxShadow(
                      color: Color.fromRGBO(23, 58, 110, 0.01),
                      blurRadius: 20,
                      offset: Offset(0, 2)),
                  BoxShadow(
                      color: Color.fromRGBO(20, 18, 103, 0.03),
                      blurRadius: 18,
                      offset: Offset(0, 29))
                ]
              : [],
          color: background,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            child: InkWell(
              onTap: function,
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
