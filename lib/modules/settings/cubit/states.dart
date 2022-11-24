abstract class SettingsStates {}

class SettingsInitialState extends SettingsStates {}

class ChangeThemeState extends SettingsStates {}

class ChangeFontSizeState extends SettingsStates {}

class LogOutLoadingState extends SettingsStates {}
class LogOutSuccessState extends SettingsStates {}
class LogOutErrorState extends SettingsStates {
  final String error;

  LogOutErrorState(this.error);
}
