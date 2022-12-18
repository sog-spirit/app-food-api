import 'package:app_food_mobile/constants.dart';
import 'package:app_food_mobile/repositories/auth_repository.dart';
import 'package:app_food_mobile/viewmodels/Carts/cart_view_model.dart';
import 'package:app_food_mobile/viewmodels/Users/user_view_model.dart';
import 'package:app_food_mobile/views/screens/cart/checkout_bottom.dart';
import 'package:app_food_mobile/views/screens/welcome/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../components/default_button.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool _isLoading = true;
  bool isLogin = false;
  TextEditingController addressController = new TextEditingController();

  @override
  void initState() {
    Provider.of<UserViewModel>(context, listen: false).getInfoUser().then((_) {
      Provider.of<CartViewModel>(context, listen: false)
          .fetchAndSetCart()
          .then((_) {
        setState(() {
          _isLoading = false;
          // _isLoading = true;
        });
      });
    });

    print('duyen');
    testcheckLogined();
    super.initState();
  }

  void getUser() async {
    await Provider.of<UserViewModel>(context, listen: false).getInfoUser();
    print(
        // ignore: use_build_context_synchronously
        'check currentUser: ${Provider.of<UserViewModel>(context, listen: false).currentUserModel.toString()}');
  }

  void testcheckLogined() async {
    print('duyen checddddddk');
    bool checkLogin =
        Provider.of<UserViewModel>(context, listen: false).statusLoginViewModel;
    print(checkLogin);
    if (checkLogin) {
      setState(() {
        isLogin = true;
        addressController.text =
            Provider.of<UserViewModel>(context, listen: false)
                .currentUserModel!
                .address;
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
    print('duyennn ${AuthRepo.isLogin}');
    return (isLogin)
        ? Scaffold(
            backgroundColor: kGreyBackgroundColor,
            appBar: AppBar(
                title: Center(
              child: Text("Trang thanh toán"),
            )),
            bottomNavigationBar: CheckoutBottomNavigator(
              address: addressController.text,
            ),
            body: Consumer<UserViewModel>(
              builder: (context, provider, child) {
                return (provider.statusLoginViewModel)
                    ? _isLoading
                        ? Container(
                            color: kWhiteColor,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : SizedBox(
                            width: double.infinity,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(children: [
                                //dia chi
                                Container(
                                  width: double.infinity,
                                  color: kWhiteColor,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: defaultPadding,
                                      vertical: defaultPadding),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          //hinh anh shipper
                                          //hinh anh
                                          SizedBox(
                                            width: 60,
                                            height: 60,
                                            child: AspectRatio(
                                              aspectRatio: 0.88,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5)),
                                                child: Image.asset(
                                                    'assets/images/shipper.png'),
                                              ),
                                            ),
                                          ),

                                          //dia chi
                                          Expanded(
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal:
                                                          defaultPadding / 2),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Địa chỉ giao hàng",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline5,
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                      text: provider
                                                          .currentUserModel!
                                                          .name,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline5,
                                                      children: <TextSpan>[
                                                        TextSpan(text: ' | '),
                                                        TextSpan(
                                                            text: provider
                                                                .currentUserModel!
                                                                .phone),
                                                      ],
                                                    ),
                                                  ),
                                                  Text(
                                                    addressController.text,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline5,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          //btn thay doi
                                          TextButton(
                                              style: TextButton.styleFrom(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .headline4
                                                    ?.apply(
                                                        color: kPrimaryColor,
                                                        fontWeightDelta: 3),
                                              ),
                                              onPressed: () {
                                                showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  builder: (context) =>
                                                      FractionallySizedBox(
                                                    heightFactor: 0.85,
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: double.infinity,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 30),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          10))),
                                                      child: Column(
                                                        children: [
                                                          Expanded(
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              10,
                                                                          vertical:
                                                                              5),
                                                                  child: Row(
                                                                    children: [
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              30,
                                                                          height:
                                                                              30,
                                                                          child:
                                                                              SvgPicture.asset(
                                                                            "assets/icons/Error.svg",
                                                                            height:
                                                                                14,
                                                                            width:
                                                                                14,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        child: Center(
                                                                            child: Text(
                                                                          "Thay đổi địa chỉ",
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 15),
                                                                        )),
                                                                      ),
                                                                      //input - edit
                                                                    ],
                                                                  ),
                                                                ),
                                                                Divider(
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          top:
                                                                              20),
                                                                  padding:
                                                                      EdgeInsets
                                                                          .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                  ),
                                                                  child:
                                                                      TextFormField(
                                                                    style: TextStyle(
                                                                        color:
                                                                            kBlackColor),
                                                                    controller:
                                                                        addressController,
                                                                    decoration:
                                                                        const InputDecoration(
                                                                      hintText:
                                                                          'Địa chỉ',
                                                                      labelText:
                                                                          'Địa chỉ',
                                                                    ),
                                                                    onSaved:
                                                                        (String?
                                                                            value) {},
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    defaultPadding),
                                                            child:
                                                                DefaultButton(
                                                              press: () async {
                                                                Navigator.pop(
                                                                    context);
                                                                setState(() {
                                                                  addressController
                                                                          .text =
                                                                      addressController
                                                                          .text;
                                                                });
                                                              },
                                                              text: "Lưu",
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  context: context,
                                                );
                                              },
                                              child: const Text('Thay đổi',
                                                  style: TextStyle(
                                                      color: kPrimaryColor))),
                                        ],
                                      ),
                                    ],
                                  ),
                                  //btn
                                ),
                                SizedBox(
                                  height: 20,
                                ),

                                //list don hang
                                Consumer<CartViewModel>(
                                  builder: (context, provider, child) {
                                    return Container(
                                      color: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: defaultPadding,
                                          vertical: defaultPadding),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            width: double.infinity,
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Đơn hàng của bạn",
                                                    textAlign: TextAlign.left,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline3,
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  ListView.builder(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount: provider
                                                        .cartListModel.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Item_Checkout_Product(
                                                        proName: provider
                                                            .cartListModel[
                                                                index]
                                                            .name,
                                                        proPrice: provider
                                                            .cartListModel[
                                                                index]
                                                            .price,
                                                        proQuantity: provider
                                                            .cartListModel[
                                                                index]
                                                            .quantity,
                                                        proImage: provider
                                                            .cartListModel[
                                                                index]
                                                            .image,
                                                      );
                                                    },
                                                  ),
                                                ]),
                                          ),

                                          Divider(
                                            color: kDivideColor,
                                            height: 0.8,
                                          ),

                                          Divider(
                                              color: kHoverSecondaryColor,
                                              height: 0.5),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          //summary price
                                          Container(
                                              child: Column(children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Tạm tính (1 món)",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline4,
                                                ),
                                                Text(
                                                  provider.totalPrice
                                                      .toInt()
                                                      .toVND(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline4,
                                                )
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Phí ship",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline4,
                                                ),
                                                Text(
                                                  "10.000d",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline4,
                                                )
                                              ],
                                            )
                                          ])),

                                          SizedBox(
                                            height: defaultSizeboxHeight,
                                          ),

                                          //   height: 100,
                                          //   color: Colors.green,
                                          //   width: double.infinity,
                                          //   margin: EdgeInsets.only(right: 20),
                                          //   child: Container(
                                          //     height: 100,
                                          //     child: ListView.builder(
                                          //       scrollDirection: Axis.horizontal,
                                          //       itemCount: 4,
                                          //       itemBuilder: (context, index) => Container(
                                          //         width: 250,
                                          //         height: 300,
                                          //         decoration: BoxDecoration(
                                          //             borderRadius: BorderRadius.circular(6),
                                          //             color: Colors.white,
                                          //             boxShadow: [
                                          //               BoxShadow(
                                          //                 color: Colors.grey
                                          //                     .withOpacity(0.2), //color of shadow
                                          //                 spreadRadius: 2, //spread radius
                                          //                 blurRadius: 10, // blur radius
                                          //                 offset: Offset(0, 2),
                                          //               )
                                          //             ]),
                                          //         margin: EdgeInsets.only(right: 15),
                                          //         child: Row(children: [
                                          //           Container(
                                          //             width: 10,
                                          //             clipBehavior: Clip.none,
                                          //             height: double.infinity,
                                          //             decoration: BoxDecoration(
                                          //               borderRadius: BorderRadius.only(
                                          //                   topLeft: Radius.circular(
                                          //                       defaultBorderRadius),
                                          //                   bottomLeft: Radius.circular(
                                          //                       defaultBorderRadius)),
                                          //               color: kPrimaryColor,
                                          //             ),
                                          //           ),
                                          //           SizedBox(
                                          //             width: 10,
                                          //           ),
                                          //           Column(
                                          //             crossAxisAlignment: CrossAxisAlignment.start,
                                          //             mainAxisAlignment: MainAxisAlignment.center,
                                          //             children: [
                                          //               //id voucher
                                          //               Text(
                                          //                 "MOMOT1222",
                                          //                 style: Theme.of(context)
                                          //                     .textTheme
                                          //                     .titleSmall,
                                          //               ),
                                          //               //name voucher
                                          //               Text("MOMO Khao Tới 50K x 30 lần"),
                                          //               //hsd
                                          //               Text("HSD: 31.12.2022"),
                                          //             ],
                                          //           )
                                          //         ]),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                //san pham tuong tu
                                // Container(
                                //   width: double.infinity,
                                //   padding: EdgeInsets.symmetric(
                                //       vertical: 15, horizontal: defaultPadding),
                                //   margin: EdgeInsets.only(bottom: defaulMargin),
                                //   child: Column(
                                //       crossAxisAlignment:
                                //           CrossAxisAlignment.start,
                                //       children: [
                                //         Text(
                                //           "Chọn thêm sản phẩm",
                                //           style: Theme.of(context)
                                //               .textTheme
                                //               .headline2,
                                //         ),
                                //         SizedBox(
                                //           height: defaultSizeboxHeight,
                                //         ),
                                //         Container(
                                //           height: 100,
                                //           child: ListView.builder(
                                //             scrollDirection: Axis.horizontal,
                                //             itemCount: 2,
                                //             itemBuilder: (context, index) =>
                                //                 Item_More_Product_Checkout(),
                                //           ),
                                //         )
                                //       ]),
                                // ),

                                //vocher
                                // Container(
                              ]),
                            ),
                          )
                    : Text('Chua dang nhap');
              },
            ),
          )
        : WelcomeScreen();
  }
}

class Item_More_Product_Checkout extends StatelessWidget {
  const Item_More_Product_Checkout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 100,
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.only(right: 30),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2), //color of shadow
              spreadRadius: 2, //spread radius
              blurRadius: 10, // blur radius
              offset: Offset(0, 2),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(children: [
        //hinh anh
        SizedBox(
          height: double.infinity,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
              child: Image.network(
                  "https://nghebep.com/wp-content/uploads/2017/11/mon-chan-ga-nuong-muoi-ot.jpg",
                  height: 60,
                  fit: BoxFit.fill),
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8),
            child: Row(children: [
              //ten san pham  + gia
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Phở tái",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        Text(
                          "Noodle",
                        )
                      ],
                    ),
                    Text(
                      "40.000 d",
                    )
                  ],
                ),
              ),
              //them vao gio hang
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: kPrimaryColor, shape: BoxShape.circle),
                    child: SizedBox(
                        height: 14,
                        width: 14,
                        child: SvgPicture.asset(
                          "assets/icons/Plus Icon.svg",
                          color: Colors.white,
                        )),
                  )
                ],
              )
            ]),
          ),
        )
      ]),
    );
  }
}

// ignore: camel_case_types
class Item_Checkout_Product extends StatelessWidget {
  const Item_Checkout_Product({
    Key? key,
    required this.proName,
    required this.proPrice,
    required this.proQuantity,
    required this.proImage,
  }) : super(key: key);
  final String proName, proImage;
  final double proPrice;
  final int proQuantity;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 15),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: [
            //so luong
            Text("$proQuantity x"),
            SizedBox(
              width: 10,
            ),
            //hinh anh
            SizedBox(
              width: 50,
              height: 50,
              child: AspectRatio(
                aspectRatio: 0.88,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(proImage, height: 50, fit: BoxFit.fill),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            //ten mon
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  proName,
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  "Local noodle",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            )
          ],
        ),
        Row(
          children: [
            Text(
              proPrice.toInt().toVND(),
              style: Theme.of(context).textTheme.headline3,
            ),
            SizedBox(
              width: 10,
            ),
            SizedBox(
                height: 14,
                width: 14,
                child: SvgPicture.asset(
                  "assets/icons/Error.svg",
                  color: kPrimaryColor,
                ))
          ],
        )
      ]),
    );
  }
}
