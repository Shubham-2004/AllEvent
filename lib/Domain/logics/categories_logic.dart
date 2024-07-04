import 'package:allevent/services/api/categories_api.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class CategoryItem {
  final String title;
  final LinearGradient gradient;
  final String url;

  CategoryItem({
    required this.title,
    required this.gradient,
    required this.url,
  });
}

class CategoriesLogic with ChangeNotifier {
  List<CategoryItem> categories = [];
  int currentPageIndex = 0;
  late Timer timer;

  final PageController pageController = PageController();

  CategoriesLogic() {
    fetchCategories();
    startTimer();
  }

  Future<void> fetchCategories() async {
    final categoriesData = await CategoriesApi.fetchCategories();
    categories = categoriesData.map((data) {
      return CategoryItem(
        title: data['category']!,
        gradient: _generateGradient(),
        url: data['data']!,
      );
    }).toList();
    notifyListeners();
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

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (currentPageIndex < categories.length - 1) {
        currentPageIndex++;
      } else {
        currentPageIndex = 0;
      }
      pageController.animateToPage(
        currentPageIndex,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    });
  }

  void dispose() {
    timer.cancel();
    pageController.dispose();
    super.dispose();
  }
}
