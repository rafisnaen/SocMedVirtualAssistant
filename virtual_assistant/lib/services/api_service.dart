import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:5000'; // Ganti IP kalau di Android device

  static Future<String> fetchTranscript() async {
    final response = await http.get(Uri.parse('$baseUrl/api/speech-to-text'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['transcript'] ?? '';
    } else {
      return '[Error getting transcript]';
    }
  }

  static Future<String> askGemini(String prompt) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/chat'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'prompt': prompt}),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['response'] ?? '';
    } else {
      return '[Error getting Gemini response]';
    }
  }
}
