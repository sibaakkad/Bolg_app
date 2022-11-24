import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:news_app/modules/settings/cubit/cubit.dart';
import 'package:news_app/modules/settings/cubit/states.dart';
import 'package:news_app/modules/userProfile/user_profile.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/network/local/chache_helper.dart';
import 'package:news_app/shared/styles/colors.dart';
import 'package:html/dom.dart' as dom;
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/constants.dart';
import '../web_view/web_view_screen.dart';
import 'package:html/parser.dart' as htmlparser;

class NewsDetailsScreen extends StatelessWidget {
  final int id;

  NewsDetailsScreen({
    super.key,
    required this.id,
  });


  var scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    
    return BlocProvider.value(
      value: BlocProvider.of<AppCubit>(context)..getPostDetails(id),
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = AppCubit.get(context);
            if (cubit.favoriteList.any((item) => item == id.toString())) {
              cubit.isLiked = true;
            } else {
              cubit.isLiked = false;
            }
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
              ),
              body: state is! LoadingPostDetailsState
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          children: [
                            defualtImage(
                              height: 214,
                              width: double.infinity,
                              imageUrl: cubit.postDetails!.embedded
                                          ?.wpFeaturedmedia?.isNotEmpty ??
                                      false
                                  ? cubit
                                          .postDetails!
                                          .embedded
                                          ?.wpFeaturedmedia
                                          ?.first
                                          .mediaDetails
                                          ?.sizes
                                          ?.full
                                          ?.sourceUrl ??
                                      ''
                                  : '',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Html(
                              data: cubit.postDetails!.title?.rendered,
                              style: {
                                'body': Style(
                                  fontSize: FontSize(20),
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                  letterSpacing: -0.03,
                                  maxLines: 2,
                                  textOverflow: TextOverflow.ellipsis,
                                ),
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            InkWell(
                              onTap: () {
                                navigateTo(
                                    context,
                                    UserProfile(
                                      id: cubit.postDetails?.author?.id ?? 0,
                                    ));
                              },
                              child: Row(
                                children: [
                                  defualtImage(
                                      height: 32,
                                      width: 32,
                                      borderRadius: 50,
                                      imageUrl:
                                          cubit.postDetails!.author?.avatar ??
                                              ''),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Text(
                                      'osid',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    DateFormat.yMd()
                                        .format(cubit.postDetails!.date!),
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      color: defaultColorGrey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            myDivider(verticalPadding: 16),
                            getIndex(
                              data: cubit.postDetails!.content!.rendered,
                              context: context,
                            ),
                            getContent(
                                data: cubit.postDetails!.content!.rendered,
                                context2: context),
                          ],
                        ),
                      ),
                    )
                  : defualtLoading(),
              bottomNavigationBar: state is! LoadingPostDetailsState
                  ? Container(
                      color: Theme.of(context)
                          .bottomNavigationBarTheme
                          .backgroundColor,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      // decoration: const BoxDecoration(
                      //   color: defaultColorWhite,
                      // ),
                      height: 78,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              cubit.saveArticle();
                            },
                            icon: SvgPicture.asset(
                              myIcons['BookMark']!,
                              color: cubit.isSaved
                                  ? Theme.of(context).iconTheme.color
                                  : null,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              cubit.addToFav(id.toString());
                            },
                            icon: SvgPicture.asset(
                              myIcons['Favorite']!,
                              color: cubit.isLiked
                                  ? Theme.of(context).iconTheme.color
                                  : null,
                            ),
                          ),
                          const Spacer(),
                          PopupMenuButton<int>(
                            color: Theme.of(context)
                                .bottomNavigationBarTheme
                                .backgroundColor,
                            // onSelected: (value) => cubit.openSettings(),
                            // onCanceled: () => cubit.openSettings(),
                            icon: SvgPicture.asset(
                              myIcons['Dot']!,
                              color: cubit.isOpenSettings
                                  ? Theme.of(context).iconTheme.color
                                  : null,
                            ),
                            offset: const Offset(0, -60),
                            itemBuilder: (context) => [
                              // popupmenu item 1
                              PopupMenuItem(
                                value: 1,
                                onTap: () {
                                  cubit.share(cubit.postDetails!.link ?? '');
                                },
                                // row has two child icon and text.
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.share,
                                      color: defaultColorGrey,
                                    ),
                                    const SizedBox(
                                      // sized box with width 10
                                      width: 10,
                                    ),
                                    Text(
                                      "مشاركة الصفحة",
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : null,
            );
          }),
    );
  }

  Map<String, dynamic> headersStyles(String header) {
    Map<String, dynamic> headersStyle;
    switch (header) {
      case 'h1':
        return headersStyle = {
          'fontWeight': FontWeight.w800,
          'padding': 0.0,
        };

      case 'h2':
        return headersStyle = {
          'fontWeight': FontWeight.w700,
          'padding': 16.0,
        };

      case 'h3':
        return headersStyle = {
          'fontWeight': FontWeight.w500,
          'padding': 32.0,
        };

      case 'h4':
        return headersStyle = {
          'fontWeight': FontWeight.w500,
          'padding': 48.0,
        };

      case 'h5':
        return headersStyle = {
          'fontWeight': FontWeight.w500,
          'padding': 64.0,
        };

      case 'h6':
        return headersStyle = {
          'fontWeight': FontWeight.w400,
          'padding': 80.0,
        };
    }
    return headersStyle = {
      'fontWeight': FontWeight.w500,
      'padding': 80.0,
    };
  }

  Widget getIndex({required data, BuildContext? context}) {
    dom.Document? document = htmlparser.parse(data);
    var index = document.getElementsByTagName('h1, h2, h3, h4, h5, h6');
    // ThemeMode = CacheHelper().();
    int themeNumber = CacheHelper.getData(key: 'theme') ?? 0;
    // ThemeMode? themeData = convertToThemeMode(themeNumber);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: themeNumber == 1
            ? const Color.fromARGB(255, 219, 232, 243)
            : defaultColorBlue,

        // color: const Color.fromARGB(255, 219, 232, 243),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpansionTile(
            title: Text(
              'المحتوى',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: Theme.of(context!).textTheme.bodyText1!.color,
              ),
            ),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            children: index.map((e) {
              var style = headersStyles(e.localName!);
              return Padding(
                padding: EdgeInsets.only(right: style['padding'], bottom: 4),
                child: Text(
                  e.text,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: style['fontWeight'],
                    color: themeNumber == 1
                        ? defaultColorBlue
                        : const Color.fromARGB(255, 219, 232, 243),
                    letterSpacing: -0.03,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget getContent({required data, required context2}) =>
      BlocConsumer<SettingCubit, SettingsStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          var cubit = SettingCubit.get(context);
          return Html(
              data: data,
              style: {
                '*': Style(
                  fontSize: FontSize(cubit.fontSize!),
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).textTheme.bodyText1!.color,
                  letterSpacing: -0.03,
                  textAlign: TextAlign.start,

                  //  color: const Color.fromRGBO(160, 160, 161, 1),
                ),
                '.toc.mt-5.mt-lg-0': Style(
                  display: Display.none,
                ),
                'a': Style(
                  color: defaultColorBlue,
                ),
                'script+ p': Style(
                  padding: EdgeInsets.zero,
                  margin: Margins.zero,
                ),
                'h1,h2,h3,h4,h5,h6': Style(
                  fontSize: FontSize(cubit.fontSize! + 2),
                  color: defaultColorBlue,
                  fontWeight: FontWeight.w700,
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  //margin: Margins.symmetric(horizontal: 0),
                ),
              },
              onLinkTap: (url, context, attributes, element) {
                navigateTo(context2, WebViewScreen(url!));
              });
        },
      );

}
