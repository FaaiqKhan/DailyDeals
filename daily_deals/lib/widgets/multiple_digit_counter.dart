import 'package:daily_deals/screens/single_digit_screen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

final counterKey = GlobalKey();

class MultipleDigitCounter extends StatefulWidget {
  final int initialValue;
  final int numberOfDigits;
  final bool expandable;

  MultipleDigitCounter(this.numberOfDigits, this.expandable, this.initialValue,
      {Key? key})
      : super(key: key);

  @override
  MultipleDigitCounterState createState() {
    return MultipleDigitCounterState(
      this.numberOfDigits,
      this.expandable,
      this.initialValue,
    );
  }
}

class MultipleDigitCounterState extends State<MultipleDigitCounter> {
  int numberOfDigits;
  bool expandable;
  int _value;

  List<SingleDigit> animatedDigits = [];

  String _oldValue = "";
  String _newValue = "";

  int get value => _value;

  set value(int newValue) {
    _oldValue = value.toString();
    while (_oldValue.length < numberOfDigits) {
      _oldValue = '0$_oldValue';
    }

    _value = newValue;

    _newValue = newValue.toString();
    while (_newValue.length < numberOfDigits) {
      _newValue = '0$_newValue';
    }

    setState(() {
      for (var i = 0; i < numberOfDigits; i++) {
        if (_oldValue[i] != _newValue[i]) {
          animatedDigits[i].setValue(int.parse(_newValue[i]));
        }
      }
    });
  }

  String getValueAsString() {
    String val = _value.toString();
    while (val.length < numberOfDigits) {
      val = '0$val';
    }
    return val;
  }

  MultipleDigitCounterState(this.numberOfDigits, this.expandable, this._value);

  @override
  Widget build(BuildContext context) {
    List<Widget> myWidgets = [];

    if (animatedDigits.isEmpty) {
      String newValue = getValueAsString();

      for (var i = 0; i < newValue.length; i++) {
        var initialDigit = 0;
        if (_oldValue.length > i) {
          initialDigit = int.parse(_oldValue[i]);
        }
        animatedDigits.add(
          SingleDigit(
            initialValue: initialDigit,
            textStyle: TextStyle(color: Colors.white, fontSize: 20),
            boxDecoration: BoxDecoration(color: HexColor("#DA2B0E")),
          ),
        );
      }
    }

    myWidgets.add(animatedDigits[0]);
    myWidgets.add(SizedBox(width: 8));
    myWidgets.add(animatedDigits[1]);

    for (int i = 2; i < animatedDigits.length - 2; i++) {
      if (i % 2 == 0) {
        myWidgets.add(
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            child: Text(
              ":",
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
        myWidgets.add(animatedDigits[i]);
      } else {
        myWidgets.add(SizedBox(
          width: 10,
        ));
        myWidgets.add(animatedDigits[i]);
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: myWidgets,
    );
  }
}