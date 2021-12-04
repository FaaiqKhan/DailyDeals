import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hexcolor/hexcolor.dart';

class GuessAndWinSequence extends StatefulWidget {
  final int sequenceKey;
  final Function saveSequence;

  GuessAndWinSequence(this.sequenceKey, this.saveSequence);

  @override
  State<GuessAndWinSequence> createState() => _GuessAndWinSequenceState();
}

class _GuessAndWinSequenceState extends State<GuessAndWinSequence> {
  final Color sequenceBoxColor = HexColor("#413F3F");
  final List<String> sequence = [];
  final PageController pageController = PageController(initialPage: 0);
  List<Widget> numbersView = [];
  List<Widget> sequenceView = [];

  void onSelect(int number) {
    setState(() {
      if (sequence.contains(number.toString())) {
        sequence.remove(number.toString());
        numbersView[number - 1] = numberView(number, isSelected: false);
        sequenceView = generateSequenceDigitsView(numbersView);
      } else if (sequence.length < 6) {
        sequence.add(number.toString());
        numbersView[number - 1] = numberView(number, isSelected: true);
        sequenceView = generateSequenceDigitsView(numbersView);
      }
    });
  }

  void clearSequence() {
    setState(() {
      for (String number in sequence) {
        int num = int.parse(number);
        numbersView[num - 1] = numberView(num, isSelected: false);
      }
      sequenceView = generateSequenceDigitsView(numbersView);
      sequence.clear();
    });
  }

  List<Widget> generateNumberView(Function onSelect) {
    List<Widget> view = [];
    for (int i = 1; i < 100; i++) {
      view.add(numberView(i));
    }
    return view;
  }

  List<Widget> generateSequenceDigitsView(List<Widget> numbersView) {
    List<Widget> sequenceView = [];
    sequenceView.add(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: numbersView.getRange(7 * 0, 7 * 1).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: numbersView.getRange(7 * 1, 7 * 2).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: numbersView.getRange(7 * 2, 7 * 3).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: numbersView.getRange(7 * 3, 7 * 4).toList(),
          ),
        ],
      ),
    );
    sequenceView.add(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: numbersView.getRange(7 * 4, 7 * 5).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: numbersView.getRange(7 * 5, 7 * 6).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: numbersView.getRange(7 * 6, 7 * 7).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: numbersView.getRange(7 * 7, 7 * 8).toList(),
          ),
        ],
      ),
    );
    sequenceView.add(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: numbersView.getRange(7 * 8, 7 * 9).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: numbersView.getRange(7 * 9, 7 * 10).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: numbersView.getRange(7 * 10, 7 * 11).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: numbersView.getRange(7 * 11, 7 * 12).toList(),
          ),
        ],
      ),
    );
    sequenceView.add(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: numbersView.getRange(7 * 12, 7 * 13).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: numbersView.getRange(7 * 13, 98).toList(),
          ),
          // Row(children: numberView.getRange(98, 99).toList()),
        ],
      ),
    );
    return sequenceView;
  }

  Widget numberView(int number, {isSelected = false}) {
    return GestureDetector(
      onTap: () {
        onSelect(number);
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Theme.of(context).primaryColor : sequenceBoxColor,
        ),
        alignment: Alignment.center,
        margin: const EdgeInsets.all(5.0),
        child: Text(
          "$number",
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }

  List<Widget> selectedNumbersView(List<String> numbers) {
    List<Widget> view = [];
    int length = numbers.length;
    for (int i = 0; i < 6; i++) {
      view.add(
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: sequenceBoxColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          margin: const EdgeInsets.only(left: 2.5, right: 2.5),
          alignment: Alignment.center,
          child: Text(
            i < length ? numbers.elementAt(i) : "",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
    return view;
  }

  @override
  void initState() {
    numbersView = generateNumberView(onSelect);
    sequenceView = generateSequenceDigitsView(numbersView);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              bottom: 8.0,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 200),
                  child: Text(
                    "SELECT YOUR 06 DIGIT LUCKY NUMBER",
                    style: TextStyle(
                      fontFamily:
                          Theme.of(context).textTheme.bodyText2!.fontFamily,
                      color: Colors.black,
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                      ),
                      alignment: Alignment.center,
                      child: Icon(Icons.add, color: Colors.black, size: 18),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: HexColor("#303030"),
                        borderRadius: BorderRadius.all(
                          Radius.circular(50.0),
                        ),
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 8.0,
                        bottom: 4.0,
                        top: 4.0,
                      ),
                      margin: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        "Clear All",
                        style: TextStyle(
                          fontFamily:
                              Theme.of(context).textTheme.bodyText1!.fontFamily,
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                width: screenWidth,
                decoration: BoxDecoration(
                  color: HexColor("#313030"),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                margin: const EdgeInsets.only(bottom: 20.0),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      child: PageView(
                        controller: pageController,
                        children: sequenceView,
                      ),
                    ),
                    // Navigation Arrows
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Back arrow
                        GestureDetector(
                          onTap: () {
                            pageController.animateToPage(
                              pageController.page!.toInt() - 1,
                              duration: Duration(seconds: 1),
                              curve: Curves.ease,
                            );
                          },
                          child: CircleAvatar(
                            backgroundColor: HexColor("#5A5757"),
                            radius: 18,
                            child: Icon(Icons.arrow_back, color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        // Forward arrow
                        GestureDetector(
                          onTap: () {
                            pageController.animateToPage(
                              pageController.page!.toInt() + 1,
                              duration: Duration(seconds: 1),
                              curve: Curves.ease,
                            );
                          },
                          child: CircleAvatar(
                            backgroundColor: HexColor("#5A5757"),
                            radius: 18,
                            child:
                                Icon(Icons.arrow_forward, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.0),
                    // Pins
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: selectedNumbersView(sequence),
                    ),
                    SizedBox(height: 15.0),
                    // Edit and remove numbers
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: HexColor("#5A5757"),
                              radius: 18,
                              child: Image.asset(
                                "assets/images/edit_icon.png",
                                scale: 30,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Edit numbers",
                              style: TextStyle(
                                fontSize: 8,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        SizedBox(width: 20.0),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                clearSequence();
                              },
                              child: CircleAvatar(
                                backgroundColor: HexColor("#5A5757"),
                                radius: 18,
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              "Delete numbers",
                              style: TextStyle(
                                fontSize: 8,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
              // Save my sequence
              GestureDetector(
                onTap: () {
                  if (sequence.length == 6)
                    widget.saveSequence(widget.sequenceKey, sequence);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: HexColor("#F83615"),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  padding: const EdgeInsets.only(
                    left: 30.0,
                    top: 10.0,
                    right: 30.0,
                    bottom: 10.0,
                  ),
                  child: Text(
                    "Save my Sequence",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily:
                          Theme.of(context).textTheme.headline6!.fontFamily,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
