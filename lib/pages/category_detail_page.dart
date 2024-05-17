import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryDetailPage extends StatelessWidget {
  final String url;

  CategoryDetailPage({required this.url});

  Future<List<Map<String, dynamic>>> fetchData() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (jsonData is List) {
        // If the JSON is a list, cast it to a list of maps
        return List<Map<String, dynamic>>.from(jsonData);
      } else if (jsonData is Map) {
        // If the JSON is a map, wrap it in a list
        return [];
      } else {
        throw Exception('Unexpected JSON format');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category Details'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            final data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: item.entries.map<Widget>((entry) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text('${entry.key}: ${entry.value}'),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
