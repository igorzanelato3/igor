import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logger/logger.dart'; // Ensure this import is correct and the logger package is added to pubspec.yaml

class NotificationService {
  final String serverKey = 'K0Qt7ie0C3-shKlgtoh54Yt9P9iZifp8fHJ37zop14c';
  final Logger _logger = Logger();

  Future<void> sendNotification(String token, String title, String body) async {
    final Uri url = Uri.parse('https://fcm.googleapis.com/fcm/send');
    final Map<String, dynamic> notification = {
      'notification': {
        'title': title,
        'body': body,
      },
      'to': token,
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
        body: jsonEncode(notification),
      );

      if (response.statusCode == 200) {
        _logger.i('Notificação enviada com sucesso: ${response.body}');
      } else {
        _logger.e('Erro ao enviar notificação: ${response.body}');
      }
    } catch (e) {
      _logger.e('Erro ao enviar notificação: $e');
    }
  }
}