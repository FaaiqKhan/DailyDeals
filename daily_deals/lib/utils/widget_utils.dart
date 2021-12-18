import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

class WidgetUtils {
  static double iconScale = 3;

  static Widget progressIndicator(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  static void showCountAlert(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: screenWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: [
                    Image.asset("assets/images/item_count_icon.png"),
                    SizedBox(height: 10.0),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        "Back to product page",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                          Size(screenWidth - 10, 40),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          HexColor("#413F3F"),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "Sorry can\'t add more then three (3) items.",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily:
                            Theme.of(context).textTheme.bodyText2!.fontFamily,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Buy new products",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily:
                                Theme.of(context).textTheme.bodyText2!.fontFamily,
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Image.asset(
                          "assets/images/smile_icon.png",
                          scale: 20,
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void showToast(String text) {
    Fluttertoast.showToast(
      msg: text,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  static Widget tabBarBackButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Icon(Icons.arrow_back, color: Colors.white, size: 18),
      ),
    );
  }
}
