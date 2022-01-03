import 'dart:io';

import 'package:daily_deals/utils/utils.dart';
import 'package:daily_deals/utils/viewhelper/dropdown_action.dart';
import 'package:daily_deals/utils/widget_utils.dart';
import 'package:daily_deals/views/app_bar_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class HelpScreen extends StatelessWidget {
  static const String routeName = "/help-screen";

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonHeight = 50.0;
    Color textFieldBorderColor = HexColor("#E4E6E8");
    Color textAndIconColor = HexColor("#A8B2BD");
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController subjectController = TextEditingController();
    TextEditingController messageController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AppBarTitle("Help"),
        leading: Platform.isIOS ? WidgetUtils.tabBarBackButton(context) : null,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomDropdown<int>(
                child: iconAndText(
                  context,
                  "assets/images/lottery_icon.png",
                  "Lottery Terms & Condition",
                  5,
                ),
                onChange: (int value, int index) => print(value),
                dropdownButtonStyle: DropdownButtonStyle(
                  width: screenWidth,
                  height: 50,
                  elevation: 1,
                  backgroundColor: [
                    Theme.of(context).primaryColor,
                    HexColor("#313030")
                  ],
                ),
                dropdownStyle: DropdownStyle(padding: EdgeInsets.all(5)),
                items: [
                  const SizedBox(height: 20.0),
                  // Image with title
                  Row(
                    children: [
                      Image.asset("assets/images/agreement_icon.png", scale: 8),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 200),
                        child: Text(
                          "Terms & Condition",
                          style: TextStyle(
                            fontFamily: Theme.of(context)
                                .textTheme
                                .headline6!
                                .fontFamily,
                            fontSize:
                                Theme.of(context).textTheme.subtitle2!.fontSize,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  // Terms and condition text
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostru exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillu dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(height: 20.0),
                  // Accept terms and condition
                  TextButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                        Size(screenWidth, buttonHeight),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                    child: Text(
                      "I ACCEPT TERMS & CONDITION",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily:
                            Theme.of(context).textTheme.subtitle2!.fontFamily,
                      ),
                    ),
                    onPressed: () {},
                  ),
                  const SizedBox(height: 30.0),
                ],
              ),
              SizedBox(height: 20.0),
              // CustomDropdown<int>(
              //   child: iconAndText(
              //     context,
              //     "assets/images/referral_icon.png",
              //     "Referral Program Terms & Condition",
              //     17,
              //   ),
              //   onChange: (int value, int index) => print(value),
              //   dropdownButtonStyle: DropdownButtonStyle(
              //     width: screenWidth,
              //     height: 50,
              //     elevation: 1,
              //     backgroundColor: [
              //       Theme.of(context).primaryColor,
              //       HexColor("#313030")
              //     ],
              //   ),
              //   dropdownStyle: DropdownStyle(padding: EdgeInsets.all(5)),
              //   items: [
              //     const SizedBox(height: 20.0),
              //     // Image with title
              //     Row(
              //       children: [
              //         Image.asset("assets/images/agreement_icon.png", scale: 8),
              //         ConstrainedBox(
              //           constraints: BoxConstraints(maxWidth: 200),
              //           child: Text(
              //             "Terms & Condition",
              //             style: TextStyle(
              //               fontFamily: Theme.of(context)
              //                   .textTheme
              //                   .headline6!
              //                   .fontFamily,
              //               fontSize:
              //                   Theme.of(context).textTheme.subtitle2!.fontSize,
              //               color: Colors.black,
              //             ),
              //           ),
              //         )
              //       ],
              //     ),
              //     const SizedBox(height: 20.0),
              //     // Terms and condition text
              //     Text(
              //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostru exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillu dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
              //       style: Theme.of(context).textTheme.bodyText1,
              //     ),
              //     const SizedBox(height: 20.0),
              //     // Accept terms and condition
              //     TextButton(
              //       style: ButtonStyle(
              //         minimumSize: MaterialStateProperty.all(
              //           Size(screenWidth, buttonHeight),
              //         ),
              //         backgroundColor: MaterialStateProperty.all(
              //           Theme.of(context).primaryColor,
              //         ),
              //       ),
              //       child: Text(
              //         "I ACCEPT TERMS & CONDITION",
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontFamily:
              //               Theme.of(context).textTheme.subtitle2!.fontFamily,
              //         ),
              //       ),
              //       onPressed: () {},
              //     ),
              //     const SizedBox(height: 30.0),
              //   ],
              // ),
              // SizedBox(height: 20.0),
              CustomDropdown<int>(
                child: iconAndText(
                  context,
                  "assets/images/privacy_policy_icon.png",
                  "Privacy Policy",
                  17,
                ),
                onChange: (int value, int index) => print(value),
                dropdownButtonStyle: DropdownButtonStyle(
                  width: screenWidth,
                  height: 50,
                  elevation: 1,
                  backgroundColor: [
                    Theme.of(context).primaryColor,
                    HexColor("#313030")
                  ],
                ),
                dropdownStyle: DropdownStyle(padding: EdgeInsets.all(5)),
                items: [
                  const SizedBox(height: 20.0),
                  // Image with title
                  Row(
                    children: [
                      Image.asset("assets/images/agreement_icon.png", scale: 8),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 200),
                        child: Text(
                          "Terms & Condition",
                          style: TextStyle(
                            fontFamily: Theme.of(context)
                                .textTheme
                                .headline6!
                                .fontFamily,
                            fontSize:
                                Theme.of(context).textTheme.subtitle2!.fontSize,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  // Terms and condition text
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostru exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillu dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(height: 20.0),
                  // Accept terms and condition
                  TextButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                        Size(screenWidth, buttonHeight),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                    child: Text(
                      "I ACCEPT TERMS & CONDITION",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily:
                            Theme.of(context).textTheme.subtitle2!.fontFamily,
                      ),
                    ),
                    onPressed: () {},
                  ),
                  const SizedBox(height: 30.0),
                ],
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: CustomDropdown<int>(
                  child: iconAndText(
                    context,
                    "assets/images/inquiry_form_icon.png",
                    "Inquiry Form",
                    17,
                  ),
                  onChange: (int value, int index) => print(value),
                  dropdownButtonStyle: DropdownButtonStyle(
                    width: screenWidth,
                    height: 50,
                    elevation: 1,
                    backgroundColor: [
                      Theme.of(context).primaryColor,
                      HexColor("#313030")
                    ],
                  ),
                  dropdownStyle: DropdownStyle(padding: EdgeInsets.all(5)),
                  items: [
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 300),
                          child: Text(
                            "Have an inquiry? Fill the form below to contact us",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .fontFamily,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Column(
                        children: [
                          // Name
                          TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: textFieldBorderColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: textFieldBorderColor,
                                ),
                              ),
                              hintText: "Name",
                              hintStyle: TextStyle(color: textAndIconColor),
                              prefixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(width: 10.0),
                                  Opacity(
                                    opacity: 0.0,
                                    child: Icon(
                                      Icons.email_outlined,
                                      color: textAndIconColor,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      left: 10.0,
                                      right: 10.0,
                                    ),
                                    width: 2,
                                    height: buttonHeight - 10,
                                    color: textFieldBorderColor,
                                  )
                                ],
                              ),
                            ),
                            cursorColor: textAndIconColor,
                          ),
                          SizedBox(height: 10.0),
                          // Email
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: textFieldBorderColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: textFieldBorderColor,
                                ),
                              ),
                              hintText: "Email",
                              hintStyle: TextStyle(color: textAndIconColor),
                              prefixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(width: 10.0),
                                  Icon(
                                    Icons.email_outlined,
                                    color: textAndIconColor,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      left: 10.0,
                                      right: 10.0,
                                    ),
                                    width: 2,
                                    height: buttonHeight - 10,
                                    color: textFieldBorderColor,
                                  )
                                ],
                              ),
                            ),
                            cursorColor: textAndIconColor,
                          ),
                          SizedBox(height: 10.0),
                          // Phone
                          TextFormField(
                            controller: phoneController,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: textFieldBorderColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: textFieldBorderColor,
                                ),
                              ),
                              hintText: "Phone",
                              hintStyle: TextStyle(color: textAndIconColor),
                              prefixIcon: Row(
                                children: [
                                  SizedBox(width: 10.0),
                                  Opacity(
                                    opacity: 0.0,
                                    child: Icon(Icons.email),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      left: 10.0,
                                      right: 10.0,
                                    ),
                                    width: 2,
                                    height: buttonHeight - 10,
                                    color: textFieldBorderColor,
                                  )
                                ],
                              ),
                            ),
                            cursorColor: textAndIconColor,
                          ),
                          SizedBox(height: 10.0),
                          // Subject
                          TextFormField(
                            controller: subjectController,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: textFieldBorderColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: textFieldBorderColor,
                                ),
                              ),
                              hintText: "Subject",
                              hintStyle: TextStyle(color: textAndIconColor),
                            ),
                            cursorColor: textAndIconColor,
                          ),
                          SizedBox(height: 10.0),
                          // Message
                          Container(
                            height: 200,
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: textFieldBorderColor,
                                width: 1.0,
                              ),
                            ),
                            child: TextFormField(
                              controller: messageController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Write your Message",
                                hintStyle: TextStyle(color: textAndIconColor),
                              ),
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              cursorColor: textAndIconColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Send Message",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .fontFamily,
                            fontSize: 15,
                          ),
                        ),
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                            Size(screenWidth, buttonHeight),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            HexColor("#313030"),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: Utils.isKeyboardVisible(context),
                      child: SizedBox(height: screenWidth * 0.17),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconAndText(
    BuildContext context,
    String path,
    String text,
    double iconScale,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(path, scale: iconScale, color: Colors.white),
        SizedBox(width: 20.0),
        Text(
          text,
          style: TextStyle(
            fontFamily: Theme.of(context).textTheme.subtitle1!.fontFamily,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
