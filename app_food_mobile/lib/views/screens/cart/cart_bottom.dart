import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../viewmodels/Carts/cart_view_model.dart';

class CartBottomNavigator extends StatelessWidget {
  const CartBottomNavigator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartViewModel cartViewModel = Provider.of<CartViewModel>(context);
    return Container(
      height: 174,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, -15),
                blurRadius: 20,
                color: Color(0xFFDADADA).withOpacity(0.15))
          ]),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(children: [
          Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(5)),
                child: SvgPicture.asset(
                  "assets/icons/receipt.svg",
                  width: 5,
                  height: 5,
                  fit: BoxFit.scaleDown,
                  color: Colors.orange,
                ),
              ),
              Spacer(),
              Text("Add voucher code"),
              SizedBox(width: 15),
              Icon(Icons.arrow_forward_ios, size: 12, color: Colors.black)
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(TextSpan(text: "Total \n", children: [
                TextSpan(
                    text: cartViewModel.totalPrice.toString(),
                    style: TextStyle(fontSize: 16, color: Colors.black))
              ])),
              SizedBox(
                width: 190,
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      primary: Colors.white,
                      backgroundColor: Colors.orange,
                    ),
                    onPressed: () {},
                    child: Text(
                      "Checkout",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}
