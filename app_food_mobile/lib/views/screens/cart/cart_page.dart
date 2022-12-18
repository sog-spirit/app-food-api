import 'package:app_food_mobile/models/user.dart';
import 'package:app_food_mobile/viewmodels/Carts/cart_view_model.dart';
import 'package:app_food_mobile/components/alert_dialog.dart';
import 'package:app_food_mobile/viewmodels/Users/user_view_model.dart';
import 'package:app_food_mobile/views/pages/main_page.dart';
import 'package:app_food_mobile/views/screens/cart/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import '../../../components/empty_page.dart';
import '../../../constants.dart';
import '../../../models/cart.dart';
import '../../../repositories/auth_repository.dart';
import '../../auth/login_page.dart';
import 'cart_item.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List<Cart> listCart = [];
  late bool isExistedCart;
  late bool isLogin;
  @override
  void initState() {
    setState(() {
      isLogin = false;
    });
    testcheckLogined();

    CartViewModel cartViewModel =
        Provider.of<CartViewModel>(context, listen: false);
    if (cartViewModel.cartListModel.isEmpty) {
      setState(() {
        isExistedCart = false;
      });
    } else {
      setState(() {
        isExistedCart = true;
      });
    }
    super.initState();
  }

  void testcheckLogined() async {
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
  void dipose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Center(
            child: Text(
              "Giỏ hàng",
              style: TextStyle(color: kWhiteColor),
            ),
          )),
      body: Consumer<CartViewModel>(
        builder: ((context, provider, child) {
          return (provider.cartListModel.isEmpty)
              ? EmptyPage(
                  label: "Giỏ hàng rỗng",
                  content: "Giỏ hàng của bạn hiện tại không có sản phẩm nào",
                  btnText: "Mua ngay",
                  funcBtn: () {
                    // Navigator.pop(context);
                    PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                      context,
                      settings: RouteSettings(name: '/'),
                      screen: MainPage(),
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        // hiển thị xác nhận xóa hết giỏ hàng
                        final action = await AlertDialogs.yesCancelDialog(
                            context,
                            "Xóa giỏ hàng",
                            "Bạn muốn xóa toàn bộ giỏ hàng ? ");
                        if (action == DialogsAction.yes) {
                          // ignore: use_build_context_synchronously
                          await Provider.of<CartViewModel>(context,
                                  listen: false)
                              .deleteAllCarts();
                        }
                      },
                      child: const Text('Xóa hết giỏ hàng'),
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: (provider.cartListModel.isNotEmpty)
                            ? provider.cartListModel.length
                            : 1,
                        itemBuilder: (context, index) {
                          Cart cart = provider.cartListModel[index];
                          return CartItem(
                              cartId: 1,
                              productImgUrl: cart.image,
                              productName: cart.name,
                              productQuantity: cart.quantity,
                              price: cart.price.toInt(),
                              productId: cart.productId);
                        },
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: defaultPadding * 1.3),
                        backgroundColor: kPrimaryColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                        ),
                      ),
                      onPressed: () async {
                        // Navigator.pushNamed(context, "/cart/checkout");

                        print('thanh toan');
                        // var isExistedUser =
                        //     Provider.of<UserViewModel>(context, listen: false)
                        //         .isLogin();
                        bool isLogin =
                            Provider.of<UserViewModel>(context, listen: false)
                                .statusLoginViewModel;
                        print('tinh trang login: $isLogin');
                        if (isLogin) {
                          PersistentNavBarNavigator
                              .pushNewScreenWithRouteSettings(
                            context,
                            settings: RouteSettings(name: '/cart/checkout'),
                            screen: CheckoutPage(),
                            withNavBar: false,
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          );
                        } else {
                          print('ban phai dang nhap');
                          final action = await showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  title: Text(
                                    "Lỗi chưa đăng nhập",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.apply(color: kPrimaryColor),
                                  ),
                                  content: Text(
                                    "Bạn có muốn đăng nhập không ?",
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          print('dan den trang dang nhap');
                                          PersistentNavBarNavigator
                                              .pushNewScreenWithRouteSettings(
                                            context,
                                            settings:
                                                RouteSettings(name: '/sign-in'),
                                            screen: LoginScreen(),
                                            withNavBar: true,
                                            pageTransitionAnimation:
                                                PageTransitionAnimation
                                                    .cupertino,
                                          );
                                        },
                                        child: Text("Xác nhận")),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(DialogsAction.cancel);
                                        },
                                        child: Text("Hủy bỏ")),
                                  ],
                                );
                              });

                          return (action != null)
                              ? action
                              : DialogsAction.cancel;
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${provider.totalProduct} Món",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                              Text(
                                "Thanh toán",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                              Text(
                                provider.totalPrice.toVND(),
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ]),
                      ),
                    )
                  ],
                );
        }),
      ),
    );
  }

  Future<void> doNothing(BuildContext context) async {}
}
