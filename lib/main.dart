import 'dart:async';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sentry/sentry.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:mycustomers/ui/theme/theme_viewmodel.dart';
import 'app/local_setup.dart';
import 'package:oktoast/oktoast.dart';
import 'app/locator.dart';
import 'app/router.dart';
import 'core/managers/core_manager.dart';
import 'core/utils/logger.dart';

final SentryClient _sentry = SentryClient(
    dsn:
        "https://96fa259faede4385a21bd53f3985f836@o417686.ingest.sentry.io/5318792");

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // This captures errors reported by the Flutter framework.
  FlutterError.onError = (FlutterErrorDetails details) async {
    if (isInDebugMode) {
      // In development mode simply print to console.
      FlutterError.dumpErrorToConsole(details);
    } else {
      // In production mode report to the application zone to report to
      // Sentry.
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };

  runZonedGuarded<Future<void>>(() async {
    setupLogger(
        sentryClient: SentryClient(
            dsn:
                "https://96fa259faede4385a21bd53f3985f836@o417686.ingest.sentry.io/5318792"));
    await setupLocator();
    
   runApp(App());
     runApp(
       DevicePreview(
         onScreenshot: (screenshot) {
           final bytes = screenshot.bytes;
           //  Send the bytes to a drive, to the file system, to
           // the device gallery for example. It may be useful for
           // preparing your app release for example.
         },
         enabled: !kReleaseMode,
         builder: (context) => App(),
       ),
     );
  }, (error, stackTrace) {
    // Whenever an error occurs, call the `_reportError` function. This sends
    // Dart errors to the dev console or Sentry depending on the environment.
    _reportError(error, stackTrace);
  });
}

bool get isInDebugMode {
  // Assume you're in production mode.
  bool inDebugMode = false;

  // Assert expressions are only evaluated during development. They are ignored
  // in production. Therefore, this code only sets `inDebugMode` to true
  // in a development environment.
  assert(inDebugMode = true);

  return inDebugMode;
}

Future<void> _reportError(dynamic error, dynamic stackTrace) async {
  // Print the exception to the console.
  print('Caught error: $error');
  if (isInDebugMode) {
    // Print the full stacktrace in debug mode.
    print(stackTrace);
  } else {
    // Send the Exception and Stacktrace to Sentry in Production mode.
    _sentry.captureException(
      exception: error,
      stackTrace: stackTrace,
    );
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //    /*
    //   1. Setup for screenutil, only needed once here
    //   2. screen resolution (in px) according to phone screen
    //   3. Import screen util to all views
    //   4. use in this manner E.g Container(width: 50.w, height:200.h)
    //   */
    //   ScreenUtil.init(context, width: width, height: height, allowFontScaling: true);

    // Status bar
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        // statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp
    // ]); // Settting preferred Screen Orientation
    return CoreManager(
      child: ViewModelBuilder<SettingManagerModel>.reactive(
        builder: (_, viewModel, ___) => OKToast(
          child: MyApp(
              viewModel: viewModel,
            ),
        ),
        viewModelBuilder: () => SettingManagerModel(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key key, this.viewModel,
  }) : super(key: key);
  final SettingManagerModel viewModel;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: DevicePreview.appBuilder,
      theme: viewModel.theme,
      locale: viewModel.locale,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales,
      localeResolutionCallback: loadSupportedLocals,
      initialRoute: Routes.startupViewRoute,
      onGenerateRoute: Router().onGenerateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
    );
  }

}
