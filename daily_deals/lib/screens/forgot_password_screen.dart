import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:daily_deals/providers/auth.dart';
import 'package:daily_deals/providers/user_details.dart';
import 'package:daily_deals/utils/form_utils.dart';
import 'package:daily_deals/utils/utils.dart';
import 'package:daily_deals/widgets/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const String routeName = "/forgot-password";
  static final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    UserDetails _userDetails = UserDetails("", "", "", "");
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ColorfulSafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Forgot Password",
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
                "Enter your mobile number to reset your password.",
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
                key: _form,
                child: TextFormField(
                  decoration: TextFormUtils.textFieldDecoration(
                    prefixIcon: "assets/images/mobile_icon.png",
                    title: "Number",
                    isNumberField: true,
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length != 9) {
                      return "Please enter valid mobile number";
                    }
                    return null;
                  },
                  onSaved: (value) => _userDetails.setNumber = value!,
                  maxLength: 9,
                  onChanged: (value) {
                    if (value.length == 9) {
                      FocusScope.of(context).requestFocus(FocusNode());
                    }
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 80.0,
            ),
            // Request OTP button
            Padding(
              padding: Utils.calculateScreenLeftRightPadding(screenWidth),
              child: AppButton(
                context: context,
                text: "Send",
                isSignIn: true,
                functionality: () async {
                  _form.currentState!.save();
                  if (_form.currentState!.validate()) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    Utils.showLoaderDialog(context, "Please wait...");
                    // _userDetails.setNumber = "+971${_userDetails.getNumber}";
                    _userDetails.setNumber = "+923003784109";
                    Map result = await Provider.of<Auth>(
                      context,
                      listen: false,
                    ).verifyNumber(_userDetails.getNumber);
                    Navigator.of(context).pop();
                    if (result['verified']) {
                      _userDetails.setUserId = result['userId'];
                      Utils.requestOtp(
                        context,
                        _userDetails,
                        forgotPassword: true,
                      );
                    } else {
                      Fluttertoast.showToast(
                        msg: "phone number not exist",
                        gravity: ToastGravity.BOTTOM,
                        toastLength: Toast.LENGTH_LONG,
                      );
                    }
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
