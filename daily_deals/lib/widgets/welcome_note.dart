import 'package:daily_deals/utils/utils.dart';
import 'package:flutter/material.dart';

class WelcomeNote extends StatelessWidget {
  final String _title;
  final String _note;
  final String _imagePath;

  WelcomeNote(this._title, this._note, this._imagePath);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: Utils.calculateScreenLeftRightPadding(screenWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: pageHeight(screenHeight),
              ),
              Text(_title, style: Theme.of(context).textTheme.headline6),
              const SizedBox(
                height: 34,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _note,
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: patternSize(screenWidth),
          padding: const EdgeInsets.only(bottom: 20),
          child: Image.asset(
            _imagePath,
            fit: BoxFit.fitWidth,
          ),
        )
      ],
    );
  }

  double patternSize(double screenWidth) {
    return screenWidth - (screenWidth * 0.18);
  }

  double pageHeight(double screenHeight) {
    return screenHeight - (screenHeight * 0.94);
  }
}
