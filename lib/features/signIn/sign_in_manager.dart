import 'dart:io';

import 'package:m1/app_core/app_core.dart';
import 'package:m1/features/signIn/signIn_data.dart';
import 'package:m1/features/signIn/signIn_repo.dart';

class SignInManager extends Manager<SignInData> {
  final SignInRepo _signInRepo = SignInRepo();
  final NavigationService _navigationService = locator<NavigationService>();
  final LoadingManager _loadingManager = locator<LoadingManager>();
  final DialogsManager _dialogsManager = locator<DialogsManager>();

  @override
  void getFuture({ApiRequest request}) async {
    _loadingManager.startLoading();
    await _signInRepo.apiPost(request).then((result) {
      if (result.status == 1) {
        print('xXx ${result.status}');
        _loadingManager.endLoading();
        _navigationService.pushReplacementNamedTo('/AdsScreen');
      } else if (result.status == 0) {
        print('xXx ${result.status}');
        _loadingManager.endLoading();
      } else if (result.error.error is SocketException) {
        print('xXx ${result.error.error}');
        _loadingManager.endLoading();
        _dialogsManager.showDialog(
            'connectionError',
            DialogRequest(
                description:
                    'No internet connection, check yor connection and try again.'));
      } else {
        _loadingManager.endLoading();
        _dialogsManager.showDialog(
            'apiError',
            DialogRequest(
                description: 'Some thing went wrong, try again later.'));
      }
    });
    _loadingManager.endLoading();
  }

  @override
  void dispose() {}
}
