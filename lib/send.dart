import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> sendPushNotifications(String message) async {
  final url = Uri.parse('https://api.onesignal.com/notifications');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Basic ZTc2MzM2ZDktYTc0Ni00MzE2LWIzZWMtNjA3OTM2YTg3MWZj',
    'Host': 'api.onesignal.com',
    'Connection': 'close',
    'Content-Length': '213'
  };

  final Map<String, dynamic> body = {
    'app_id': 'd193e059-6051-4b7a-b25d-c71ca26ae84e',
    "contents": {
      "en": "Hello, World",
      "es": "Hola Mundo",
      "fr": "Bonjour le monde",
      "zh-Hans": "\u4f60\u597d\u4e16\u754c"
    },
    "target_channel": "push",
    "included_segments": ["All Subscribers"]
  };

  final response =
      await http.post(url, headers: headers, body: jsonEncode(body));

  if (response.statusCode == 200) {
    print('Notification sent successfully .');
  } else {
    print('Failed to send notification: ${response.body}');
  }
}
