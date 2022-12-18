import 'package:app_food_mobile/components/empty_page.dart';
import 'package:app_food_mobile/repositories/auth_repository.dart';
import 'package:app_food_mobile/viewmodels/Users/user_view_model.dart';
import 'package:app_food_mobile/views/auth/login_page.dart';
import 'package:app_food_mobile/views/screens/cart/cart_page.dart';
import 'package:app_food_mobile/views/screens/order/order_detail.dart';
import 'package:app_food_mobile/views/screens/welcome/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../viewmodels/Carts/cart_view_model.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  bool _isLoading = true;
  bool isLogin = false;
  @override
  void initState() {
    // TODO: implement initState
    // super.initState();
    checkLogin();
    print(
        'orderPage: ${Provider.of<UserViewModel>(context, listen: false).currentUserModel.toString()}');
    checkOrders();
    print('duyen');
  }

  void checkOrders() async {
    Provider.of<UserViewModel>(context, listen: false).getOrders().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void checkLogin() async {
    print('duyen checddddddk');
    bool checkLogin =
        await Provider.of<UserViewModel>(context, listen: false).checkLogined();
    print(checkLogin);
    if (checkLogin) {
      setState(() {
        isLogin = true;
      });
    } else {
      setState(() {
        isLogin = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return (isLogin)
        ? Scaffold(
            backgroundColor: kGreyBackgroundColor,
            appBar: AppBar(
                title: Center(
              child: Text(
                "Lịch sử đơn hàng",
                style: TextStyle(color: kWhiteColor),
              ),
            )),
            body: Consumer<UserViewModel>(builder: (context, provider, child) {
              return (provider.ordersUserModel.isEmpty)
                  ? EmptyPage(
                      btnText: "Tạo đơn hàng",
                      content: "Bạn có muốn tạo giỏ hàng mới ?",
                      funcBtn: () {
                        PersistentNavBarNavigator
                            .pushNewScreenWithRouteSettings(
                          context,
                          settings: RouteSettings(name: '/cart'),
                          screen: CartPage(),
                          withNavBar: false,
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                      label: "Đơn hàng trống",
                    )
                  : SingleChildScrollView(
                      child: Consumer<UserViewModel>(
                        builder: (context, provider, child) {
                          return _isLoading
                              ? Center(child: CircularProgressIndicator())
                              : Container(
                                  color: kGreyBackgroundColor,
                                  padding: EdgeInsets.symmetric(
                                      vertical: defaultPadding),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: defaultPadding),
                                          child: Text(
                                            "Đơn hàng của bạn",
                                            textAlign: TextAlign.left,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3
                                                ?.apply(color: kBlackColor),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount:
                                              provider.ordersUserModel.length,
                                          itemBuilder: (context, index) {
                                            return ItemOrder(
                                              name: "FoodApp",
                                              price: provider
                                                  .ordersUserModel[index].price
                                                  .toInt(),
                                              quantity: 2,
                                              orderId: provider
                                                  .ordersUserModel[index].id,
                                              onTapped: () async {
                                                await provider
                                                    .getOrderItems(provider
                                                        .ordersUserModel[index]
                                                        .id)
                                                    .then((_) =>
                                                        // Navigator.push(
                                                        //   context,
                                                        //   MaterialPageRoute(
                                                        //       builder:
                                                        //           (context) =>
                                                        //               OrderDetail(
                                                        //                 orderId: provider.ordersUserModel[index].id,
                                                        //               )),
                                                        // )
                                                        PersistentNavBarNavigator
                                                            .pushNewScreenWithRouteSettings(
                                                          context,
                                                          settings: RouteSettings(
                                                              name:
                                                                  '/cart/detail'),
                                                          screen: OrderDetail(
                                                            orderId: provider
                                                                .ordersUserModel[
                                                                    index]
                                                                .id,
                                                          ),
                                                          withNavBar: false,
                                                          pageTransitionAnimation:
                                                              PageTransitionAnimation
                                                                  .cupertino,
                                                        ));
                                              },
                                            );
                                          },
                                        ),
                                      ]),
                                );
                        },
                      ),
                    );
            }))
        : WelcomeScreen();
  }
}

class ItemOrder extends StatelessWidget {
  const ItemOrder({
    Key? key,
    required this.name,
    required this.quantity,
    required this.price,
    required this.orderId,
    required this.onTapped,
  }) : super(key: key);
  final String name;
  final int quantity, price, orderId;
  final VoidCallback onTapped;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapped();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: defaulMargin),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: kDivideColor),
                left: BorderSide(color: kDivideColor),
                right: BorderSide(color: kDivideColor),
                top: BorderSide(color: kDivideColor)),
            color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: defaultPadding / 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/order_sucess.svg",
                        width: 20,
                        height: 20,
                        fit: BoxFit.scaleDown,
                        color: kGreyIconColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Đang giao"),
                    ],
                  ),
                  Text(name,
                      style: Theme.of(context)
                          .textTheme
                          .headline1
                          ?.apply(fontSizeFactor: 0.8)),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    price.toVND(),
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: kDivideColor)),
                  color: Colors.white),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: defaultPadding / 2),
                child: Center(
                  child: Text(
                    "Đặt lại",
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.apply(color: kPrimaryColor),
                  ),
                ),
              ),
            ),
            Divider(
              height: 0.5,
              color: kDivideColor,
            )
          ],
        ),
      ),
    );
  }
}
