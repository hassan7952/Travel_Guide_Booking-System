import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

void loadMockData() async {
  String jsonString = await rootBundle.loadString('assets/guides.json');
  List<dynamic> guides = jsonDecode(jsonString);
  // ... rest of the code to parse JSON into Guide objects ...
}
