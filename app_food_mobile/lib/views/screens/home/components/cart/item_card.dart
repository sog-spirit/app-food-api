import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../constants.dart';
import '../../../../../models/product.dart';

class ItemProduct extends StatelessWidget {
  final Product product;
  final void Function() press;
  const ItemProduct({
    Key? key,
    required this.product,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.42,
      margin: EdgeInsets.only(right: 15, top: 20, bottom: 20),
      child: InkWell(
        onTap: press,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      color: Color.fromARGB(255, 1, 15, 29).withOpacity(0.32))
                ]),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: new Alignment(0.0, 2.5),
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(product.image,
                      height: 150, fit: BoxFit.fill),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        // not in liked item
                        // color: Color.fromARGB(255, 67, 54, 54).withAlpha(100),
                        // in liked item
                        color: kPrimaryColor,
                      ),
                      child: SizedBox(
                          height: 16.0,
                          width: 16.0,
                          child: new IconButton(
                            padding: new EdgeInsets.all(0.0),
                            icon: SvgPicture.asset(
                              "assets/icons/love-icon.svg",
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ))),
                ),
                Positioned(
                  bottom: -10,
                  left: 10,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Row(children: [
                      Text(
                        "4.5",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 5),
                      SizedBox(
                          height: 16.0,
                          width: 16.0,
                          child: new IconButton(
                            padding: new EdgeInsets.all(0.0),
                            icon: SvgPicture.asset(
                              "assets/icons/star.svg",
                              color: Color.fromARGB(255, 216, 203, 86),
                            ),
                            onPressed: () {},
                          ))
                    ]),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          Text(
            (product.name.length.toInt() < 10)
                ? product.name
                : ' ${product.name.substring(0, 10)}....',
            textAlign: TextAlign.left,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
          ),
          Text(
            product.price.toInt().toVND(),
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 15, color: kPrimaryColor),
          )
        ]),
      ),
    );
  }
}
