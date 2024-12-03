import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_app/core/app_theme.dart';
import 'package:flutter_chat_app/firebase_options.dart';
import 'package:flutter_chat_app/providers/auth_providers.dart';
import 'package:flutter_chat_app/providers/chat_provider.dart';
import 'package:flutter_chat_app/providers/user_provider.dart';
import 'package:flutter_chat_app/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.debug,
      appleProvider: AppleProvider.appAttest,
    );
  } catch (e) {
    debugPrint('Firebase initialization failed: $e');
  }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProviders(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              padding: const EdgeInsets.symmetric(vertical: 32),
            ),
            child: child!,
          );
        },
        home: const WelcomeScreen(),
      ),
    );
  }
}
