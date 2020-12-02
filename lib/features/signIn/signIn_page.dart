import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:m1/app_core/app_core.dart';
import 'package:m1/features/signIn/RqSignIn.dart';
import 'package:m1/features/signIn/signIn_repo.dart';
import 'package:m1/features/signIn/sign_in_manager.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _autoValidate = false;

  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();

  String _password = '';
  String _email = '';
  final SignInRepo signInRepo = SignInRepo();
  @override
  Widget build(BuildContext context) {
    var toast = context.use<ToastTemplate>();
    var dialogManager = context.use<DialogsManager>();
    var navigationService = context.use<NavigationService>();

    return WillPopScope(
      onWillPop: () async {
        toast.show("I'm Here!");
        if (dialogManager?.isDialogShown ?? false) {
          toast.show('1 isDialogShow ${dialogManager.isDialogShown}');
          dialogManager.isDialogShown = false;
          Navigator.of(navigationService.dialogContext).pop();

          return false;
        } else {
          toast.show('2 isDialogShow ${dialogManager.isDialogShown}');
          return true;
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          child: Container(
            // height: MediaQuery.of(context).size.height * 1.15,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                // Positioned(
                //   top: 0.0,
                //   left: 0.0,
                //   right: 0.0,
                //   child: Container(
                //     height: MediaQuery.of(context).size.height * 0.35,
                //     width: MediaQuery.of(context).size.width,
                //     child: Image.asset(
                //       AppAssets.login_en,
                //       fit: BoxFit.fill,
                //     ),
                //   ),
                // ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.05,
                  left: 0.0,
                  right: 0.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Welcome',
                          // AppLocalizations.of(context)
                          //     .translate('Welcome_str'),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 35),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            'to fawtara',
                            // AppLocalizations.of(context)
                            //     .translate('toFawtara_str'),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.2,
                  left: 30.0,
                  right: 30.0,
                  bottom: 0.0,
                  // child: SingleChildScrollView(
                  //   // padding: EdgeInsets.symmetric(horizontal: 40),
                  //   physics: BouncingScrollPhysics(),
                  child: ListView(
                    children: <Widget>[
                      // FittedBox(
                      //   child:
                      Container(
                        child: Card(
                          color: Colors.grey[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(25.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                              key: _formKey,
                              autovalidate: _autoValidate,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 8.0,
                                      top: 25,
                                      left: 8.0,
                                      bottom: 8.0,
                                    ),
                                    child: Text(
                                      'SignIn',
                                      // AppLocalizations.of(context)
                                      //     .translate('SignIn_str'),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: ListTile(
                                      title: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              right: 8.0,
                                              left: 8.0,
                                              bottom: 8.0,
                                            ),
                                            child: Icon(
                                              Icons.email,
                                              size: 20,
                                              color: Colors.grey[800],
                                            ),
                                          ),
                                          Text(
                                            'email',
                                            // AppLocalizations.of(context)
                                            //     .translate('Email_str'),
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                      subtitle: Container(
                                        height: 50,
                                        child: TextFormField(
                                          maxLines: 1,
                                          scrollPhysics:
                                              BouncingScrollPhysics(),
                                          onFieldSubmitted: (v) {
                                            FocusScope.of(context)
                                                .requestFocus(passwordFocus);
                                          },
                                          // validator: (value) {
                                          //   if (value.isEmpty) {
                                          //     return AppLocalizations.of(
                                          //             context)
                                          //         .translate(
                                          //             '*required_str');
                                          //   } else if (!EmailValidator
                                          //       .validate(value)) {
                                          //     return AppLocalizations.of(
                                          //             context)
                                          //         .translate(
                                          //             'EnterAValidEmail_str');
                                          //   }
                                          // return null;
                                          // },
                                          onChanged: (value) {
                                            if (value.isNotEmpty) {
                                              _email = value;
                                            } else {
                                              _email = '';
                                            }
                                          },
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                              isDense: true,
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0),
                                                ),
                                                borderSide: BorderSide(
                                                  color: Colors.grey[50],
                                                ),
                                              ),
                                              filled: true,
                                              fillColor: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: ListTile(
                                      title: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              right: 8.0,
                                              left: 8.0,
                                              bottom: 8.0,
                                            ),
                                            child: Icon(
                                              Icons.lock,
                                              size: 20,
                                              color: Colors.grey[800],
                                            ),
                                          ),
                                          Text(
                                            'password',
                                            // AppLocalizations.of(context)
                                            //     .translate('Password_str'),
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                      subtitle: Container(
                                        height: 50,
                                        child: TextFormField(
                                          focusNode: passwordFocus,
                                          obscureText: true,
                                          // validator: (value) {
                                          //   if (value.isEmpty) {
                                          //     return AppLocalizations.of(
                                          //             context)
                                          //         .translate(
                                          //             '*required_str');
                                          //   } else if (value.length < 3) {
                                          //     return AppLocalizations.of(
                                          //             context)
                                          //         .translate(
                                          //             'PasswordMustBe3CharacterAtLeast_str');
                                          //   }
                                          //   return null;
                                          // },
                                          onChanged: (value) {
                                            if (value.isNotEmpty) {
                                              _password = value;
                                            } else {
                                              _password = '';
                                            }
                                          },
                                          decoration: InputDecoration(
                                              isDense: true,
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0),
                                                ),
                                                borderSide: BorderSide(
                                                  color: Colors.grey[50],
                                                ),
                                              ),
                                              filled: true,
                                              fillColor: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    height: 45,
                                    child: RaisedButton(
                                      color: Colors.blue[900],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                      ),
                                      child: Text(
                                        'LogIn',
                                        // AppLocalizations.of(context)
                                        //     .translate('Login_str'),
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      onPressed: () async {
                                        // FocusScope.of(context)
                                        //     .requestFocus(FocusNode());
                                        // if (_formKey.currentState.validate()) {
                                        //   // If all data are correct then save data to out variables
                                        //   _formKey.currentState.save();
                                        // } else {
                                        //   // If all data are not valid then start auto validation.
                                        //   setState(() {
                                        //     _autoValidate = true;
                                        //   });
                                        context.use<SignInManager>().getFuture(
                                            request: RqSignIn(
                                                email: 'user@fawtara.com',
                                                password: '123456'));
                                        // await signInRepo
                                        //     .apiPost(RqSignIn(
                                        //         email: 'user@fawtara.com',
                                        //         password: '123456'))
                                        //     .then((value) {
                                        //   if (value.status == 1) {
                                        //     toast.show(
                                        //         'SignIn Value ${value.status}');
                                        //   } else if (value.status == 0) {
                                        //     toast.show(
                                        //         'SignIn Value ${value.status}');
                                        //   } else {
                                        //     print('xXx ${value.error}');
                                        //     if (value.error.error
                                        //         is SocketException) {
                                        //       showDialog(
                                        //         context: context,
                                        //         builder: (BuildContext context) {
                                        //           return AlertDialog(
                                        //             title: Text(
                                        //                 'No Internet Connection'),
                                        //           );
                                        //         },
                                        //       );
                                        //     } else {
                                        //       showDialog(
                                        //         context: context,
                                        //         builder: (BuildContext context) {
                                        //           return AlertDialog(
                                        //             title: Text(
                                        //                 'Some thing went Wrong Try again later'),
                                        //           );
                                        //         },
                                        //       );
                                        //     }
                                        //   }
                                        // });
                                        // }
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  RaisedButton(onPressed: () {
                                    // context.use<DialogsManager>().showDialog(
                                    //     'errorDialog',
                                    //     DialogRequest(title: 'xxx'));

                                    final DialogsManager _dialogsManager =
                                        locator<DialogsManager>();
                                    _dialogsManager.showDialog(
                                        'connectionError',
                                        DialogRequest(
                                            description:
                                                'No internet connection, check yor connection and try again.'));
                                  })
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // ),
                      SizedBox(
                        height: 20,
                      ),

                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  // ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
