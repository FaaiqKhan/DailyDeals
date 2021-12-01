import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CartAddressDetailsView extends StatefulWidget {
  @override
  State<CartAddressDetailsView> createState() => _CartAddressDetailsViewState();
}

class _CartAddressDetailsViewState extends State<CartAddressDetailsView> {
  final double elementSpacing = 20.0;
  final List<int> addressType = [0, 1, 2];
  int selectedAddressType = 0;
  final Color selectedColor = Colors.white;
  final Color unSelectedColor = HexColor("#383838");
  bool saveAddress = false;
  final double imageScale = 5.0;

  InputDecoration fieldDecoration(String label) {
    return InputDecoration(
      label: Text(label, style: TextStyle(color: Colors.white)),
      fillColor: Colors.white,
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Add Your Delivery address"),
                SizedBox(height: 15),
                // Address fields
                Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15.0),
                          margin: const EdgeInsets.only(bottom: 10.0),
                          decoration: BoxDecoration(
                            color: selectedAddressType == 0
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset(
                            "assets/images/cart/home_icon.png",
                            color: selectedAddressType == 0
                                ? selectedColor
                                : unSelectedColor,
                            scale: imageScale,
                          ),
                        ),
                        Text(
                          "Home",
                          style: TextStyle(
                            fontFamily: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .fontFamily,
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                        Radio(
                          value: addressType[0],
                          groupValue: selectedAddressType,
                          onChanged: (value) {
                            setState(() {
                              selectedAddressType = value as int;
                            });
                          },
                          fillColor: MaterialStateColor.resolveWith(
                            (states) => selectedAddressType == 0
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                          ),
                          hoverColor: Colors.amber,
                        ),
                      ],
                    ),
                    SizedBox(width: elementSpacing),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(11.3),
                          margin: const EdgeInsets.only(bottom: 10.0),
                          decoration: BoxDecoration(
                            color: selectedAddressType == 1
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset(
                            "assets/images/cart/office_icon.png",
                            color: selectedAddressType == 1
                                ? selectedColor
                                : unSelectedColor,
                            scale: imageScale,
                          ),
                        ),
                        Text(
                          "Office",
                          style: TextStyle(
                            fontFamily: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .fontFamily,
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                        Radio(
                          value: addressType[1],
                          groupValue: selectedAddressType,
                          onChanged: (value) {
                            setState(() {
                              selectedAddressType = value as int;
                            });
                          },
                          fillColor: MaterialStateColor.resolveWith(
                            (states) => selectedAddressType == 1
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: elementSpacing),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6.5),
                          margin: const EdgeInsets.only(bottom: 10.0),
                          decoration: BoxDecoration(
                            color: selectedAddressType == 2
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset(
                            "assets/images/cart/other_icon.png",
                            color: selectedAddressType == 2
                                ? selectedColor
                                : unSelectedColor,
                            scale: imageScale,
                          ),
                        ),
                        Text(
                          "Other",
                          style: TextStyle(
                            fontFamily: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .fontFamily,
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                        Radio(
                          value: addressType[2],
                          groupValue: selectedAddressType,
                          onChanged: (value) {
                            setState(() {
                              selectedAddressType = value as int;
                            });
                          },
                          fillColor: MaterialStateColor.resolveWith(
                            (states) => selectedAddressType == 2
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: fieldDecoration("Villa Or Flat number"),
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                      ),
                      TextFormField(
                        decoration: fieldDecoration("Building Name"),
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                      ),
                      TextFormField(
                        decoration: fieldDecoration("Area"),
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                      ),
                      TextFormField(
                        decoration: fieldDecoration("City"),
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                // Save address checkbox
                Theme(
                  data: ThemeData(unselectedWidgetColor: Colors.white),
                  child: CheckboxListTile(
                    value: saveAddress,
                    onChanged: (value) {
                      setState(() {
                        saveAddress = value as bool;
                      });
                    },
                    title: Text(
                      "Save this address",
                      style: TextStyle(
                          fontFamily:
                          Theme.of(context).textTheme.bodyText1!.fontFamily,
                          color: Colors.white,
                          fontSize: 12.0
                      ),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: const EdgeInsets.all(0.0),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
