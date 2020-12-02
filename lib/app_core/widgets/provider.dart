import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class Provider extends InheritedWidget {
  final GetIt data;

  Provider({
    Key key,
    Widget child,
    this.data,
  }) : super(key: key, child: child);

  static GetIt of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>()).data;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }
}

extension ProviderExtension<T> on BuildContext {
  T use<T>() => Provider.of(this)<T>();
}

// context.use<PrefsService>();
