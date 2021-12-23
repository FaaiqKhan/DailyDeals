import 'package:daily_deals/providers/auth.dart';
import 'package:daily_deals/providers/user_details.dart';
import 'package:daily_deals/screens/forgot_password_screen.dart';
import 'package:daily_deals/screens/parent_screen.dart';
import 'package:daily_deals/utils/form_utils.dart';
import 'package:daily_deals/utils/widget_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_button.dart';

class SignInForm extends StatefulWidget {
  static final _form = GlobalKey<FormState>();

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool _showPassword = false;
  UserDetails _userDetails = UserDetails("", "", "", "");

  @override
  Widget build(BuildContext context) {
    return Form(
      key: SignInForm._form,
      child: Column(
        children: [
          Padding(
            padding: TextFormUtils.textFieldSpacing(),
            child: TextFormField(
              decoration: TextFormUtils.textFieldDecoration(
                prefixIcon: "assets/images/email_icon.png",
                title: "Enter email",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your email";
                }
                return null;
              },
              onSaved: (value) => _userDetails.setEmail = value!,
            ),
          ),
          TextFormField(
            decoration: TextFormUtils.textFieldDecoration(
                prefixIcon: "assets/images/password_icon.png",
                title: "Enter password",
                isPassword: true,
                showPassword: _showPassword,
                visibilityFunc: passwordVisibility),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter password";
              }
              return null;
            },
            onSaved: (value) => _userDetails.setPassword = value!,
            obscureText: !_showPassword,
            enableSuggestions: false,
            autocorrect: false,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, ForgotPasswordScreen.routeName);
                },
                child: Text(
                  "Forgot your password?",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                style: ButtonStyle(
                  splashFactory: NoSplash.splashFactory,
                ),
              ),
            ],
          ),
          // Sign In button
          Padding(
            padding: EdgeInsets.only(top: 40.0),
            child: AppButton(
              context: context,
              text: "Sign In",
              lightBlackColor: true,
              functionality: () async {
                if (SignInForm._form.currentState!.validate()) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  SignInForm._form.currentState!.save();
                  WidgetUtils.showLoaderDialog(context, "Please wait...");
                  bool isSignIn = await Provider.of<Auth>(
                    context,
                    listen: false,
                  ).signIn(_userDetails);
                  Navigator.of(context).pop();
                  if (isSignIn) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, ParentScreen.routeName, (route) => false);
                  }
                }
              },
            ),
          )
        ],
      ),
    );
  }

  void passwordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }
}
