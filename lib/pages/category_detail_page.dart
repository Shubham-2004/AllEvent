import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class CategoryDetailPage extends StatelessWidget {
  final String url;

  CategoryDetailPage({required this.url});

  Future<List<Map<String, dynamic>>> fetchData() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (jsonData is Map && jsonData.containsKey('item')) {
        // Extract the "item" list from the JSON data
        return List<Map<String, dynamic>>.from(jsonData['item']);
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
                final eventName = item['eventname'] ?? 'No Event Name';
                final eventUrl = item['event_url'] ?? '';
                return GestureDetector(
                  onTap: () {
                    if (eventUrl.isNotEmpty) {
                      _launchURL(eventUrl);
                    }
                  },
                  child: Card(
                    margin: EdgeInsets.all(10),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(eventName),
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

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
