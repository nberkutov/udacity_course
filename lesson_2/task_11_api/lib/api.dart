// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:task_11_api/unit.dart';

/// The REST API retrieves unit conversions for [Categories] that change.
///
/// For example, the currency exchange rate, stock prices, the height of the
/// tides change often.
/// We have set up an API that retrieves a list of currencies and their current
/// exchange rate (mock data).
///   GET /currency: get a list of currencies
///   GET /currency/convert: get conversion from one currency amount to another
class Api {
  final _httpClient = HttpClient();
  final _url = 'flutter.udacity.com';

  /// Gets all the units and conversion rates for a given category.
  ///
  /// The `category` parameter is the name of the [Category] from which to
  /// retrieve units. We pass this into the query parameter in the API call.
  ///
  /// Returns a list. Returns null on error.

  Future<List<Unit>> getUnits(String category) async {
    final uri = Uri.https(_url, '/$category');
    final json = await _getJson(uri);
    final units =
        json['units'].map<Unit>((unitJson) => Unit.fromJson(unitJson)).toList();
    if (json == null) {
      print('getUnits failed.');
      return null;
    }
    return units;
  }

  /// Given two units, converts from one to another.
  ///
  /// Returns a double, which is the converted amount. Returns null on error.
  Future<double> convert(
      String category, String amount, String from, String to) async {
    final uri = Uri.https(_url, '/$category/convert', {
      'amount': amount,
      'from': from,
      'to': to,
    });
    final json = await _getJson(uri);
    if (json == null) {
      print('convert failed.');
      return null;
    }
    return json['conversion'].toDouble();
  }

  Future<Map> _getJson(Uri uri) async {
    try {
      final request = await _httpClient.getUrl(uri);
      final response = await request.close();
      if (response.statusCode != HttpStatus.ok) {
        return null;
      }
      final body = await response.transform(utf8.decoder).join();
      return jsonDecode(body);
    } catch (ex) {
      print('$ex');
      return null;
    }
  }
}
