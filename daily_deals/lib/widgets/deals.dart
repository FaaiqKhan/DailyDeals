import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Deals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: HexColor("#F83615"),
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(10),
                    bottomLeft: const Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 10,
                        bottom: 10,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: HexColor("#303030")),
                          color: HexColor("#303030"),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        "WIN",
                        style: TextStyle(
                          fontFamily:
                              Theme.of(context).textTheme.subtitle2!.fontFamily,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text("Get at Chance To Win"),
                    Text("Apple Watch"),
                    Text("Series 7"),
                    Image.asset(
                      "assets/images/deals_machine.png",
                    ),
                    Text("Buy a pencil Set and"),
                    Text("make it yours"),
                    Text(
                      "AED 30.00",
                      style: TextStyle(
                        fontFamily:
                            Theme.of(context).textTheme.subtitle2!.fontFamily,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Prize Details",
                            style: TextStyle(
                              fontFamily: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .fontFamily,
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              HexColor("#303030"),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Add to Cart",
                            style: TextStyle(
                              fontFamily: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .fontFamily,
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              HexColor("#DA2B0E"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.share_outlined),
                        Image.asset("assets/images/favorite_icon.png")
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Icon(
            Icons.settings,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
