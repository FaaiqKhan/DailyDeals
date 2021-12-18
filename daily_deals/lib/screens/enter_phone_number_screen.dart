import 'package:country_code_picker/country_code.dart';
import 'package:daily_deals/utils/form_utils.dart';
import 'package:daily_deals/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String countryCode = "+971";

class EnterPhoneNumberScreen extends StatelessWidget {
  static const String routeName = "/enter-phone-number-screen";

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    void updateCountryCode(CountryCode code) {
      countryCode = code.dialCode!;
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: Utils.calculateScreenLeftRightPadding(screenWidth),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(height: 20),
            Text(
              "Please Enter Your Mobile Number To Avail All Deals",
              style: TextStyle(
                color: Colors.white,
                fontFamily: Theme.of(context).textTheme.headline6!.fontFamily,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: TextFormUtils.textFieldDecoration(
                prefixIcon: "assets/images/mobile_icon.png",
                title: "Number",
                isNumberField: true,
                countryCodeFunc: updateCountryCode,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter you number";
                } else if ((countryCode != "+971" && value.length != 10) ||
                    (countryCode == "+971" && value.length != 9)) {
                  return "Please enter a valid phone number";
                }
                return null;
              },
              // onSaved: (value) => _userDetails.setNumber = value!,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              onChanged: (value) {
                if (value.length == 10) {
                  FocusScope.of(context).requestFocus(FocusNode());
                } else if (countryCode == "+971" && value.length == 9) {
                  FocusScope.of(context).requestFocus(FocusNode());
                }
              },
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {},
              child: Text(
                "Send",
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).primaryColor,
                ),
                minimumSize: MaterialStateProperty.all(
                  Size(
                    screenWidth,
                    Utils.calculateButtonHeight(screenWidth),
                  ),
                ),
              ),
            ),
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
