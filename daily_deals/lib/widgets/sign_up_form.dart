import 'package:country_code_picker/country_code_picker.dart';
import 'package:daily_deals/providers/user_details.dart';
import 'package:daily_deals/utils/form_utils.dart';
import 'package:daily_deals/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_button.dart';

bool showPassword = false;
bool showConfirmPassword = false;
Function passwordState = () {};
String countryCode = "+971";

class SignUpForm extends StatelessWidget {
  static final GlobalKey<FormState> _form = GlobalKey<FormState>();

  void updateCountryCode(CountryCode code) {
    countryCode = code.dialCode!;
  }

  @override
  Widget build(BuildContext context) {
    final UserDetails _userDetails = UserDetails("", "", "", "");

    return Form(
      key: _form,
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
                } else if (value.length != 9) {
                  return "Please enter a valid phone number";
                }
                return null;
              },
              onSaved: (value) => _userDetails.setNumber = value!,
              keyboardType: TextInputType.phone,
              maxLength: 9,
            ),
          ),
          StatefulBuilder(
            builder: (cxt, state) {
              passwordState = state;
              return Column(
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
              );
            },
          ),
          // Sign Up button
          Padding(
            padding: TextFormUtils.textFieldSpacing(),
            child: AppButton(
              context: context,
              text: "Sign Up",
              functionality: () async {
                _form.currentState!.save();
                if (_form.currentState!.validate()) {
                  _userDetails.setNumber = countryCode + _userDetails.getNumber;
                  FocusScope.of(context).requestFocus(FocusNode());
                  Utils.requestOtp(
                    context,
                    _userDetails,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void passwordVisibility() {
    passwordState(() {
      showPassword = !showPassword;
    });
  }

  void confirmPasswordVisibility() {
    passwordState(() {
      showConfirmPassword = !showConfirmPassword;
    });
  }
}
