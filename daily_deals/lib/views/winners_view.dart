import 'package:daily_deals/views/winner_card_view.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Winners extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      child: Stack(
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
                  Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white.withOpacity(0.4588235294117647),
                      ),
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.4588235294117647),
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
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
                  Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white.withOpacity(0.4588235294117647),
                      ),
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.4588235294117647),
                    ),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              // Winner cards view
              Container(
                color: Colors.transparent,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      WinnerCard(
                        prizeImage: "assets/images/gold_pen.png",
                        winnerName: "Mr. Khalid Ahmed",
                        reward: "Gold",
                        price: "50,000",
                      ),
                      WinnerCard(
                        prizeImage: "assets/images/gold_pen.png",
                        winnerName: "Mr. Khalid Ahmed",
                        reward: "Gold",
                        price: "50,000",
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
