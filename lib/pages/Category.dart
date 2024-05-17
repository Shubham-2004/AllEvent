import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'category_detail_page.dart'; // Import the new page

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<CategoryItem> categories = [];
  int _currentPageIndex = 0;
  final PageController _pageController = PageController();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    fetchCategories();
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPageIndex < categories.length - 1) {
        _currentPageIndex++;
      } else {
        _currentPageIndex = 0;
      }
      _pageController.animateToPage(
        _currentPageIndex,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  Future<void> fetchCategories() async {
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

    for (var categoryUrl in categoryUrls) {
      final response = await http.get(Uri.parse(categoryUrl['data']!));
      if (response.statusCode == 200) {
        setState(() {
          categories.add(CategoryItem(
            title: categoryUrl['category']!,
            gradient: _generateGradient(),
            url: categoryUrl['data']!,
          ));
        });
      }
    }
  }

  LinearGradient _generateGradient() {
    List<Color> colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.yellow,
      Colors.red,
      Colors.pink,
    ];
    colors.shuffle();
    return LinearGradient(
      colors: [colors[0], colors[1]],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: categories.length,
            onPageChanged: (index) {
              setState(() {
                _currentPageIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final category = categories[index];
              return Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CategoryDetailPage(url: category.url),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.6,
                    decoration: BoxDecoration(
                      gradient: category.gradient,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        category.title,
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: categories.asMap().entries.map((entry) {
                final index = entry.key;
                final selected = index == _currentPageIndex;
                return Container(
                  width: 10,
                  height: 10,
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selected ? Colors.white : Colors.white54,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryItem {
  final String title;
  final LinearGradient gradient;
  final String url;

  CategoryItem(
      {required this.title, required this.gradient, required this.url});
}
