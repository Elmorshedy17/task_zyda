import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  BuildContext dialogContext;

  Future<dynamic> pushNamedTo(String routeName, {Object arguments}) {
    return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamedTo(String routeName, {Object arguments}) {
    return navigatorKey.currentState
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  void goBack() {
    navigatorKey.currentState.pop();
  }
}
