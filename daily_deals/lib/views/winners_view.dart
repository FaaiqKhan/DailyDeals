import 'package:daily_deals/modals/winner_modal.dart';
import 'package:daily_deals/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Winners extends StatelessWidget {
  final List<WinnerModal> _modal;
  final PageController _pageController = PageController(initialPage: 0);

  Winners(this._modal);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    List<Widget> viewData = Utils.prepareListDataForView(_modal, true);
    return Stack(
      children: [
        Container(
          width: screenWidth,
          height: screenWidth * 0.54,
          decoration: BoxDecoration(
            color: HexColor("#F83615"),
            image: DecorationImage(
              image: Image.asset("assets/images/party_items.png").image,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    _pageController.animateToPage(
                      _pageController.page!.toInt() - 1,
                      duration: Duration(seconds: 1),
                      curve: Curves.ease,
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white.withOpacity(0.4588235294117647),
                      ),
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.4588235294117647),
                    ),
                    child: Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: screenWidth * 0.04),
                    Image.asset(
                      "assets/images/announcement_icon.png",
                      scale: 16,
                    ),
                    Text(
                      "WINNERS",
                      style: TextStyle(
                        fontFamily:
                            Theme.of(context).textTheme.subtitle2!.fontFamily,
                        fontSize: 35,
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    _pageController.animateToPage(
                      _pageController.page!.toInt() + 1,
                      duration: Duration(seconds: 1),
                      curve: Curves.ease,
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white.withOpacity(0.4588235294117647),
                      ),
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.4588235294117647),
                    ),
                    child: Icon(Icons.arrow_forward, color: Colors.white),
                  ),
                ),
              ],
            ),
            // Winner cards view
            Container(
              height: screenWidth * 0.6,
              color: Colors.transparent,
              child: PageView(
                onPageChanged: (int) {},
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                pageSnapping: true,
                children: viewData,
                physics: NeverScrollableScrollPhysics(),
              ),
            )
          ],
        ),
      ],
    );
  }
}
