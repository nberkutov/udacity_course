// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// To keep your imports tidy, follow the ordering guidelines at
// https://www.dartlang.org/guides/language/effective-dart/style#ordering
import 'package:flutter/material.dart';

/// A custom [Category] widget.
///
/// The widget is composed on an [Icon] and [Text]. Tapping on the widget shows
/// a colored [InkWell] animation.
class Category extends StatelessWidget {
  /// Creates a [Category].
  ///
  /// A [Category] saves the name of the Category (e.g. 'Length'), its color for
  /// the UI, and the icon that represents it (e.g. a ruler).
  final IconData iconLocation;
  final Color color;
  final String categoryName;

  static const _height = 100.0;
  static const _borderRadius = 50.0;
  static const _iconSize = 60.0;
  static const _iconPadding = 16.0;
  static const _textSize = 24.0;
  static const _padding = 8.0;

  const Category({
    Key key,
    @required this.iconLocation,
    @required this.color,
    @required this.categoryName,
  })  : assert(iconLocation != null),
        assert(color != null),
        assert(categoryName != null),
        super(key: key);

  /// Builds a custom widget that shows [Category] information.
  ///
  /// This information includes the icon, name, and color for the [Category].
  @override
// This `context` parameter describes the location of this widget in the
// widget tree. It can be used for obtaining Theme data from the nearest
// Theme ancestor in the tree. Below, we obtain the display1 text theme.
// See https://docs.flutter.io/flutter/material/Theme-class.html
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(_padding),
        height: _height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(_borderRadius),
          onTap: () {
            print('I\'m tapped!');
          },
          splashColor: color,
          highlightColor: color,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(_iconPadding),
                child: Icon(
                  iconLocation,
                  size: _iconSize,
                ),
              ),
              Center(
                child: Text(
                  categoryName,
                  style: TextStyle(
                    fontSize: _textSize,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
