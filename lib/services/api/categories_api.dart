import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoriesApi {
  static Future<List<Map<String, String>>> fetchCategories() async {
    final List<Map<String, String>> categoryUrls = [
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
      },
    ];

    List<Map<String, String>> categoriesData = [];
    for (var categoryUrl in categoryUrls) {
      final response = await http.get(Uri.parse(categoryUrl['data']!));
      if (response.statusCode == 200) {
        categoriesData.add({
          "category": categoryUrl['category']!,
          "data": categoryUrl['data']!,
        });
      }
    }
    return categoriesData;
  }
}
