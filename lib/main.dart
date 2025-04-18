import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';
import 'screens/login_screen.dart';

final Logger _logger = Logger();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  _logger.i('Mensagem recebida em segundo plano: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    _logger.i('Firebase inicializado com sucesso!');
    runApp(const MyApp());
  } catch (e, stackTrace) {
    _logger.e('Erro ao inicializar o Firebase: $e\nStack trace: $stackTrace');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}