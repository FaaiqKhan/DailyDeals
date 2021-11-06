import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:daily_deals/screens/sign_in_up_screen.dart';
import 'package:daily_deals/widgets/welcome_note.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomeScreen extends StatefulWidget {
  static const String routeName = "/welcome";

  @override
  State<StatefulWidget> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _controller = PageController();
  bool _showSkip = true;
  int selectedIndex = 0;
  List<StatelessWidget> pages = [];

  @override
  void initState() {
    pages = generateList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColorfulSafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 30,
                    child: SmoothPageIndicator(
                      controller: _controller,
                      count: pages.length,
                      effect: ScrollingDotsEffect(
                          fixedCenter: true,
                          activeDotScale: 1.5,
                          activeStrokeWidth: 2.2,
                          activeDotColor: Theme.of(context).primaryColor,
                          dotWidth: 12,
                          dotHeight: 12
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _showSkip,
                    child: TextButton(
                      onPressed: () => {},
                      child: Text(
                        "Skip",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  onPageChanged: (int page) {
                    setState(() {
                      selectedIndex = page;
                    });
                  },
                  itemCount: 3,
                  itemBuilder: (_, index) => pages[index % pages.length],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<StatelessWidget> generateList() {
    return List.generate(3, (index) {
      if (index == 2) {
        _showSkip = false;
        return SignInUpScreen();
      } else if (index == 1) {
        return WelcomeNote(
          "Shop and win",
          "Now enter your favorite campaigns by buying dailydeals exclusive products and WIN big",
          "assets/images/shop_and_win.png",
        );
      } else {
        return WelcomeNote(
          "Afwan",
          "DailyDeals is all about winning and fulfilling your beautiful dreams in the best possible way. Let's get started!",
          "assets/images/deals_machine.png",
        );
      }
    });
  }
}
