import 'package:flutter/material.dart';
import 'package:task_03/category.dart';

final _backgroundColor = Colors.green[100];

/// Category Route (screen).
///
/// This is the 'home' screen of the Unit Converter. It shows a header and
/// a list of [Categories].
///
/// While it is named CategoryRoute, a more apt name would be CategoryScreen,
/// because it is responsible for the UI at the route's destination.
class CategoryRoute extends StatelessWidget {
  const CategoryRoute();

  static const _categoryNames = <String>[
    'Length',
    'Area',
    'Volume',
    'Mass',
    'Time',
    'Digital Storage',
    'Energy',
    'Currency',
  ];

  static const _baseColors = <Color>[
    Colors.teal,
    Colors.orange,
    Colors.pinkAccent,
    Colors.blueAccent,
    Colors.yellow,
    Colors.greenAccent,
    Colors.purpleAccent,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    final listView = ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      itemCount: 8,
      itemBuilder: (context, index) {
        return Category(
          name: _categoryNames[index],
          color: _baseColors[index],
          iconLocation: Icons.cake,
        );
      },
    );

    final appBar = AppBar(
      centerTitle: true,
      backgroundColor: _backgroundColor,
      elevation: 0.0,
      title: Text(
        'Unit Converter',
        style: TextStyle(
          fontSize: 30.0,
          color: Colors.black,
        ),
      ),
    );

    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: appBar,
      body: listView,
    );
  }
}
