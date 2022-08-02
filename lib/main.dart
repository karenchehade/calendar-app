import 'package:app/pages/event_editing.dart';
import 'package:app/pages/event_viewing.dart';
import 'package:app/pages/forgot_password_page.dart';
import 'package:app/pages/welcome_page.dart';
import 'package:app/provider/event_provider.dart';
import 'package:app/theme.dart';
import 'package:app/utils.dart';
import 'package:app/widget/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class Routes {
  static const String welcome = '/welcome';
  static const String home = '/home';
  static const String edit = '/edit';
  static const String view = '/view';
  static const String forgotPass = '/forgoPass';
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeNotifier>(create: (_) => ThemeNotifier()),
          ChangeNotifierProvider<EventProvider>(create: (_) => EventProvider()),
        ],
        child: Consumer<ThemeNotifier>(
            builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            scaffoldMessengerKey: Utils.messengerKey,
            navigatorKey: navigatorKey,
            title: 'calendar',
            debugShowCheckedModeBanner: false,
            theme: notifier.isDarkTheme ? dark : light,
            home: const WelcomePage(),
            routes: {
              Routes.welcome: (BuildContext context) => const WelcomePage(),
              Routes.home: (BuildContext context) => const Home(),
              Routes.edit: (BuildContext context) => const EventEditingPage(),
              Routes.view: (BuildContext context) => const EventViewingPage(),
              Routes.forgotPass : (BuildContext context) => ForgotPasswordPage(),
            },
          );
        }),
      );
}
