import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../constants.dart';

class DiscountCard extends StatelessWidget {
  const DiscountCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Offers & Discount",
            style: TextStyle(color: kTextGreyColor, fontWeight: FontWeight.bold),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: double.infinity,
            height: 166,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image:
                        AssetImage("assets/images/beyond-meat-mcdonalds.png"))),
            child: DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(colors: [
                    Color(0xFFFF961F).withOpacity(0.7),
                    kPrimaryColor.withOpacity(0.7)
                  ])),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(children: [
                  Expanded(
                    child: SvgPicture.asset("assets/icons/macdonalds.svg"),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.white),
                          children: const [
                            TextSpan(
                                text: "Get discount of \n",
                                style: TextStyle(fontSize: 16)),
                            TextSpan(
                                text: "30%\n",
                                style: TextStyle(
                                    fontSize: 43, fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    "at MacDonal's on your first order & Instant cashback \n",
                                style: TextStyle(fontSize: 10)),
                          ]),
                    ),
                  )
                ]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
