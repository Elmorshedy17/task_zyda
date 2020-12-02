import 'package:get_it/get_it.dart';
import 'package:m1/features/home/home_manager.dart';
import 'package:m1/features/signIn/sign_in_manager.dart';
import 'package:m1/features/sign_up/sign_up_manager.dart';

import 'app_core.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  /// Setup PrefsService.
  var instance = await PrefsService.getInstance();
  locator.registerSingleton<PrefsService>(instance);

  /// AppLanguageManager
  locator.registerLazySingleton<AppLanguageManager>(() => AppLanguageManager());

  /// NavigationService
  locator.registerLazySingleton<NavigationService>(() => NavigationService());

  /// ConnectionCheckerService
  // locator.registerLazySingleton<ConnectionCheckerManager>(
  //     () => ConnectionCheckerManager());

  /// LoadingManager
  locator.registerLazySingleton<LoadingManager>(() => LoadingManager());

  /// ApiService
  locator.registerLazySingleton<ApiService>(() => ApiService());

  /// ToastTemplate
  locator.registerLazySingleton<ToastTemplate>(() => ToastTemplate());

  /// DialogService
  locator.registerLazySingleton<DialogService>(() => DialogService());

  /// AppDialogsManager
  locator.registerLazySingleton<DialogsManager>(() => DialogsManager());

  /// HomeManger
  locator.registerLazySingleton<SignUpManager>(() => SignUpManager());

  ///SignInManager
  locator.registerLazySingleton<SignInManager>(() => SignInManager());
  locator.registerLazySingleton<HomeManger>(() => HomeManger());
}
