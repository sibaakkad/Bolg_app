abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeBottomNavState extends AppStates {}

// class AppChangeColorBottomNavState extends AppStates {}

class GetCategoriesLoadingState extends AppStates {}

class GetCategoriesSuccessState extends AppStates {}

class GetCategoryPostsSuccessState extends AppStates {}

class GetCategoriesErrorState extends AppStates {}

class LoadingPostsDataState extends AppStates {}

class GetPostsSuccessState extends AppStates {}

class GetPostsErrorState extends AppStates {}

class LoadingStickyPostsDataState extends AppStates {}

class GetStickyPostsSuccessState extends AppStates {}

class GetStickyPostsErrorState extends AppStates {}

class LoadingPostDetailsState extends AppStates {}

class PostDetailsSuccessState extends AppStates {}

class PostDetailsErrorState extends AppStates {}

class SearchLoadingState extends AppStates {}

class SearchSuccessState extends AppStates {}

class SearchErrorState extends AppStates {}

class LoadingFavoritePostsDataState extends AppStates {}

class GetFavoriteSuccessState extends AppStates {}

class GetFavoritePostsErrorState extends AppStates {}

class LoadingAuthorInfoState extends AppStates {}

class AuthorInfoSuccessState extends AppStates {}

class AuthorInfoErrorState extends AppStates {}

class AddOrRemoveFromFav extends AppStates {}
class SaveAuthorIDState extends AppStates {}