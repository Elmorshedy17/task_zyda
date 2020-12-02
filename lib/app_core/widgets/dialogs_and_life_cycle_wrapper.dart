import 'package:flutter/material.dart';
// import 'package:m1/features/ads/sign_up_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../app_core.dart';

class DialogsAndLifeCycleWrapper extends StatefulWidget {
  final Widget child;

  const DialogsAndLifeCycleWrapper({Key key, this.child}) : super(key: key);
  @override
  _DialogsAndLifeCycleWrapperState createState() =>
      _DialogsAndLifeCycleWrapperState();
}

class _DialogsAndLifeCycleWrapperState
    extends State<DialogsAndLifeCycleWrapper> {
  final DialogService _dialogService = locator<DialogService>();
  final DialogsManager _dialogsManager = locator<DialogsManager>();
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogs('1', _showDialog1);
    // _dialogService.registerDialogs('test', _showDialog);
    _dialogService.registerDialogs('errorDialog', _erorrDialog);
    _dialogService.registerDialogs('apiError', _apiErorr);
    _dialogService.registerDialogs('connectionError', _connectionError);
    // _dialogService.registerDialogs('2', _showDialog2);
  }

  @override
  Widget build(BuildContext context) {
    final loadingManager = context.use<LoadingManager>();

    return StreamBuilder(
        initialData: false,
        stream: loadingManager.loading$,
        builder: (context, loadingSnapshot) {
          return loadingSnapshot.data
              ? Stack(
                  children: [
                    widget.child,
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.black12.withOpacity(0.3),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                )
              : widget.child;
        });
  }

  void _showDialog1(DialogRequest request) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        _navigationService.dialogContext = dialogContext;

        return CustomDialog(
          title: request.title,
          description: request.description,
          imageUrl: 'assets/images/wifi.gif',
          // imageUrl: 'assets/images/wrong.gif',
          onClickConfirmBtn: () {
            _dialogService.dialogComplete(DialogResponse(isConfirmed: true));
            _dialogsManager.isDialogShown = false;
          },
          onClickCancelBtn: () {
            _dialogService.dialogComplete(DialogResponse(isConfirmed: false));
            _dialogsManager.isDialogShown = false;
          },
        );
      },
    );
  }

  void _erorrDialog(DialogRequest request) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        _navigationService.dialogContext = dialogContext;

        return CustomDialog(
          titleColor: Colors.red,
          title: request.title,
          description: request.description,
          // imageUrl: 'assets/images/wifi.gif',
          imageUrl: 'assets/images/wrong.gif',
          onClickConfirmBtn: () {
            _dialogService.dialogComplete(DialogResponse(isConfirmed: true));
            _dialogsManager.isDialogShown = false;
            _navigationService.pushNamedTo('/SignInPage');
          },
          onClickCancelBtn: () {
            _dialogService.dialogComplete(DialogResponse(isConfirmed: false));
            _dialogsManager.isDialogShown = false;
          },
        );
      },
    );
  }

  void _apiErorr(DialogRequest request) {
    showDialog(
      context: context,
      // barrierDismissible: false,
      builder: (dialogContext) {
        _navigationService.dialogContext = dialogContext;

        return CustomDialog(
          titleColor: Colors.red,
          title: request.title,
          description: request.description,
          // imageUrl: 'assets/images/wifi.gif',
          imageUrl: 'assets/images/wrong.gif',
          onClickConfirmBtn: () {
            _dialogService.dialogComplete(DialogResponse(isConfirmed: true));
            _dialogsManager.isDialogShown = false;
          },
        );
      },
    );
  }

  // connectionErrorDialog
  void _connectionError(DialogRequest request) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        _navigationService.dialogContext = dialogContext;
        return CustomDialog(
          titleColor: Colors.red,
          title: request.title,
          description: request.description,
          imageUrl: 'assets/images/wifi.gif',
          // imageUrl: 'assets/images/wrong.gif',
          onClickConfirmBtn: () {
            _dialogService.dialogComplete(DialogResponse(isConfirmed: true));
            _dialogsManager.isDialogShown = false;
            // Navigator.of(context).pop();
            // _navigationService.back();
          },
        );
      },
    );
  }

  // void _showDialog(DialogRequest request) {
  //   Alert(
  //       context: context,
  //       title: "FilledStacks",
  //       desc: "My tutorials show realworld structures.",
  //       closeFunction: () =>
  //           _dialogService.dialogComplete(DialogResponse(isConfirmed: false)),
  //       buttons: [
  //         DialogButton(
  //           child: Text('Ok'),
  //           onPressed: () {
  //             _dialogService.dialogComplete(DialogResponse(isConfirmed: true));
  //             Navigator.of(context).pop();
  //           },
  //         )
  //       ]).show();
  // }
}

///////////////////////////////////////////////////////////////////////////////
/// Custom alert dialog.
/// ///////////////////////////////////////////////////////////////////////////
class CustomDialog extends StatelessWidget {
  final String title, description, confirmBtnTxt, cancelBtnTxt, imageUrl;
  final Function onClickConfirmBtn, onClickCancelBtn;
  final Color titleColor, descriptionColor, confirmBtnColor, cancelBtnColor;

  const CustomDialog({
    Key key,
    this.title,
    this.description,
    this.confirmBtnTxt = 'Ok',
    this.cancelBtnTxt = 'Cancel',
    this.imageUrl,
    this.onClickConfirmBtn,
    this.onClickCancelBtn,
    this.titleColor = Colors.black,
    this.descriptionColor = Colors.black,
    this.confirmBtnColor = Colors.grey,
    this.cancelBtnColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(
            top: imageUrl != null ? 100 : 30,
            bottom: 16,
            left: 16,
            right: 16,
          ),
          margin: EdgeInsets.only(
            top: 16,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(17),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              title != null
                  ? Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: titleColor,
                      ),
                    )
                  : Container(),
              SizedBox(
                height: title != null ? 16 : 0,
              ),
              description != null
                  ? Text(
                      description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: descriptionColor,
                      ),
                    )
                  : Container(),
              SizedBox(
                height: description != null ? 24 : 0,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RaisedButton(
                      color: confirmBtnColor,
                      child: Text(confirmBtnTxt),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: onClickConfirmBtn,
                    ),
                    SizedBox(
                      width: onClickCancelBtn != null ? 50 : 0,
                    ),
                    onClickCancelBtn != null
                        ? RaisedButton(
                            color: cancelBtnColor,
                            child: Text(cancelBtnTxt),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            onPressed: onClickCancelBtn,
                          )
                        : Container()
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 16,
          right: 16,
          child: imageUrl != null
              ? CircleAvatar(
                  // backgroundColor: Colors.white,
                  // foregroundColor: Colors.white,
                  // backgroundImage: AssetImage(imageUrl),
                  radius: 50,
                  child: ClipOval(
                    child: Image.asset(
                      imageUrl,
                      // fit: BoxFit.fill,
                    ),
                  ),
                )
              : Container(),
        ),
      ],
    );
  }
}
