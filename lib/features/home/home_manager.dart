import 'package:m1/app_core/app_core.dart';
import 'package:m1/features/home/home_data.dart';
import 'package:m1/features/home/home_repo.dart';
import 'package:rxdart/rxdart.dart';

class HomeManger extends Manager<HomeData> {
  final adsRepo = HomeRepo();

  final BehaviorSubject<ApiResponse<HomeData>> _adsSubject =
      BehaviorSubject<ApiResponse<HomeData>>();

  final  tabs = BehaviorSubject();

  @override
  Stream<ApiResponse<HomeData>> getStream() {
    Stream.fromFuture(adsRepo.apiGet()).listen((result) {
      result.error == null
          ? _adsSubject.add(result)
          : _adsSubject.addError(result.error);
    });
    return _adsSubject.stream;
  }

  @override
  void dispose() {
    _adsSubject.close();
    tabs.close();
  }
}
