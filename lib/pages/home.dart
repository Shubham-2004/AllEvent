import 'package:allevent/pages/Ai.dart';
import 'package:allevent/pages/Category.dart';
import 'package:allevent/pages/Wallet.dart';
import 'package:allevent/services/auth/loginorregister.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AllEvents',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

String stringResponse = '';
Map<String, dynamic> mapResponse = {};
List<dynamic> categories = [];
List<dynamic> events = [];

class _HomeState extends State<Home> {
  PageController _pageController = PageController(viewportFraction: 0.3);
  int _currentPage = 0;
  Timer? _timer;
  bool isGridView = false; // State variable to track the view mode

  Future<void> apicall() async {
    try {
      http.Response response;
      response = await http.get(
          Uri.parse("https://allevents.s3.amazonaws.com/tests/music.json"));
      if (response.statusCode == 200) {
        setState(() {
          stringResponse = response.body;
          mapResponse = json.decode(response.body);
          events = mapResponse['item'];
        });
      } else {
        print('Failed to load events. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during API call: $e');
    }
  }

  Future<void> fetchCategories() async {
    try {
      http.Response response;
      response = await http.get(Uri.parse(
          "https://allevents.s3.amazonaws.com/tests/categories.json"));
      if (response.statusCode == 200) {
        setState(() {
          categories = json.decode(response.body)['categories'];
        });
      } else {
        print('Failed to load categories. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during category fetch: $e');
    }
  }

  @override
  void initState() {
    apicall();
    fetchCategories();
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
        if (_currentPage < (categories.length - 1)) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }

        if (_pageController.hasClients) {
          _pageController.animateToPage(
            _currentPage,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  // Predefined category icons
  final Map<String, IconData> categoryIcons = {
    'Music': Icons.music_note,
    'Sports': Icons.sports,
    'Art': Icons.brush,
    'Technology': Icons.computer,
    'Health': Icons.health_and_safety,
    'Education': Icons.school,
    // Add more categories and icons as needed
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AllEvents'),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(isGridView ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              setState(() {
                isGridView = !isGridView;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
              onBackgroundImageError: (exception, stackTrace) {
                // Handle image loading error
              },
              child: Icon(Icons.person),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'AllEvents',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.event),
              title: Text('Events'),
              onTap: () {
                // Handle navigation to events
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: Text('Categories'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CategoriesPage()),
                );
                // Handle navigation to categories
              },
            ),
            ListTile(
              leading: Icon(Icons.wallet),
              title: Text('Wallet'),
              onTap: () {
                // Handle navigation to categories
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WalletPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.event),
              title: Text('EventAi'),
              onTap: () {
                // Handle navigation to categories
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HistoricalEventSearchPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginorRegister()),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Categories',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  categories.isNotEmpty
                      ? isGridView
                          ? GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 3,
                              ),
                              itemCount: categories.length,
                              itemBuilder: (context, index) {
                                var category = categories[index];
                                return CategoryItem(
                                  category: category,
                                  icon: categoryIcons[category['name']] ??
                                      Icons
                                          .category, // Default icon if not found
                                );
                              },
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: categories.length,
                              itemBuilder: (context, index) {
                                var category = categories[index];
                                return CategoryItem(
                                  category: category,
                                  icon: categoryIcons[category['name']] ??
                                      Icons
                                          .category, // Default icon if not found
                                );
                              },
                            )
                      : CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text(
                    'Events',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  events.isNotEmpty
                      ? isGridView
                          ? GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 0.75,
                              ),
                              itemCount: events.length,
                              itemBuilder: (context, index) {
                                var event = events[index];
                                return EventItem(event: event);
                              },
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: events.length,
                              itemBuilder: (context, index) {
                                var event = events[index];
                                return EventItem(event: event);
                              },
                            )
                      : CircularProgressIndicator(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final dynamic category;
  final IconData icon;

  CategoryItem({required this.category, required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to category's webpage
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryPage(category: category),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 10),
            Text(
              category['name'],
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryPage extends StatelessWidget {
  final dynamic category;

  CategoryPage({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category['name']),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Text('Welcome to the ${category['name']} category!'),
      ),
    );
  }
}

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

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About AllEvents'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About AllEvents',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent),
            ),
            SizedBox(height: 10),
            Text(
              'AllEvents is your one-stop solution for discovering all kinds of events happening around you. '
              'Whether you are interested in music, sports, art, technology, health, or education, we have got you covered. '
              'Our platform provides comprehensive details about each event, including location, time, and ticket information. '
              'Stay updated and never miss out on your favorite events!',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Contact Us',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent),
            ),
            SizedBox(height: 10),
            Text(
              'Email: support@allevents.com',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Phone: +123 456 7890',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
