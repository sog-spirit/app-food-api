import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../constants.dart';
import '../../../models/product.dart';
import '../../../viewmodels/Carts/cart_view_model.dart';

class ItemFoodCategory extends StatefulWidget {
  const ItemFoodCategory({
    super.key,
    required this.product,
  });
  final Product product;
  @override
  State<ItemFoodCategory> createState() => _ItemFoodCategoryState();
}

class _ItemFoodCategoryState extends State<ItemFoodCategory> {
  late int fakeQuantity = 1;
  @override
  void initState() {
    super.initState();
    setState(() {
      fakeQuantity = 1;
    });
  }

  void plusQuantity() {
    setState(() {
      fakeQuantity = fakeQuantity + 1;
    });
  }

  void minusQuantity() {
    if (fakeQuantity > 1) {
      setState(() {
        fakeQuantity = fakeQuantity - 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 15, top: 15),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.5, color: ksecondaryColor.withAlpha(90)),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            height: 110,
            child: AspectRatio(
              aspectRatio: 0.88,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(widget.product.image,
                    height: 150, fit: BoxFit.fill),
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Container(
              height: 110,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        maxLines: 2,
                      ),
                      SizedBox(
                          child: Text(
                        widget.product.price.toInt().toVND(),
                        style: TextStyle(
                            color: ksecondaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      )),
                      SizedBox(
                        child: Row(children: [
                          SizedBox(
                              height: 12.0,
                              width: 12.0,
                              child: new IconButton(
                                padding: new EdgeInsets.all(0.0),
                                icon: SvgPicture.asset(
                                  "assets/icons/star.svg",
                                  color: Color.fromARGB(255, 216, 203, 86),
                                ),
                                onPressed: () {},
                              )),
                          SizedBox(width: 5),
                          Text(
                            "4.5",
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                          SizedBox(width: 5),
                          Text(
                            "(50+)",
                            style:
                                TextStyle(fontSize: 12, color: ksecondaryColor),
                          ),
                        ]),
                      )
                    ],
                  ),
                  Consumer<CartViewModel>(
                    builder: (context, provider, child) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                minusQuantity();
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                height: 24,
                                width: 24,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: kPrimaryColor),
                                    color: Colors.transparent,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                child: SvgPicture.asset(
                                  "assets/icons/minus.svg",
                                  height: 30,
                                  width: 30,
                                  fit: BoxFit.scaleDown,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "${fakeQuantity}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                plusQuantity();
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                height: 24,
                                width: 24,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: kPrimaryColor),
                                    color: kPrimaryColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                child: SvgPicture.asset(
                                  "assets/icons/plus-solid.svg",
                                  height: 30,
                                  width: 30,
                                  fit: BoxFit.scaleDown,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                            onTap: () async {
                              await provider
                                  .updateCart(
                                      widget.product, fakeQuantity, true)
                                  .then((_) {
                                Alert(
                                  context: context,
                                  type: AlertType.success,
                                  title: "THÊM GIỎ HÀNG THÀNH CÔNG",
                                  desc: "Sản phẩm đã được thêm vào giỏ hàng",
                                  buttons: [
                                    DialogButton(
                                      onPressed: () => Navigator.of(context,
                                              rootNavigator: true)
                                          .pop(),
                                      color: Color.fromRGBO(0, 179, 134, 1.0),
                                      radius: BorderRadius.circular(0.0),
                                      child: Text(
                                        "Tiếp tục",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ).show();
                              });
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Text(
                                  "Thêm",
                                  style: TextStyle(color: Colors.white),
                                ))),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
