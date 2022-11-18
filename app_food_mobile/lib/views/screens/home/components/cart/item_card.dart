import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tiengviet/tiengviet.dart';

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
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent,
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 30,
                color: Color(0xFFB0CCE1).withOpacity(0.32))
          ]),
      child: InkWell(
        onTap: press,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network('${baseApi}${product.image}',
                    height: 150, fit: BoxFit.fill),
              ),
              Container(
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Row(children: [
                  Text("4.5"),
                  SizedBox(width: 5),
                  SizedBox(
                      height: 18.0,
                      width: 18.0,
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
            ],
          ),
          Text(
            product.name,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
          ),
          Text(
            product.price.toString(),
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 15, color: kPrimaryColor),
          )
        ]),
      ),
    );
  }
}
