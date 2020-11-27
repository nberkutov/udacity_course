// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import 'unit.dart';

const _padding = EdgeInsets.all(16.0);

/// [ConverterRoute] where users can input amounts to convert in one [Unit]
/// and retrieve the conversion in another [Unit] for a specific [Category].
///
/// While it is named ConverterRoute, a more apt name would be ConverterScreen,
/// because it is responsible for the UI at the route's destination.
class ConverterRoute extends StatefulWidget {
  /// Color for this [Category].
  final Color color;

  /// Units for this [Category].
  final List<Unit> units;

  /// This [ConverterRoute] requires the color and units to not be null.
  const ConverterRoute({
    @required this.color,
    @required this.units,
  })  : assert(color != null),
        assert(units != null);

  @override
  _ConverterRouteState createState() => _ConverterRouteState();
}

class _ConverterRouteState extends State<ConverterRoute> {
  Unit _fromValue;
  Unit _toValue;
  double _inputValue;
  bool _isValid;
  TextEditingController _outputTextController;

  @override
  void initState() {
    _isValid = true;
    _outputTextController = TextEditingController();
    _inputValue = 0.0;
    _fromValue = widget.units[0];
    _toValue = widget.units[1];
    super.initState();
  }

  void _setFromValue(Unit newValue) {
    setState(() {
      _fromValue = newValue;
    });
  }

  void _setToValue(Unit newValue) {
    setState(() {
      _toValue = newValue;
    });
  }

  void _updateConversionValue() {
    setState(() {
      _outputTextController.text =
          _format(_inputValue * (_fromValue.conversion / _toValue.conversion));
    });
  }

  void _updateInput(String newValue) {
    _isValid = _validate(newValue);
    try {
      setState(() {
        if (newValue.isNotEmpty) {
          _inputValue = double.parse(newValue);
        } else {
          _inputValue = 0.0;
        }
        _isValid = true;
        _updateConversionValue();
      });
    } catch (ex) {
      setState(() {
        _isValid = false;
      });
    }
  }

  /// Clean up conversion; trim trailing zeros, e.g. 5.500 -> 5.5, 10.0 -> 10
  String _format(double conversion) {
    var outputNum = conversion.toStringAsPrecision(7);
    if (outputNum.contains('.') && outputNum.endsWith('0')) {
      var i = outputNum.length - 1;
      while (outputNum[i] == '0') {
        i -= 1;
      }
      outputNum = outputNum.substring(0, i + 1);
    }
    if (outputNum.endsWith('.')) {
      return outputNum.substring(0, outputNum.length - 1);
    }
    return outputNum;
  }

  bool _validate(String input) {
    return double.tryParse(input) != null;
  }

  List<DropdownMenuItem<Unit>> _createDropDownItems() {
    return List.generate(
      widget.units.length,
      (index) => DropdownMenuItem(
        child: Text(widget.units[index].name),
        value: widget.units[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final input = Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 8.0),
            child: TextField(
              keyboardType: TextInputType.number,
              style: Theme.of(context).textTheme.headline4,
              decoration: InputDecoration(
                errorText: _isValid ? null : 'Wrong input.',
                labelText: 'Input',
                labelStyle: Theme.of(context).textTheme.headline4,
                border: OutlineInputBorder(borderRadius: BorderRadius.zero),
              ),
              onChanged: (value) {
                _updateInput(value);
              },
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.0,
                color: Colors.black26,
              ),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton(
                    value: _fromValue,
                    items: _createDropDownItems(),
                    onChanged: (value) {
                      _setFromValue(value);
                    },
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    final output = Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 8.0),
            child: TextField(
              keyboardType: TextInputType.number,
              style: Theme.of(context).textTheme.headline4,
              controller: _outputTextController,
              decoration: InputDecoration(
                errorText: _isValid ? null : 'Wrong input.',
                labelText: 'Output',
                labelStyle: Theme.of(context).textTheme.headline4,
                border: OutlineInputBorder(borderRadius: BorderRadius.zero),
              ),
              onChanged: (value) {
                _updateInput(value);
              },
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.0,
                color: Colors.black26,
              ),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton(
                    value: _toValue,
                    items: _createDropDownItems(),
                    onChanged: (value) {
                      _setToValue(value);
                    },
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    final compareArrows = RotatedBox(
      child: Icon(
        Icons.compare_arrows,
        size: 40.0,
      ),
      quarterTurns: 1,
    );

    return Column(
      children: [
        input,
        compareArrows,
        output,
      ],
    );
  }
}
