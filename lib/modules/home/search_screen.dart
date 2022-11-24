import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:news_app/shared/styles/colors.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';
import '../news_details/news_details_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  defaultFormField(
                    type: TextInputType.text,
                    autofocus: true,
                    controller: searchController,
                    label: 'بحث',
                    onSubmit: (value) {
                      print(value);
                      cubit.getSearch(value);
                    },
                    prefix: Icons.search_outlined,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  state is SearchLoadingState
                      ? const Center(
                          child: CircularProgressIndicator(
                            backgroundColor: defaultColorGrey,
                            color: defaultColorBlack,
                          ),
                        )
                      : cubit.searchResults.isEmpty
                          ? Container()
                          : Expanded(
                              child: ListView.separated(
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () => navigateTo(
                                      context,
                                      NewsDetailsScreen(
                                        id: cubit.searchResults[index].id ??
                                            1,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Html(
                                            data: cubit.searchResults[index]
                                                    .title ??
                                                '',
                                            style: {
                                              'body': Style(
                                                fontSize: FontSize.large,
                                                fontWeight: FontWeight.w600,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .color,
                                                letterSpacing: -0.03,
                                                maxLines: 2,
                                                textOverflow:
                                                    TextOverflow.ellipsis,
                                                margin: Margins.zero,
                                              ),
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    myDivider(),
                                itemCount: cubit.searchResults.length,
                              ),
                            ),
                ],
              ),
            ),
          );
        });
  }
}
