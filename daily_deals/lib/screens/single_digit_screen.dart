import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SingleDigit extends StatefulWidget {
  final int initialValue;
  final bool showSeparator, useShrinkForm;

  _SingleDigitState? _state;

  SingleDigit({
    required this.initialValue,
    required this.showSeparator,
    this.useShrinkForm = true,
  });

  @override
  State<StatefulWidget> createState() {
    _state = new _SingleDigitState(0, this.initialValue);
    return _state!;
  }

  setValue(newValue) {
    if (_state != null) {
      _state!._setValue(newValue);
    }
  }
}

class _SingleDigitState extends State<SingleDigit>
    with TickerProviderStateMixin {
  _SingleDigitState(this.previousValue, this.currentValue);

  int previousValue, currentValue;

  double separatorPadding = 2.5;
  TextStyle? digitStyle;
  Animation<double>? animation;
  AnimationController? controller;

  @override
  void initState() {
    super.initState();
    _initAnimation();
    if (widget.useShrinkForm) {
      separatorPadding = 0.5;
    }
  }

  @override
  didChangeDependencies() {
    if (digitStyle == null) {
      digitStyle = TextStyle(
        color: Colors.white,
        fontFamily: Theme.of(context).textTheme.bodyText2!.fontFamily,
      );
    }
    super.didChangeDependencies();
  }

  _initAnimation() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    animation = Tween<double>(
      begin: previousValue.toDouble(),
      end: currentValue.toDouble(),
    ).animate(controller!)
      ..addListener(() {
        setState(() {});
      });
    controller!.forward();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  _setValue(int newValue) {
    this.previousValue = this.currentValue;
    this.currentValue = newValue;
    controller!.dispose();
    _initAnimation();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> digits = [];
    final Size digitSize = _getSingleDigitSize();

    for (var i = 0; i < 10; i++) {
      digits.add(Text(i.toString(), style: digitStyle));
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(widget.useShrinkForm ? 4.0 : 8.0),
          margin: EdgeInsets.all(widget.useShrinkForm ? 0.8 : 2.0),
          decoration: BoxDecoration(color: HexColor("#DA2B0E")),
          child: SizedOverflowBox(
            alignment: Alignment.topCenter,
            size: digitSize,
            child: ClipRect(
              clipper: CustomDigitClipper(digitSize),
              child: Transform.translate(
                offset: Offset(0, -this.animation!.value * digitSize.height),
                child: Column(children: digits),
              ),
            ),
          ),
        ),
        Visibility(
          visible: widget.showSeparator,
          child: Padding(
            padding: EdgeInsets.only(
              left: separatorPadding,
              right: separatorPadding,
            ),
            child: Text(":", style: digitStyle),
          ),
        ),
      ],
    );
  }

  // Calculates the size of a single digit based on the current text style
  _getSingleDigitSize() {
    final TextPainter painter = TextPainter();
    painter.text = TextSpan(style: digitStyle, text: '0');
    painter.textDirection = TextDirection.ltr;
    painter.textAlign = TextAlign.center;
    painter.textScaleFactor = 1;
    painter.layout();
    return painter.size;
  }
}

class CustomDigitClipper extends CustomClipper<Rect> {
  CustomDigitClipper(this.digitSize);

  final Size digitSize;

  @override
  Rect getClip(Size size) {
    return Rect.fromPoints(
      Offset.zero,
      Offset(digitSize.width, digitSize.height),
    );
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}
