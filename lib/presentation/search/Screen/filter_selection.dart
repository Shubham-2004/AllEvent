import 'package:flutter/material.dart';

class FilterSelection extends StatefulWidget {
  @override
  _FilterSelectionState createState() => _FilterSelectionState();
}

class _FilterSelectionState extends State<FilterSelection> {
  bool isselected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text("All"),
      selected: isselected,
      onSelected: (bool value) {
        setState(() {
          isselected = value;
        });
      },
    );
  }
}
