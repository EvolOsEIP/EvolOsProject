import 'dart:convert';
import 'package:http/http.dart' as http;

class EmailService {
  final String apiUrl;

  EmailService({this.apiUrl = 'http://127.0.0.1:5000/send-email'});

  Future<String> sendEmail({
    required String recipient,
    required String subject,
    required String body,
  }) async {
    final emailData = {
      'recipient': recipient.trim(),
      'subject': subject.trim(),
      'body': body.trim(),
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: json.encode(emailData),
      );

      if (response.statusCode == 200) {
        return 'Email sent successfully!';
      } else {
        return 'Error: ${response.body}';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
}