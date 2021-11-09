import 'dart:io';

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:daily_deals/providers/auth.dart';
import 'package:daily_deals/screens/welcome_screen.dart';
import 'package:daily_deals/utils/form_utils.dart';
import 'package:daily_deals/utils/utils.dart';
import 'package:daily_deals/widgets/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class CreatePassword extends StatefulWidget {
  static const String routeName = "/create-password";
  static final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  _CreatePasswordState createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  bool showPassword = false;
  String userId = "";

  @override
  void didChangeDependencies() {
    if (userId.isEmpty) {
      // userId = ModalRoute.of(context)!.settings.arguments as String;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    String password = "";
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ColorfulSafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back button
            Visibility(
              visible: !Platform.isIOS,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  margin:
                      Utils.calculateScreenLeftRightPaddingWithTop(screenWidth),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: HexColor("#363637"),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    size: 20,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Change Password",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                    ),
                    child: Text(
                      "Create your new password",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  Padding(
                    padding: Utils.calculateScreenLeftRightPadding(screenWidth),
                    child: Form(
                      key: CreatePassword._form,
                      child: TextFormField(
                        decoration: TextFormUtils.textFieldDecoration(
                          prefixIcon: "assets/images/password_icon.png",
                          title: "Password",
                          isPassword: true,
                          visibilityFunc: passwordVisibility,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter valid password";
                          }
                          return null;
                        },
                        onSaved: (value) => password = value!,
                        obscureText: !showPassword,
                        enableSuggestions: false,
                        autocorrect: false,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 80.0,
                  ),
                  // Sign In button
                  Padding(
                    padding: Utils.calculateScreenLeftRightPadding(screenWidth),
                    child: AppButton(
                      context: context,
                      text: "Send",
                      lightBlackColor: true,
                      functionality: () async {
                        CreatePassword._form.currentState!.save();
                        if (CreatePassword._form.currentState!.validate()) {
                          bool updated = await Provider.of<Auth>(
                            context,
                            listen: false,
                          ).updatePassword(userId, password);
                          if (updated) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                WelcomeScreen.routeName, (route) => false);
                          }
                        }
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void passwordVisibility() {
    setState(() {
      showPassword = !showPassword;
    });
  }
}
