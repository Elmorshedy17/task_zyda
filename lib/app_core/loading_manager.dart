import 'package:rxdart/rxdart.dart';

import 'app_core.dart';

class LoadingManager extends Manager {
  final PublishSubject<bool> _loadingSubject = PublishSubject<bool>();
  Stream<bool> get loading$ => _loadingSubject.stream;
  // Sink<bool> get inLoading => _loadingSubject.sink;

  void startLoading() {
    _loadingSubject.sink.add(true);
  }

  void endLoading() {
    _loadingSubject.sink.add(false);
  }

  @override
  void dispose() {
    _loadingSubject.close();
  }
}
