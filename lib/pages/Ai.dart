import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(AiHistoricalEvent());
}

class AiHistoricalEvent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Historical Event Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HistoricalEventSearchPage(),
    );
  }
}

class HistoricalEventSearchPage extends StatefulWidget {
  @override
  _HistoricalEventSearchPageState createState() =>
      _HistoricalEventSearchPageState();
}

class _HistoricalEventSearchPageState extends State<HistoricalEventSearchPage> {
  final TextEditingController _textController = TextEditingController();
  List<Map<String, dynamic>> _events = [];

  Future<void> _searchEvents(String text) async {
    final url = Uri.parse(
        "https://historical-events-by-api-ninjas.p.rapidapi.com/v1/historicalevents");
    final queryParameters = {
      "text": text,
    };
    final headers = {
      "X-RapidAPI-Key": "cddc497c61msha056b75bbe92f88p1c3834jsn007efcd6ece0",
      "X-RapidAPI-Host": "historical-events-by-api-ninjas.p.rapidapi.com"
    };

    final response = await http
        .get(url.replace(queryParameters: queryParameters), headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _events = List<Map<String, dynamic>>.from(data);
      });
    } else {
      setState(() {
        _events = [];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.statusCode}')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Search Ai'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200], // Setting background color
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: 'Enter Text',
                  filled: true,
                  fillColor: Colors.white, // Input field background color
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _searchEvents(_textController.text);
                },
                child: Text('Search'),
              ),
              SizedBox(height: 20),
              Expanded(
                child: _events.isNotEmpty
                    ? ListView.builder(
                        itemCount: _events.length,
                        itemBuilder: (context, index) {
                          final event = _events[index];
                          return ListTile(
                            leading: CircleAvatar(
                              child: Text('${index + 1}'),
                            ),
                            title: Text(event['event']),
                            subtitle: Text('Year: ${event['year']}'),
                          );
                        },
                      )
                    : Center(child: Text('No events found')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
