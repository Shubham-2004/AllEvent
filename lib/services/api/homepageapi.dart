import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePageApi {
  static Future<http.Response?> fetchEvents() async {
    try {
      final response = await http
          .get(Uri.parse("https://allevents.s3.amazonaws.com/tests/all.json"));
      if (response.statusCode == 200) {
        return response;
      } else {
        print('Failed to load events. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error during API call: $e');
      return null;
    }
  }

  static Future<List<Map<String, String>>> fetchCategories() async {
    List<Map<String, String>> predefinedCategories = [
      {
        "category": "all",
        "data": "https://allevents.s3.amazonaws.com/tests/all.json"
      },
      {
        "category": "music",
        "data": "https://allevents.s3.amazonaws.com/tests/music.json"
      },
      {
        "category": "business",
        "data": "https://allevents.s3.amazonaws.com/tests/business.json"
      },
      {
        "category": "sports",
        "data": "https://allevents.s3.amazonaws.com/tests/sports.json"
      },
      {
        "category": "workshops",
        "data": "https://allevents.s3.amazonaws.com/tests/workshops.json"
      }
    ];
    return predefinedCategories;
  }
}
