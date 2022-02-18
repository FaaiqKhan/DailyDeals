import 'package:country_code_picker/country_code_picker.dart';
import 'package:daily_deals/providers/user_details.dart';
import 'package:daily_deals/service/webservice.dart';
import 'package:daily_deals/utils/form_utils.dart';
import 'package:daily_deals/utils/utils.dart';
import 'package:daily_deals/utils/widget_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'app_button.dart';

class SignUpForm extends StatefulWidget {
  static final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final double screenWidth;

  SignUpForm(this.screenWidth);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool isTermsAndConditionsAccepted = false;
  bool showPassword = false;
  bool showConfirmPassword = false;
  String countryCode = "+971";
  final UserDetails _userDetails = UserDetails("", "", "", "");

  void updateCountryCode(CountryCode code) {
    countryCode = code.dialCode!;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: SignUpForm._form,
      child: Column(
        children: [
          Padding(
            padding: TextFormUtils.textFieldSpacing(),
            child: TextFormField(
              decoration: TextFormUtils.textFieldDecoration(
                prefixIcon: "assets/images/user_name_icon.png",
                title: "Full Name",
              ),
              validator: (value) {
                if (value == null || value.isEmpty)
                  return "Please enter your name";
                return null;
              },
              onSaved: (value) => _userDetails.setFullName = value!,
            ),
          ),
          Padding(
            padding: TextFormUtils.textFieldSpacing(),
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
          Padding(
            padding: TextFormUtils.textFieldSpacing(),
            child: TextFormField(
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
              onSaved: (value) => _userDetails.setNumber = value!,
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
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: TextFormUtils.textFieldSpacing(),
                child: TextFormField(
                  decoration: TextFormUtils.textFieldDecoration(
                    prefixIcon: "assets/images/password_icon.png",
                    title: "Enter password",
                    isPassword: true,
                    showPassword: showPassword,
                    visibilityFunc: passwordVisibility,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please set your password";
                    }
                    return null;
                  },
                  onSaved: (value) => _userDetails.setPassword = value!,
                  obscureText: !showPassword,
                  enableSuggestions: false,
                  autocorrect: false,
                ),
              ),
              Padding(
                padding: TextFormUtils.textFieldSpacing(),
                child: TextFormField(
                  decoration: TextFormUtils.textFieldDecoration(
                    prefixIcon: "assets/images/password_icon.png",
                    title: "Enter confirm password",
                    isPassword: true,
                    showPassword: showConfirmPassword,
                    visibilityFunc: confirmPasswordVisibility,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please re-enter your password";
                    } else if (value != _userDetails.getPassword) {
                      return "Password does not match";
                    }
                    return null;
                  },
                  obscureText: !showConfirmPassword,
                  enableSuggestions: false,
                  autocorrect: false,
                ),
              ),
            ],
          ),
          CheckboxListTile(
            title: Wrap(
              children: [
                Text(
                  "I agree to all ",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Text(
                  "Terms ",
                  style: TextStyle(
                    fontFamily:
                        Theme.of(context).textTheme.bodyText2!.fontFamily,
                    color: Theme.of(context).primaryColor,
                    fontSize: 13,
                  ),
                ),
                Text(
                  "and ",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Text(
                  "Conditions",
                  style: TextStyle(
                    fontFamily:
                        Theme.of(context).textTheme.bodyText2!.fontFamily,
                    color: Theme.of(context).primaryColor,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            activeColor: Theme.of(context).primaryColor,
            controlAffinity: ListTileControlAffinity.leading,
            value: isTermsAndConditionsAccepted,
            contentPadding: EdgeInsets.zero,
            onChanged: (value) {
              setState(() {
                isTermsAndConditionsAccepted = value!;
              });
            },
          ),
          // Sign Up button
          Padding(
            padding: TextFormUtils.textFieldSpacing(),
            child: AppButton(
              context: context,
              text: "Sign Up",
              functionality: () async {
                if (isTermsAndConditionsAccepted) {
                  SignUpForm._form.currentState!.save();
                  if (SignUpForm._form.currentState!.validate()) {
                    WidgetUtils.showLoaderDialog(context, "Please wait...");
                    bool isExist = await WebService.checkEmailExist(
                      _userDetails.getEmail,
                    );
                    if (isExist) {
                      Navigator.of(context).pop();
                      return;
                    }
                    _userDetails.setNumber =
                        countryCode + _userDetails.getNumber;
                    isExist = await WebService.checkPhoneNumberExist(
                      _userDetails.getNumber,
                    );
                    if (isExist) {
                      Navigator.of(context).pop();
                      return;
                    }
                    FocusScope.of(context).requestFocus(FocusNode());
                    Utils.requestOtp(context, _userDetails);
                  }
                } else {
                  WidgetUtils.showToast(
                      "Please accept our terms and conditions");
                }
              },
            ),
          ),
          Visibility(
            visible: Utils.isKeyboardVisible(context),
            child: SizedBox(height: widget.screenWidth * 0.2),
          ),
        ],
      ),
    );
  }

  void passwordVisibility() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  void confirmPasswordVisibility() {
    setState(() {
      showConfirmPassword = !showConfirmPassword;
    });
  }
}
