import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EventItem extends StatelessWidget {
  final dynamic event;

  EventItem({required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [Colors.blueAccent, Colors.lightBlue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  event['thumb_url'],
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              event['eventname'],
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 5),
            Text('Location: ${event['location']}',
                style: TextStyle(color: Colors.black)),
            Text('Start: ${event['start_time_display']}',
                style: TextStyle(color: Colors.black)),
            Text('End: ${event['end_time_display']}',
                style: TextStyle(color: Colors.black)),
            ElevatedButton(
              onPressed: () async {
                final url = event['event_url'];
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  print('Could not launch $url');
                }
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
              child:
                  Text('More Details', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
