import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase/screens/splash_screen/splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_dart_admin_auth_sdk/firebase_dart_admin_auth_sdk.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    if (kIsWeb) {
      // Initialize for web
      debugPrint('Initializing Firebase for Web...');
      FirebaseApp.initializeAppWithEnvironmentVariables(
        apiKey: 'YOUR_API_KEY', // 'YOUR_API_KEY'
        authdomain: 'YOUR_AUTH_DOMAIN', // 'YOUR_AUTH_DOMAIN'
        projectId: 'YOUR_PROJECT_ID', // 'YOUR_PROJECT_ID'
        messagingSenderId: 'YOUR_SENDER_ID', // 'YOUR_SENDER_ID'
        bucketName: 'YOUR_BUCKET_NAME', // 'YOUR_BUCKET_NAME'
        appId: 'YOUR_APP_ID', // 'YOUR_APP_ID'
      );
      debugPrint('Firebase initialized for Web.');
    } else {
      if (Platform.isAndroid || Platform.isIOS) {
        debugPrint('Initializing Firebase for Mobile...');

        // Load the service account JSON
        String serviceAccountContent = await rootBundle.loadString(
          'assets/service_account.json',
        );
        debugPrint('Service account loaded.');

        // Initialize Firebase with the service account content
        await FirebaseApp.initializeAppWithServiceAccount(
          serviceAccountContent: serviceAccountContent,
        );
        debugPrint('Firebase initialized for Mobile.');

        // Uncomment to use service account impersonation if needed
        /*
        await FirebaseApp.initializeAppWithServiceAccountImpersonation(
          impersonatedEmail: 'impersonatedEmail',
          serviceAccountContent: serviceAccountContent,
        );
        debugPrint('Firebase initialized with service account impersonation.');
        */
      }
    }

    // Access Firebase Auth instance
    final auth = FirebaseApp.instance.getAuth();
    debugPrint('Firebase Auth instance obtained.');

    runApp(const MyApp());
  } catch (e, stackTrace) {
    debugPrint('Error initializing Firebase: $e');
    debugPrint('StackTrace: $stackTrace');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth Admin Demo',
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
