import 'package:app_food_mobile/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../components/default_button.dart';
import '../../../../constants.dart';
import '../../../../models/product.dart';
import '../../../../viewmodels/Carts/cart_view_model.dart';

class DetailBottomNavigator extends StatefulWidget {
  const DetailBottomNavigator(
      {Key? key, required this.product, required this.cartViewModel})
      : super(key: key);
  final Product product;
  final CartViewModel cartViewModel;

  @override
  State<DetailBottomNavigator> createState() => _DetailBottomNavigatorState();
}

class _DetailBottomNavigatorState extends State<DetailBottomNavigator> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    //user model view to add product to cart
    return ChangeNotifierProvider<CartViewModel>(
      create: (context) => widget.cartViewModel,
      child: Builder(
        builder: (context) {
          return Container(
            height: 85,
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(children: [
                      GestureDetector(
                        onTap: () {
                          if (count > 1) {
                            setState(() {
                              count--;
                            });
                          } else
                            setState(() {
                              count = 1;
                            });
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
                      SizedBox(width: 15),
                      Text(
                        count.toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 15),
                      GestureDetector(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              count++;
                            });
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
                  ),
                  Consumer<CartViewModel>(
                    builder: ((context, provider, child) => TextButton(
                          onPressed: () async {
                            print('add product');
                            //check product is in cart
                            // provider.checkProductInCart(1, 9);
                            await provider.updateCart(
                                1, widget.product.id, count);
                            // await provider.addCarts(
                            //     1, widget.product.id, count);

                            //duyen dang fix bug
                            // int cartId =
                            //     provider.getCartIdByProduct(widget.product.id);
                            // print('duyen dang fix bug');
                            // print(cartId);
                          },
                          child: Container(
                            height: 90,
                            padding: EdgeInsets.symmetric(
                              horizontal: 30,
                            ),
                            decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Thêm",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 15),
                                  Container(
                                    width: 3,
                                    height: 3,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    widget.product.price.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]),
                          ),
                        )),
                  ),
                ]),
          );
        },
      ),
    );
  }
}
