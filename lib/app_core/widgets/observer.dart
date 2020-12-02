import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import '../app_core.dart';

typedef _OnSuccessFunction<T> = Widget Function(BuildContext context, T data);
typedef _OnErrorFunction = Widget Function(BuildContext context, Object error);
typedef _OnWaitingFunction = Widget Function(BuildContext context);

class Observer<T> extends StatelessWidget {
  final Stream<T> stream;

  final _OnSuccessFunction<T> onSuccess;
  final _OnWaitingFunction onWaiting;
  final _OnErrorFunction onError;
  final Manager manager;

  const Observer({
    Key key,
    @required this.manager,
    @required this.stream,
    @required this.onSuccess,
    this.onWaiting,
    this.onError,
  })  : assert(stream != null && onSuccess != null),
        super(key: key);

  Function get _defaultOnWaiting =>
      (context) => Center(child: CircularProgressIndicator());
  Function get _defaultOnError => (context, error) {
        String errorMsg;
        if (error.error is SocketException) {
          errorMsg = 'No Internet Connection';
        } else {
          errorMsg = 'Some Thing Went Wrong Try Again Later';
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.broken_image_outlined,
              size: 100,
            ),
            Icon(
              Icons.wifi_off,
              size: 100,
            ),
            Center(
              child: Text(
                errorMsg,
                style: TextStyle(fontSize: 20),
              ),
            ),
            RaisedButton(
              onPressed: () async {
                manager.getStream();
                locator<LoadingManager>().startLoading();
                await Future.delayed(Duration(milliseconds: 2500), () {
                  locator<LoadingManager>().endLoading();
                });
              },
            ),
          ],
        );
      };

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, AsyncSnapshot<T> snapshot) {
        if (snapshot.hasError) {
          return (onError != null)
              ? onError(context, snapshot.error)
              : _defaultOnError(context, snapshot.error);
        }

        if (snapshot.hasData) {
          T data = snapshot.data;
          return onSuccess(context, data);
        } else {
          return (onWaiting != null)
              ? onWaiting(context)
              : _defaultOnWaiting(context);
        }
      },
    );
  }
}
