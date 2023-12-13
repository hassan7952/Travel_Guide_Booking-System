import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> fetchRecommendations() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:5000'));

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    print(data['recommendations']);
    // Update your UI with the received data
  } else {
    throw Exception('Failed to load recommendations');
  }
}
