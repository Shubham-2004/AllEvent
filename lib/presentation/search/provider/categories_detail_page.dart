import 'package:flutter/material.dart';

class CategoryDetailPage extends StatelessWidget {
  final String url;

  const CategoryDetailPage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Implement your detailed page logic here
    return Scaffold(
      appBar: AppBar(
        title: Text('Category Details'),
      ),
      body: Center(
        child: Text('Data from: $url'),
      ),
    );
  }
}
