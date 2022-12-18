import 'dart:convert';

import 'package:app_food_mobile/viewmodels/Products/listProduct_view_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';

import '../../../constants.dart';
import '../../../models/product.dart';
import '../../../viewmodels/Carts/cart_view_model.dart';
import '../../../components/alert_dialog.dart';

class CartItem extends StatefulWidget {
  const CartItem(
      {super.key,
      required this.productName,
      required this.productImgUrl,
      required this.productQuantity,
      required this.price,
      required this.productId,
      required this.cartId});
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
    print(fakeQuantity);
    if (fakeQuantity > 1) {
      // setState(() {
      //   fakeQuantity = fakeQuantity - 1;
      // });
      print('cho phep true');
      setState(() {
        fakeQuantity = fakeQuantity - 1;
      });
    } else {
      print('khong the nao');
      setState(() {
        fakeQuantity = 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 25, top: 15),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.5, color: ksecondaryColor.withAlpha(90)),
        ),
      ),
      child: Consumer<CartViewModel>(
        builder: (context, provider, child) {
          return Row(
            children: [
              SizedBox(
                width: 90,
                height: 90,
                child: AspectRatio(
                  aspectRatio: 0.88,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(widget.productImgUrl,
                        height: 150, fit: BoxFit.fill),
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.productName,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                maxLines: 2,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  print('ok');
                                  final action = await AlertDialogs.yesCancelDialog(
                                      context,
                                      "Xóa sản phẩm",
                                      "Bạn muốn xóa sản phẩm này khỏi giỏ hàng ? ");
                                  if (action == DialogsAction.yes) {
                                    //xoa san pham ra khoi gia hang
                                    print('thuc hien xoa san pham');
                                    await provider
                                        .deleteProductInCart(widget.productId);
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(defaultPadding),
                                  child: SvgPicture.asset(
                                    "assets/icons/xmark-solid.svg",
                                    color: kPrimaryColor,
                                    height: 16,
                                    width: 16,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Text("Spicy chicken, beef"),
                        ],
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                child: Text(
                              widget.price.toVND(),
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        if (widget.productQuantity == 1) {
                                          //hien thi diallog
                                          // hiển thị xác nhận xóa hết giỏ hàng
                                          print('khogn thuc hien duoc ');
                                        } else {
                                          print('ban dang tru san pham');
                                          ListProductsViewModel
                                              listProductsViewModel = Provider
                                                  .of<ListProductsViewModel>(
                                                      context,
                                                      listen: false);
                                          Product product =
                                              listProductsViewModel
                                                  .getProductById(
                                                      widget.productId);
                                          await provider.updateCart(
                                              product, 1, false);
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        height: 24,
                                        width: 24,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1, color: kPrimaryColor),
                                            color:
                                                Color.fromARGB(0, 187, 14, 14),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30))),
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
                                      "${widget.productQuantity}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 10),
                                    GestureDetector(
                                      onTap: () async {
                                        ListProductsViewModel
                                            listProductsViewModel =
                                            Provider.of<ListProductsViewModel>(
                                                context,
                                                listen: false);
                                        Product product = listProductsViewModel
                                            .getProductById(widget.productId);
                                        await provider.updateCart(
                                            product, 1, true);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        height: 24,
                                        width: 24,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1, color: kPrimaryColor),
                                            color: kPrimaryColor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30))),
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
                              ],
                            )
                          ]),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
