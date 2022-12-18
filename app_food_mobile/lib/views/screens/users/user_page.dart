import 'package:app_food_mobile/constants.dart';
import 'package:app_food_mobile/repositories/auth_repository.dart';
import 'package:app_food_mobile/viewmodels/Users/user_view_model.dart';
import 'package:app_food_mobile/views/pages/auth_page.dart';
import 'package:app_food_mobile/views/pages/main_page.dart';
import 'package:app_food_mobile/views/screens/cart/cart_page.dart';
import 'package:app_food_mobile/views/screens/home/home_page.dart';
import 'package:app_food_mobile/views/screens/order/order_page.dart';
import 'package:app_food_mobile/views/screens/users/user_profile.dart';
import 'package:app_food_mobile/views/screens/welcome/welcome_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool isLogin = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      isLogin = false;
    });
    testcheckLogined();
  }

  void testcheckLogined() async {
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
    return (isLogin)
        ? Consumer<UserViewModel>(
            builder: (context, provider, child) {
              // ignore: unnecessary_null_comparison
              return (provider.statusLoginViewModel &&
                      provider.currentUserModel != null)
                  ? Scaffold(
                      appBar: AppBar(
                          backgroundColor: kPrimaryColor,
                          title: Center(
                            child: Text(
                              "Thông tin tài khoản",
                              style: TextStyle(color: kWhiteColor),
                            ),
                          )),
                      body: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // ava - usename
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(defaultPadding),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: kDivideColor,
                                  width: 0.5,
                                ),
                              ),
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //hinh anh
                                  SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: ClipOval(
                                      child: SizedBox.fromSize(
                                        size:
                                            Size.fromRadius(48), // Image radius
                                        child: Image.network(
                                            'https://el.tvu.edu.vn/images/avatar/no-avatar.png',
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                  //username
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: defaultPadding),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          //username
                                          Text(
                                            (() {
                                              if (isLogin) {
                                                return provider
                                                    .currentUserModel!.name;
                                              }

                                              return "Đăng nhập";
                                            })(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.apply(color: kPrimaryColor),
                                          ),
                                          //name
                                          Text(
                                            (() {
                                              if (isLogin) {
                                                return provider
                                                    .currentUserModel!.username;
                                              }

                                              return "Chưa có tài khoản đăng nhập";
                                            })(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4,
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ]),
                          ),
                          //list icon
                          Container(
                            width: double.infinity,
                            height: 80,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: kDivideColor,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  //don hang
                                  Expanded(
                                    flex: 1,
                                    child: IconManage(
                                      svgIcon: "Cart Icon.svg",
                                      textIcon: "Giỏ hàng",
                                      funcManage: () {
                                        // Navigator.pushNamed(context, '/cart');
                                        PersistentNavBarNavigator
                                            .pushNewScreenWithRouteSettings(
                                          context,
                                          settings:
                                              RouteSettings(name: '/cart'),
                                          screen: CartPage(),
                                          withNavBar: false,
                                          pageTransitionAnimation:
                                              PageTransitionAnimation.cupertino,
                                        );
                                      },
                                    ),
                                  ),
                                  //quan yeu thich
                                  Expanded(
                                    flex: 1,
                                    child: IconManage(
                                      svgIcon: "heart.svg",
                                      textIcon: "Quán yêu thích",
                                      funcManage: () {
                                        // Navigator.pushNamed(context, '/profile');
                                        PersistentNavBarNavigator
                                            .pushNewScreenWithRouteSettings(
                                          context,
                                          settings:
                                              RouteSettings(name: '/profile'),
                                          screen: UserProfile(),
                                          withNavBar: true,
                                          pageTransitionAnimation:
                                              PageTransitionAnimation.cupertino,
                                        );
                                      },
                                    ),
                                  ),
                                  //dia chi
                                  Expanded(
                                    flex: 1,
                                    child: IconManage(
                                      svgIcon: "location.svg",
                                      textIcon: "Địa chỉ",
                                      funcManage: () {
                                        print('dia chi');
                                      },
                                    ),
                                  ),
                                ]),
                          ),
                          //lst manager
                          Expanded(
                            child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    horizontal: defaultPadding),
                                height: 200,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: kDivideColor,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    ItemManage(
                                      textMng: "Ví voucher",
                                      iconMng: "wallet.svg",
                                      funcMng: () {
                                        // Navigator.pushNamed(context, '/profile');
                                        PersistentNavBarNavigator
                                            .pushNewScreenWithRouteSettings(
                                          context,
                                          settings:
                                              RouteSettings(name: '/profile'),
                                          screen: UserProfile(),
                                          withNavBar: true,
                                          pageTransitionAnimation:
                                              PageTransitionAnimation.cupertino,
                                        );
                                      },
                                    ),
                                    ItemManage(
                                      textMng: "Lịch sử đơn hàng",
                                      iconMng: "list_oders.svg",
                                      funcMng: () {
                                        // Navigator.pushNamed(context, '/orders');
                                        PersistentNavBarNavigator
                                            .pushNewScreenWithRouteSettings(
                                          context,
                                          settings:
                                              RouteSettings(name: '/orders'),
                                          screen: OrderPage(),
                                          withNavBar: true,
                                          pageTransitionAnimation:
                                              PageTransitionAnimation.cupertino,
                                        );
                                      },
                                    ),
                                    ItemManage(
                                      textMng: "Thông tin cá nhân",
                                      iconMng: "user.svg",
                                      funcMng: () {
                                        // Navigator.pushNamed(context, '/profile');
                                        PersistentNavBarNavigator
                                            .pushNewScreenWithRouteSettings(
                                          context,
                                          settings:
                                              RouteSettings(name: '/profile'),
                                          screen: UserProfile(),
                                          withNavBar: false,
                                          pageTransitionAnimation:
                                              PageTransitionAnimation.cupertino,
                                        );
                                      },
                                    ),
                                  ],
                                )),
                          ),
                          GestureDetector(
                            onTap: () async {
                              AuthRepo.isLogin = false;
                              await Provider.of<UserViewModel>(context,
                                      listen: false)
                                  .logout()
                                  .then((_) {
                                // Navigator.of(context).pushAndRemoveUntil(
                                //   CupertinoPageRoute(
                                //     builder: (BuildContext context) {
                                //       return MainPage();
                                //     },
                                //   ),
                                //   (_) => false,
                                // );
                                // Navigator.of(context).pushAndRemoveUntil(
                                //   CupertinoPageRoute(
                                //     builder: (BuildContext context) {
                                //       return MainPage();
                                //     },
                                //   ),
                                //   (_) => false,
                                // );
                              });
                              print('da bam log out');
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: defaultPadding,
                                  horizontal: defaultPadding),
                              decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: kDivideColor,
                                      width: 0.5,
                                    ),
                                  ),
                                  color: kPrimaryColor),
                              child: Row(
                                children: [
                                  //icon
                                  SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: SvgPicture.asset(
                                      "assets/icons/log_out.svg",
                                      height: 14,
                                      width: 14,
                                      color: kWhiteColor,
                                    ),
                                  ),
                                  //text
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: defaultPadding),
                                    child: Text(
                                      "Đăng xuất",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4
                                          ?.apply(color: kWhiteColor),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : WelcomeScreen();
            },
          )
        : WelcomeScreen();
  }
}

class ItemManage extends StatelessWidget {
  const ItemManage({
    Key? key,
    required this.textMng,
    required this.iconMng,
    required this.funcMng,
  }) : super(key: key);
  final String textMng;
  final String iconMng;
  final Function funcMng;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        funcMng();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: kDivideColor,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            //icon
            SizedBox(
              width: 25,
              height: 25,
              child: SvgPicture.asset(
                "assets/icons/$iconMng",
                height: 14,
                width: 14,
              ),
            ),
            //text
            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: Text(
                textMng,
                style: Theme.of(context).textTheme.headline4,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class IconManage extends StatelessWidget {
  const IconManage({
    Key? key,
    required this.textIcon,
    required this.svgIcon,
    required this.funcManage,
  }) : super(key: key);
  final String textIcon;
  final String svgIcon;
  final Function funcManage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        funcManage();
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: kDivideColor,
              width: 0.5,
            ),
          ),
        ),
        height: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //icon
              SizedBox(
                width: 30,
                height: 30,
                child: SvgPicture.asset(
                  "assets/icons/$svgIcon",
                  height: 14,
                  width: 14,
                ),
              ),
              //text
              Text(
                textIcon,
                style: Theme.of(context).textTheme.headline4,
              )
            ]),
      ),
    );
  }
}
