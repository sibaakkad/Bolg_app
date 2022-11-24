import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/models/author_info_model.dart';
import 'package:news_app/models/search_model.dart';
import 'package:news_app/shared/network/local/chache_helper.dart';

import '../../models/categories_model.dart';
import '../../models/posts_model.dart';
import '../../modules/categories/categories_screen.dart';
import '../../modules/favorites/favorites_screen.dart';
import '../../modules/home/home_screen.dart';
import '../../modules/settings/settings_screen.dart';
import '../../shared/network/remote/dio_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  static const kPageSize = 5;

  int currentIndex = 0;
  bool isLiked = false;
  bool isSaved = false;
  bool isOpenSettings = false;
  List<String> favoriteList = [];

  List<Widget> bottomScreens = [
    const HomeScreen(),
    const FavoritesScreen(),
    const CategoriesScreen(),
    const SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavState());
  }

  void getfavoriteList() {
    if (CacheHelper.getStringList(key: 'favorite') == null) {
      favoriteList = [];
    } else {
      favoriteList = CacheHelper.getStringList(key: 'favorite');
      debugPrint('favoriteList: $favoriteList');
      favoriteList.isNotEmpty
          ? getfavoritePosts()
          : print('no items in favorite');
    }
  }

  void addToFav(String id) {
    isLiked = !isLiked;
    if (isLiked) {
      favoriteList.add(id);
    } else {
      CacheHelper.removeData(key: 'favorite');
      favoriteList = favoriteList.where((element) => element != id).toList();
    }
    CacheHelper.setStringList(key: 'favorite', value: favoriteList);
    getfavoriteList();
    emit(AddOrRemoveFromFav());
  }

  void saveArticle() {
    isSaved = !isSaved;
    emit(AppChangeBottomNavState());
  }

  void openSettings() {
    isOpenSettings = !isOpenSettings;
    emit(AppChangeBottomNavState());
  }

  List<PostModel>? favoritePosts;
  void getfavoritePosts() {
    emit(LoadingFavoritePostsDataState());
    DioHelper.getData(
      url: 'wp-json/wp/v2/posts?_embed',
      query: {
        'include': favoriteList.join(','),
      },
    ).then((value) {
      print('----------------------------');
      List lst;
      if (value.data.runtimeType == String) {
        lst = jsonDecode(value.data);
      } else {
        lst = value.data;
      }

      favoritePosts = lst.map((x) => PostModel.fromJson(x)).toList();
      emit(GetFavoriteSuccessState());
    }).catchError((error) {
      print('********************************');
      print(error.toString());
      emit(GetFavoritePostsErrorState());
    });
  }

  List<PostModel>? posts;
  Future<List<PostModel>?> getPostsData(
      {int pageNo = 1,
      int? pageSize = 5,
      int? categoriId,
      int? authorID}) async {
    emit(LoadingPostsDataState());
    Map<String, dynamic>? queryData;
    if (categoriId != null) {
      queryData = {
        'page': '$pageNo',
        'per_page': '$pageSize',
        'categories': '$categoriId',
      };
    } else if (authorID != null) {
      queryData = {
        'page': '$pageNo',
        'per_page': '$pageSize',
        'author': '$authorID',
      };
    } else {
      queryData = {
        'page': '$pageNo',
        'per_page': '$pageSize',
      };
    }
    var res = await DioHelper.getData(
      url: 'wp-json/wp/v2/posts?_embed',
      query: queryData,
    );

    try {
      if (res.statusCode != 200) throw 'no data';
      print('-------------getPostsData---------------');
      List lst;
      if (res.data.runtimeType == String) {
        lst = jsonDecode(res.data);
      } else {
        lst = res.data;
      }

      posts = lst.map((x) => PostModel.fromJson(x)).toList();

      emit(GetPostsSuccessState());
      return posts!;
    } catch (err) {
      print('********************************');
      print(err.toString());
      emit(GetPostsErrorState());
      return [];
    }
  }

  List<PostModel>? stickyPosts;
  void getstickyPostsData() {
    emit(LoadingStickyPostsDataState());
    DioHelper.getData(
      url: 'wp-json/wp/v2/posts?_embed',
      query: {
        'sticky': 'true',
      },
    ).then((value) {
      print('----------------------------');
      List lst;
      if (value.data.runtimeType == String) {
        lst = jsonDecode(value.data);
      } else {
        lst = value.data;
      }

      stickyPosts = lst.map((x) => PostModel.fromJson(x)).toList();
      emit(GetStickyPostsSuccessState());
    }).catchError((error) {
      print('********************************');
      print(error.toString());
      emit(GetStickyPostsErrorState());
    });
  }

  List<CategoryModel>? categories;
  void getCategories() {
    emit(GetCategoriesLoadingState());

    DioHelper.getData(
      url: 'wp-json/wp/v2/categories',
      query: {
        '_fields': 'id,name,count',
      },
    ).then((value) {
      print('----------------------------');
      List lst;
      if (value.data.runtimeType == String) {
        lst = jsonDecode(value.data);
      } else {
        lst = value.data;
      }

      categories = lst.map((x) => CategoryModel.fromJson(x)).toList();

      emit(GetCategoriesSuccessState());
    }).catchError((error) {
      print('********************************');
      print(error.toString());
      emit(GetCategoriesErrorState());
    });
  }

  List<SearchModel> searchResults = [];
  void getSearch(String searchData) {
    emit(SearchLoadingState());
    DioHelper.getData(
      url: 'wp-json/wp/v2/search',
      query: {
        'search': searchData,
        '_fields': 'id,title',
        'subtype': 'post',
      },
    ).then((value) {
      print('----------------------------');
      List lst;
      if (value.data.runtimeType == String) {
        lst = jsonDecode(value.data);
      } else {
        lst = value.data;
      }

      searchResults = lst.map((x) => SearchModel.fromJson(x)).toList();
      emit(SearchSuccessState());
    }).catchError((error) {
      print('********************************');
      print(error.toString());
      emit(SearchErrorState());
    });
  }

  PostModel? postDetails;
  Future<void> getPostDetails(int id) async {
    emit(LoadingPostDetailsState());
    DioHelper.getData(
      url: 'wp-json/wp/v2/posts/$id?_embed',
    ).then((value) {
      print('----------------------------');
      Map<String, dynamic> lst;
      if (value.data.runtimeType == String) {
        lst = jsonDecode(value.data);
      } else {
        lst = value.data;
      }
      postDetails = PostModel.fromJson(lst);
      emit(PostDetailsSuccessState());
    }).catchError((error) {
      print('********************************');
      print(error.toString());
      emit(PostDetailsErrorState());
    });
  }

  AuthorInfoModel? authorInfo;
  int? authorID;
  Future<void> getAuthorInfo(int id) async {
    authorID = id;
    emit(LoadingAuthorInfoState());
    DioHelper.getData(
      url: 'wp-json/wp/v2/users/$id',
    ).then((value) {
      print('----------------------------');
      Map<String, dynamic> lst;
      if (value.data.runtimeType == String) {
        lst = jsonDecode(value.data);
      } else {
        lst = value.data;
      }
      authorInfo = AuthorInfoModel.fromJson(lst);
      emit(AuthorInfoSuccessState());
    }).catchError((error) {
      print('********************************');
      print(error.toString());
      emit(AuthorInfoErrorState());
    });
  }

  Future<void> _fetchPage(
      {int? pageKey,
      dynamic? pagingController,
      int? categoriId,
      int? authorID}) async {
    try {
      print("this is category is : $categoriId");
      debugPrint('authorID: $authorID');
      final newItems = await getPostsData(
          pageNo: pageKey!,
          pageSize: kPageSize,
          categoriId: categoriId,
          authorID: authorID);
      debugPrint('pageKey: $pageKey');
      final isLastPage = newItems!.length < kPageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      debugPrint('error: $error');
      pagingController.error = error;
    }
  }

  int? categoriIdFromUi;
  void changeCategoriId(int categoriId) {
    categoriIdFromUi = categoriId;
    emit(GetCategoryPostsSuccessState());
  }

  // int? stickyState;
  // void changestickyState(int stickyState) {
  //   categoriIdFromUi = stickyState;
  // }

  void initState({required pagingController}) {
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(
        pageKey: pageKey,
        pagingController: pagingController,
        categoriId: categoriIdFromUi,
        authorID: authorID,
      );
    });

    // void initState({required pagingController, int? categoriId, pageKey}) {
    //   print("********herre************$pageKey");
    //   _fetchPage(
    //     pageKey: pageKey,
    //     pagingController: pagingController,
    //     categoriId: categoriId,
    //   );
    // }
    // bool isDisposed = false;
    // void dispose(pagingController) {
    //   pagingController.close();
    //   isDisposed = true;
    // }
    // bool isDisposed = false;
    // void dispose(pagingController) {
    //   pagingController.close();
    //   isDisposed = true;
    // }
  }

  Future<void> share(String url) async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: url,
        chooserTitle: 'Example Chooser Title');
  }
}
