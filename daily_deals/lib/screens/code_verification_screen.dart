import 'dart:async';

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:daily_deals/providers/auth.dart';
import 'package:daily_deals/providers/user_details.dart';
import 'package:daily_deals/screens/create_password_screen.dart';
import 'package:daily_deals/screens/parent_screen.dart';
import 'package:daily_deals/utils/utils.dart';
import 'package:daily_deals/widgets/app_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class CodeVerificationScreen extends StatefulWidget {
  static const String routeName = "/code-verification";

  @override
  _CodeVerificationScreenState createState() => _CodeVerificationScreenState();
}

class _CodeVerificationScreenState extends State<CodeVerificationScreen> {
  Timer? _timer;
  int _start = 0;
  String _smsCode = "";
  bool hasData = false;
  bool forgotPassword = false;
  Map? data;
  UserDetails? _userDetails;
  TextEditingController? _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (data == null) {
      data = ModalRoute.of(context)!.settings.arguments as Map;
      _userDetails = data!['userDetails'];
      forgotPassword = data!['forgotPassword'];
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ColorfulSafeArea(
        child: Padding(
          padding: Utils.calculateScreenLeftRightPadding(screenWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Verify Code",
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(
                height: 40.0,
              ),
              Image.asset("assets/images/mobile_phone_icon.png"),
              SizedBox(
                height: 40.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                ),
                child: Text(
                  "Check your Mobile, we have sent you the code at ${_userDetails!.getNumber}",
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              PinCodeTextField(
                controller: _controller,
                appContext: context,
                length: 6,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  fieldWidth: 40,
                  fieldHeight: 50,
                  borderRadius: BorderRadius.circular(5),
                  activeColor: HexColor("#EAEBF2"),
                  inactiveColor: HexColor("#EAEBF2"),
                  selectedColor: HexColor("#EAEBF2"),
                  inactiveFillColor: HexColor("#EAEBF2"),
                  activeFillColor: HexColor("#EAEBF2"),
                  selectedFillColor: HexColor("#EAEBF2"),
                ),
                enableActiveFill: true,
                cursorColor: Colors.black,
                animationDuration: Duration(milliseconds: 500),
                keyboardType: TextInputType.number,
                backgroundColor: Colors.transparent,
                onCompleted: (v) {
                  _smsCode = v;
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                onChanged: (value) => _smsCode = value,
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                },
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Didn't receive the code?",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _controller!.clear();
                        _smsCode = "";
                      });
                      Utils.requestOtp(
                        context,
                        data!['userDetails'],
                        timer: _startTimer,
                      );
                    },
                    child: Text(
                      "Resend",
                      style: TextStyle(
                        fontFamily:
                            Theme.of(context).textTheme.headline6!.fontFamily,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  )
                ],
              ),
              Visibility(
                visible: _start == 0 ? false : true,
                child: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    "( 00:${_start.toString()} )",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              AppButton(
                context: context,
                text: "Send",
                functionality: () async {
                  Utils.showLoaderDialog(context, "Verifying code...");
                  bool isValid = await verifyCode(
                    data!['verificationId'] as String,
                    _smsCode,
                  );
                  if (isValid) {
                    if (forgotPassword) {
                      Navigator.of(context).pop();
                      Navigator.popAndPushNamed(
                        context,
                        CreatePassword.routeName,
                      );
                    } else {
                      bool userCreated = await Provider.of<Auth>(
                        context,
                        listen: false,
                      ).signUp(_userDetails!);
                      if (userCreated) {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            ParentScreen.routeName, (route) => false);
                      } else {
                        Navigator.of(context).pop();
                        Fluttertoast.showToast(
                          msg:
                              "Cannot create user please contact to service provider",
                          gravity: ToastGravity.BOTTOM,
                          toastLength: Toast.LENGTH_LONG,
                        );
                      }
                    }
                  } else {
                    Navigator.of(context).pop();
                    Fluttertoast.showToast(
                      msg: "Verification failed",
                      gravity: ToastGravity.BOTTOM,
                      toastLength: Toast.LENGTH_LONG,
                    );
                  }
                },
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (_timer != null) _timer!.cancel();
    super.dispose();
  }

  void _startTimer() {
    const oneSec = const Duration(seconds: 1);
    _start = 60;
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  Future<bool> verifyCode(String verificationId, String smsCode) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      return Future.value(userCredential.additionalUserInfo!.isNewUser);
    } catch (e) {
      print(e.toString());
      return Future.value(false);
    }
  }
}
