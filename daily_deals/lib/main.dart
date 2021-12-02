import 'dart:io';

import 'package:daily_deals/adapters/detailed_product_adapter.dart';
import 'package:daily_deals/providers/cart_cost_provider.dart';
import 'package:daily_deals/providers/closing_soon_timer_provider.dart';
import 'package:daily_deals/screens/code_verification_screen.dart';
import 'package:daily_deals/screens/create_password_screen.dart';
import 'package:daily_deals/screens/forgot_password_screen.dart';
import 'package:daily_deals/screens/help_screen.dart';
import 'package:daily_deals/screens/language_screen.dart';
import 'package:daily_deals/screens/parent_screen.dart';
import 'package:daily_deals/screens/product_details_screen.dart';
import 'package:daily_deals/screens/sign_in_screen.dart';
import 'package:daily_deals/screens/sign_up_screen.dart';
import 'package:daily_deals/screens/splash_screen.dart';
import 'package:daily_deals/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import './screens/sign_in_up_screen.dart';
import 'providers/auth.dart';
import 'providers/cart_item_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(CartItemAdapter());
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: ClosingSoonTimerProvider(),
        ),
        ChangeNotifierProvider.value(
          value: CartCostProvider(),
        ),
        ChangeNotifierProvider.value(
          value: CartItemsProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Daily Deals',
        theme: ThemeData(
          canvasColor: Colors.transparent,
          primaryColor: HexColor("#F0603D"),
          textTheme: TextTheme(
            headline5: TextStyle(
              fontFamily: 'Montserrat-ExtraBoldItalic',
              color: HexColor("#ED4A2F"),
              fontSize: 12,
            ),
            headline6: TextStyle(
              fontFamily: 'Montserrat-Bold',
              fontSize: 32,
              color: HexColor("#464647"),
            ),
            subtitle2: TextStyle(
              fontFamily: 'Montserrat-Bold',
              fontSize: 25,
              color: HexColor("#5F5C5C"),
            ),
            bodyText1: TextStyle(
              fontFamily: 'Montserrat-Regular',
              fontSize: 16,
              color: HexColor("#464647"),
            ),
            bodyText2: TextStyle(
              fontFamily: 'Montserrat-SemiBold',
              color: HexColor("#C4C1CA"),
            ),
          ),
        ),
        home: SplashScreen(),
        routes: {
          LanguageSelection.routeName: (ctx) => LanguageSelection(),
          WelcomeScreen.routeName: (ctx) => WelcomeScreen(),
          SignInUpScreen.routeName: (ctx) => SignInUpScreen(),
          SignUpScreen.routeName: (ctx) => SignUpScreen(),
          SignInScreen.routeName: (ctx) => SignInScreen(),
          CodeVerificationScreen.routeName: (ctx) => CodeVerificationScreen(),
          ForgotPasswordScreen.routeName: (ctx) => ForgotPasswordScreen(),
          CreatePassword.routeName: (ctx) => CreatePassword(),
          ParentScreen.routeName: (ctx) => ParentScreen(),
          ProductDetails.routeName: (ctx) => ProductDetails(),
          HelpScreen.route: (ctx) => HelpScreen(),
        },
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
