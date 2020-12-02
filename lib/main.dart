import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:m1/app_core/widgets/dialogs_and_life_cycle_wrapper.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:m1/features/home/home_page.dart';
import 'package:m1/features/sign_up/sign_up_screen.dart';
import 'app_core/app_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // await DotEnv().load('.env');
    await setupLocator().then(
      (_) async {
        AppLanguageManager appLanguage = locator<AppLanguageManager>();
        await appLanguage.fetchLocale();
        await SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitUp]);
        runApp(
          Root(
            locator: locator,
            child: MyApp(),
          ),
        );
      },
    );
  } catch (error) {
    print("error $error");
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    super.initState();
    ////////////////////////////////////////////////////////////////////////////
    //! PushNotification
    //locator<PushNotificationService>().initialize();
    ////////////////////////////////////////////////////////////////////////////
    //! LocalNotification
    //locator<LocalNotificationService>().initializeLocalNotification();
    ////////////////////////////////////////////////////////////////////////////
  }

  @override
  Widget build(BuildContext context) {
    final langManager = Provider.of(context)<AppLanguageManager>();
    final navigationService = context.use<NavigationService>();
    var toast = context.use<ToastTemplate>();
    var dialogManager = context.use<DialogsManager>();
    return StreamBuilder<Locale>(
        initialData: Locale('en'),
        stream: langManager.locale$,
        builder: (context, localeSnapshot) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Restaurant Finder',
            builder: (context, widget) => Navigator(
              onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => DialogsAndLifeCycleWrapper(
                  child: widget,
                ),
              ),
            ),
            navigatorKey: navigationService.navigatorKey,
            theme: ThemeData(
              primarySwatch: Colors.red,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            locale: localeSnapshot.data,
            supportedLocales: [
              Locale('en', 'US'),
              Locale('ar', ''),
            ],
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            home: WillPopScope(
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
                child: SignUpPage()),
                // child: SignUpPage()),
            routes: {
              // '/AdsScreen': (_) => AdsScreen(),
              // '/SignInPage': (_) => SignInPage(),
            },
          );
        });
  }
}
