import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:rive_learning/firebase_options.dart";
import "package:rive_learning/rive_app/services/auth/auth_gate.dart";
import "package:rive_learning/rive_app/services/auth/auth_service.dart";
import "package:rive_learning/rive_app/services/notification_message/notification_service.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService().initNotifications();
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rive Learning',
      theme: ThemeData(primarySwatch: Colors.blue),
      // home: Scaffold(body: Center(child: MultiBoardListExample())),
      home: AuthGate(),
    );
  }
}
