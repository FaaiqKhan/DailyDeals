import 'package:country_code_picker/country_code.dart';
import 'package:daily_deals/screens/parent_screen.dart';
import 'package:daily_deals/service/webservice.dart';
import 'package:daily_deals/utils/form_utils.dart';
import 'package:daily_deals/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String countryCode = "+971";

class EnterPhoneNumberScreen extends StatelessWidget {
  static const String routeName = "/enter-phone-number-screen";
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    void updateCountryCode(CountryCode code) {
      countryCode = code.dialCode!;
    }

    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      body: Padding(
        padding: Utils.calculateScreenLeftRightPadding(screenWidth),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/phone_activate.png"),
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
              controller: controller,
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
              onPressed: () async {
                if (controller.value.text.isNotEmpty && controller.value.text.length >= 9) {
                  String phoneNumber = countryCode + controller.value.text;
                  bool val = await WebService.updatePhoneNumber(phoneNumber);
                  if (val) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      ParentScreen.routeName,
                      (route) => false,
                    );
                  }
                }
              },
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
          ],
        ),
      ),
    );
  }
}
