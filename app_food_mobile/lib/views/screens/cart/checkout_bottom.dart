// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:app_food_mobile/viewmodels/Users/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../../../constants.dart';
import '../../../../viewmodels/Carts/cart_view_model.dart';
import '../../../components/alert_dialog.dart';
import '../../../models/cart.dart';
import '../../../models/productOrder.dart';
import '../../pages/main_page.dart';

class CheckoutBottomNavigator extends StatefulWidget {
  const CheckoutBottomNavigator({Key? key, required this.address})
      : super(key: key);
  final String address;
  @override
  State<CheckoutBottomNavigator> createState() =>
      _CheckoutBottomNavigatorState();
}

class _CheckoutBottomNavigatorState extends State<CheckoutBottomNavigator> {
  @override
  Widget build(BuildContext context) {
    //user model view to add product to cart
    return Container(
      height: 160,
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
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
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.45,
                height: 50,
                padding: EdgeInsets.only(right: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tiền mặt"),
                      SvgPicture.asset(
                        "assets/icons/angle-up-solid.svg",
                        height: 14,
                        width: 14,
                      ),
                    ]),
              ),
              Container(
                height: 30,
                color: ksecondaryColor,
                width: 0.5,
              ),
              Expanded(
                child: Center(
                    child: Text(
                  "THÊM COUPON",
                  style: TextStyle(
                      color: kPrimaryColor, fontWeight: FontWeight.bold),
                )),
              ),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Consumer<CartViewModel>(
              builder: (context, provider, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tổng cộng",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Text(
                      "${provider.totalPrice + 10000}".toVND().toString(),
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                );
              },
            ),
            Consumer<UserViewModel>(
              builder: ((context, provider, child) {
                return TextButton(
                  onPressed: () async {
                    print('dajt hang');
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            insetPadding: EdgeInsets.all(defaultPadding),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20.0)), //this right here
                            child: Container(
                              padding: EdgeInsets.all(defaultPadding),
                              child: Wrap(
                                spacing: 10,
                                direction: Axis.horizontal,
                                alignment: WrapAlignment.center,
                                children: [
                                  Text(
                                    "Giao hàng đến địa chỉ này? ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2
                                        ?.apply(color: kBlackColor),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: defaulMargin),
                                    child: Text(
                                      widget.address,
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(bottom: defaulMargin),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: kPrimaryColor,
                                      ),
                                      child: TextButton(
                                        onPressed: () async {
                                          List<Cart> carts =
                                              Provider.of<CartViewModel>(
                                                      context,
                                                      listen: false)
                                                  .cartListModel;
                                          print('Cart $carts');
                                          List<ProductOrder> lstOrders = [];
                                          carts.forEach((cart) {
                                            ProductOrder pro = new ProductOrder(
                                                product: cart.productId,
                                                quantity: cart.quantity);
                                            lstOrders.add(pro);
                                          });
                                          bool statusOrder = await provider
                                              .order(lstOrders, widget.address);
                                          if (statusOrder) {
                                            Alert(
                                              context: context,
                                              type: AlertType.success,
                                              title: "Đặt hàng thành công",
                                              desc:
                                                  "Đơn hàng đang chờ được xác nhận",
                                              buttons: [
                                                DialogButton(
                                                  onPressed: () {
                                                    Provider.of<CartViewModel>(
                                                            context,
                                                            listen: false)
                                                        .deleteAllCarts();
                                                    Navigator.pop(context);
                                                    Navigator.of(context).pop(
                                                        DialogsAction.cancel);
                                                    PersistentNavBarNavigator
                                                        .pushNewScreenWithRouteSettings(
                                                      context,
                                                      settings: RouteSettings(
                                                          name: '/'),
                                                      screen: MainPage(),
                                                      withNavBar: false,
                                                      pageTransitionAnimation:
                                                          PageTransitionAnimation
                                                              .cupertino,
                                                    );
                                                  },
                                                  color: Color.fromRGBO(
                                                      0, 179, 134, 1.0),
                                                  radius: BorderRadius.circular(
                                                      0.0),
                                                  child: Text(
                                                    "Tiếp tục",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20),
                                                  ),
                                                ),
                                              ],
                                            ).show();
                                          } else {
                                            Alert(
                                              context: context,
                                              type: AlertType.error,
                                              title: "LỖI ĐẶT HÀNG",
                                              desc:
                                                  "Đặt hàng không thành công ! Thử đăng nhập lại để đặt hàng",
                                              buttons: [
                                                DialogButton(
                                                  onPressed: () {
                                                    print('tat ');
                                                    Navigator.of(context,
                                                            rootNavigator: true)
                                                        .pop();
                                                    Navigator.of(context).pop(
                                                        DialogsAction.cancel);
                                                  },
                                                  width: 120,
                                                  child: Text(
                                                    "Tắt",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20),
                                                  ),
                                                )
                                              ],
                                            ).show();
                                          }

                                          // Navigator.of(context)
                                          //     .pop(DialogsAction.cancel);

                                          //-end --------------------
                                        },
                                        child: Text(
                                          "XÁC NHẬN",
                                          style: TextStyle(color: kWhiteColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      width: double.infinity,
                                      height: 45,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          "SAI ĐỊA CHỈ",
                                          style:
                                              TextStyle(color: kPrimaryColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width * 0.55,
                    padding: EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Đặt hàng",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ]),
                  ),
                );
              }),
            )
          ]),
        ],
      ),
    );
  }
}
