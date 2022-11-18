import 'package:app_food_mobile/viewmodels/Carts/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class CartItem extends StatefulWidget {
  const CartItem({
    Key? key,
    required this.productName,
    required this.productImgUrl,
    required this.productQuantity,
    required this.cartId,
    required this.price,
    required this.productId,
  }) : super(key: key);
  final String productName;
  final String productImgUrl;
  final int productQuantity;
  final int cartId;
  final int price;
  final int productId;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  late int productQuantityFake = 0;
  bool _loading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productQuantityFake = widget.productQuantity;
  }

  // Add Quanlity
  @override
  Widget build(BuildContext context) {
    CartViewModel cartViewModel =
        Provider.of<CartViewModel>(context, listen: false);
    //test call update produict
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          SizedBox(
            width: 88,
            child: AspectRatio(
              aspectRatio: 0.88,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(15)),
                child: Image.network(widget.productImgUrl, fit: BoxFit.fill),
              ),
            ),
          ),
          SizedBox(width: 20),
          SizedBox(
            height: 88,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.productName,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  maxLines: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (widget.price * productQuantityFake).toString(),
                      style: TextStyle(color: Colors.orange),
                    ),
                  ],
                ),
                Consumer<CartViewModel>(
                  builder: (context, provider, child) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          GestureDetector(
                            onTap: () async {
                              setState(() {
                                if (productQuantityFake > 1) {
                                  productQuantityFake = productQuantityFake - 1;
                                } else {
                                  productQuantityFake = 1;
                                }
                              });
                              await cartViewModel.editCarts(
                                  1, widget.cartId, productQuantityFake);
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: SvgPicture.asset(
                                "assets/icons/minus.svg",
                                height: 20,
                                width: 20,
                                fit: BoxFit.fill,
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            productQuantityFake.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            child: GestureDetector(
                              onTap: () async {
                                setState(() {
                                  productQuantityFake = productQuantityFake + 1;
                                });
                                // await cartViewModel.editCarts(
                                //     1, widget.cartId, productQuantityFake);

                                //test

                                await provider.updateCart(
                                    1, widget.productId, 1);
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: SvgPicture.asset(
                                  "assets/icons/plus.svg",
                                  height: 20,
                                  width: 20,
                                  fit: BoxFit.fill,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ]),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
