import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'color_utils.dart';
import 'utils.dart';

class TextFormUtils {
  static InputDecoration textFieldDecoration({
    @required String? prefixIcon,
    @required String? title,
    bool isNumberField = false,
    bool isPassword = false,
    bool showPassword = false,
    Function? visibilityFunc,
  }) {
    return InputDecoration(
      filled: true,
      fillColor: HexColor(ColorUtils.textFieldFillColor),
      prefixIcon: Padding(
        padding: EdgeInsets.only(left: 25.0, right: isNumberField ? 0.0 : 25.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              prefixIcon!,
              width: 20,
            ),
            Visibility(
              visible: isNumberField,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/flag_icon.png",
                      width: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("+971"),
                    Text(
                      " 05",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      suffixIcon: isPassword
          ? GestureDetector(
              onTap: () {
                if (visibilityFunc != null) visibilityFunc();
              },
              child: (showPassword
                  ? Icon(
                      Icons.visibility,
                      color: HexColor("#464647"),
                    )
                  : Icon(
                      Icons.visibility_off_sharp,
                      color: HexColor("#464647"),
                    )),
            )
          : null,
      hintText: title,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          Utils.buttonBorderRadius(),
        ),
        borderSide: BorderSide(
          color: Colors.transparent,
          width: _textFieldBorderWidth(),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          Utils.buttonBorderRadius(),
        ),
        borderSide: BorderSide(
          color: Colors.transparent,
          width: _textFieldBorderWidth(),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          Utils.buttonBorderRadius(),
        ),
        borderSide: BorderSide(
          color: Colors.transparent,
          width: _textFieldBorderWidth(),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          Utils.buttonBorderRadius(),
        ),
        borderSide: BorderSide(
          color: Colors.red,
          width: _textFieldBorderWidth(),
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          Utils.buttonBorderRadius(),
        ),
        borderSide: BorderSide(
          color: Colors.red,
          width: _textFieldBorderWidth(),
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          Utils.buttonBorderRadius(),
        ),
        borderSide: BorderSide.none,
      ),
      counterText: "",
    );
  }

  static double _textFieldBorderWidth() {
    return 1.0;
  }

  static EdgeInsetsGeometry textFieldSpacing() {
    return const EdgeInsets.only(bottom: 14.0);
  }
}
