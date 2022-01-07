import 'dart:io';

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:country_code_picker/country_code.dart';
import 'package:daily_deals/providers/user_details.dart';
import 'package:daily_deals/service/webservice.dart';
import 'package:daily_deals/utils/form_utils.dart';
import 'package:daily_deals/utils/utils.dart';
import 'package:daily_deals/utils/widget_utils.dart';
import 'package:daily_deals/widgets/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

String countryCode = "+971";

class ForgotPasswordScreen extends StatelessWidget {
  static const String routeName = "/forgot-password";
  static final GlobalKey<FormState> _form = GlobalKey<FormState>();

  void updateCountryCode(CountryCode code) {
    countryCode = code.dialCode!;
  }

  @override
  Widget build(BuildContext context) {
    UserDetails _userDetails = UserDetails("", "", "", "");
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: ColorfulSafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back button
            Visibility(
              visible: Platform.isIOS,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  margin:
                      Utils.calculateScreenLeftRightPaddingWithTop(screenWidth),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: HexColor("#363637"), width: 2),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Icon(Icons.arrow_back, size: 20),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Forgot Password",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 40.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Text(
                      "Enter your mobile number to reset your password.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  const SizedBox(height: 50.0),
                  Padding(
                    padding: Utils.calculateScreenLeftRightPadding(screenWidth),
                    child: Form(
                      key: _form,
                      child: TextFormField(
                        decoration: TextFormUtils.textFieldDecoration(
                          prefixIcon: "assets/images/email_icon.png",
                          title: "Enter email",
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return "Please enter you email";
                          return null;
                        },
                        onSaved: (value) => _userDetails.setEmail = value!,
                      ),
                    ),
                  ),
                  const SizedBox(height: 80.0),
                  // Request OTP button
                  Padding(
                    padding: Utils.calculateScreenLeftRightPadding(screenWidth),
                    child: AppButton(
                      context: context,
                      text: "Send",
                      lightBlackColor: true,
                      functionality: () async {
                        _form.currentState!.save();
                        if (_form.currentState!.validate()) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          WidgetUtils.showLoaderDialog(
                              context, "Please wait...");
                          bool requested =
                              await WebService.requestPasswordReset(
                                  _userDetails.getEmail);
                          Navigator.of(context).pop();
                          if (requested) {
                            Navigator.of(context).pop();
                            WidgetUtils.showToast(
                                "We have just sent an email. Please check inbox/spam and complete the process.");
                          } else {
                            WidgetUtils.showToast(
                                "Something went wrong. Please contact to provider");
                          }
                        } else {
                          Fluttertoast.showToast(
                            msg: "Enter a valid email address",
                            gravity: ToastGravity.BOTTOM,
                            toastLength: Toast.LENGTH_LONG,
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
