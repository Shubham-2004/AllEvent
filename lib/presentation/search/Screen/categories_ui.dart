import 'package:allevent/Domain/logics/categories_logic.dart';
import 'package:allevent/presentation/search/provider/categories_detail_page.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CategoriesLogic(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Categories'),
        ),
        body: Consumer<CategoriesLogic>(
          builder: (context, logic, child) {
            return Stack(
              children: [
                PageView.builder(
                  controller: logic.pageController,
                  itemCount: logic.categories.length,
                  onPageChanged: (index) {
                    logic.currentPageIndex = index;
                    logic.notifyListeners();
                  },
                  itemBuilder: (context, index) {
                    final category = logic.categories[index];
                    return Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoryDetailPage(
                                url: category.url,
                              ),
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
                    children: logic.categories.asMap().entries.map((entry) {
                      final index = entry.key;
                      final selected = index == logic.currentPageIndex;
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
            );
          },
        ),
      ),
    );
  }
}
