import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:allevent/services/api/homepageapi.dart';

class HomePageLogic extends ChangeNotifier {
  PageController _pageController = PageController(viewportFraction: 0.3);
  int _currentPage = 0;
  Timer? _timer;
  bool isGridView = false; // State variable to track the view mode

  String stringResponse = '';
  Map<String, dynamic> mapResponse = {};
  List<dynamic> categories = [];
  List<dynamic> events = [];
  List<dynamic> filter = [];

  TextEditingController searchController = TextEditingController();
  bool get isTyping => searchController.text.isNotEmpty;

  HomePageLogic() {
    apicall();
    fetchCategories();

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

  Future<void> apicall() async {
    try {
      final response = await HomePageApi.fetchEvents();
      if (response != null) {
        stringResponse = response.body;
        mapResponse = json.decode(response.body);
        events = mapResponse['item'];
        notifyListeners(); // Notify listeners after updating the state
      }
    } catch (e) {
      print('Error during API call: $e');
    }
  }

  Future<void> fetchCategories() async {
    try {
      final predefinedCategories = await HomePageApi.fetchCategories();
      categories = predefinedCategories;
      notifyListeners();
    } catch (e) {
      print('Error during category fetch: $e');
    }
  }

  void filterd(String query) {
    filter = events
        .where((item) =>
            item['eventname'].toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void toggleView() {
    isGridView = !isGridView;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }
}
