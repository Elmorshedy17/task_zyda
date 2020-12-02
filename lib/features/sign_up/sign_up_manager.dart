import 'package:m1/app_core/app_core.dart';
import 'package:rxdart/rxdart.dart';

class SignUpManager extends Manager {
  // final adsRepo = AdsRepo();
  // final BehaviorSubject<ApiResponse<AdsData>> _adsSubject =
  //     BehaviorSubject<ApiResponse<AdsData>>();

  final  tabs = BehaviorSubject();
  //
  // @override
  // Stream<ApiResponse<AdsData>> getStream() {
  //   Stream.fromFuture(adsRepo.apiGet()).listen((result) {
  //     result.error == null
  //         ? _adsSubject.add(result)
  //         : _adsSubject.addError(result.error);
  //   });
  //   return _adsSubject.stream;
  // }

  @override
  void dispose() {
    // _adsSubject.close();
    tabs.close();
  }
}
