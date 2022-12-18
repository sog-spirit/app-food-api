import 'dart:async';

import 'package:app_food_mobile/components/default_button.dart';
import 'package:app_food_mobile/constants.dart';
import 'package:app_food_mobile/models/productOrder.dart';
import 'package:app_food_mobile/viewmodels/Users/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../components/alert_dialog.dart';
import '../../../models/order_item.dart';
import '../../../models/user.dart';
import '../../pages/main_page.dart';

class OrderDetail extends StatefulWidget {
  OrderDetail({super.key, required this.orderId});
  final int orderId;

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  bool _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('check Order detail ${widget.orderId}');
    Provider.of<UserViewModel>(context, listen: false)
        .getOrderItems(widget.orderId)
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    setState(() {
      _isLoading = true;
    });
    List<OrderItem> orderItems =
        Provider.of<UserViewModel>(context, listen: false).orderItemUseModel;
    print('duyennnn: $orderItems');
    User? u =
        Provider.of<UserViewModel>(context, listen: false).currentUserModel;
    print('@@@@:" ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhiteColor,
        appBar: AppBar(
            title: Center(
          child: Text(
            "Chi tiết đơn hàng",
            style: TextStyle(color: kWhiteColor),
          ),
        )),
        body: (_isLoading)
            ? CircularProgressIndicator()
            : Consumer<UserViewModel>(
                builder: (context, provider, child) {
                  return Container(
                    height: double.infinity,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding, vertical: defaultPadding),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Food App",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            Text("19, Sep, 2022 11:48",
                                style: Theme.of(context).textTheme.headline3),
                            ListView.builder(
                              scrollDirection: Axis.vertical,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: provider.orderItemUseModel.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                      vertical: defaultPadding / 2),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 0.5, color: kDivideColor),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      //hinh anh
                                      SizedBox(
                                        height: 60,
                                        width: 60,
                                        child: AspectRatio(
                                          aspectRatio: 1,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            child: Image.network(
                                                provider
                                                    .orderItemUseModel[index]
                                                    .image,
                                                fit: BoxFit.fill),
                                          ),
                                        ),
                                      ),
                                      //so luong
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              child: Text(
                                                "x${provider.orderItemUseModel[index].quantity}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline3,
                                              ),
                                            ),
                                            //ten mon han
                                            Expanded(
                                              child: Text(
                                                provider
                                                    .orderItemUseModel[index]
                                                    .name,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline3
                                                    ?.apply(color: kBlackColor),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      //gia tien
                                      Container(
                                        margin:
                                            EdgeInsets.only(left: defaulMargin),
                                        child: Text(
                                            provider
                                                .orderItemUseModel[index].price
                                                .toInt()
                                                .toVND(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2
                                                ?.apply(color: kBlackColor)),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),

                            Divider(
                              color: kDivideColor,
                              height: 0.5,
                            ),
                            //container for tam tinh
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: defaultPadding / 2),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "Tạm tính (${provider.orderItemUseModel.length} món)",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5
                                              ?.apply(color: kBlackColor)),
                                      Text(
                                          provider.totalPriceOrderItem
                                              .toInt()
                                              .toVND(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5
                                              ?.apply(color: kBlackColor))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: defaultPadding / 2),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Giao hàng",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5
                                              ?.apply(
                                                  color: Color.fromARGB(
                                                      255, 210, 198, 89))),
                                      Text("10.000 đ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5
                                              ?.apply(
                                                  color: Color.fromARGB(
                                                      255, 210, 198, 89)))
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            Divider(
                              color: kDivideColor,
                              height: 0.5,
                            ),
                            // //total
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: defaultPadding),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Tổng cộng",
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  Text(
                                    (provider.totalPriceOrderItem.toInt() +
                                            10000)
                                        .toInt()
                                        .toVND(),
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              color: kDivideColor,
                              height: 0.5,
                            ),
                            // //thong tin chi tiet giao hàng
                            // Column(
                            //   children: [
                            //     Padding(
                            //       padding: const EdgeInsets.only(
                            //           top: defaultPadding / 2),
                            //       child: Row(
                            //         children: [
                            //           SizedBox(
                            //               width: 180,
                            //               child: Text("Mã đơn hàng")),
                            //           Text("1987562SSd")
                            //         ],
                            //       ),
                            //     ),
                            //     Padding(
                            //       padding: const EdgeInsets.only(
                            //           top: defaultPadding / 2),
                            //       child: Row(
                            //         children: [
                            //           SizedBox(width: 180, child: Text("Tên")),
                            //           Text(provider.currentUserModel!.name)
                            //         ],
                            //       ),
                            //     ),
                            //     Padding(
                            //       padding: const EdgeInsets.only(
                            //           top: defaultPadding / 2),
                            //       child: Row(
                            //         children: [
                            //           SizedBox(
                            //               width: 180,
                            //               child: Text("Số điện thoại")),
                            //           Text(provider.currentUserModel!.phone)
                            //         ],
                            //       ),
                            //     ),
                            //     Padding(
                            //       padding: const EdgeInsets.only(
                            //           top: defaultPadding / 2),
                            //       child: Row(
                            //         children: [
                            //           SizedBox(
                            //               width: 180, child: Text("Địa chỉ")),
                            //           Flexible(
                            //             child: Text(
                            //               provider.currentUserModel!.address,
                            //               softWrap: true,
                            //             ),
                            //           )
                            //         ],
                            //       ),
                            //     ),
                            //   ],
                            // ),

                            // SizedBox(
                            //   height: 20,
                            // ),
                            DefaultButton(
                              press: () async {
                                print('thuc hien dat lai gio hang');
                                final action = await showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        title: Text(
                                          "Đặt hàng",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.apply(color: kPrimaryColor),
                                        ),
                                        content: Text(
                                          "Bạn có muốn đặt lại hàng ? ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () async {
                                                print('dat hang');
                                                List<ProductOrder> lstOrders =
                                                    [];
                                                provider.orderItemUseModel
                                                    .forEach((item) => {
                                                          lstOrders.add(
                                                              new ProductOrder(
                                                                  product: item
                                                                      .product,
                                                                  quantity: item
                                                                      .quantity))
                                                        });

                                                // Navigator.of(context)
                                                //     .pop(DialogsAction.cancel);
                                                bool statusOrder =
                                                    await provider.order(
                                                        lstOrders, '');
                                                print(
                                                    'tinh trang dat hang $statusOrder');
                                                if (statusOrder) {
                                                  Alert(
                                                    context: context,
                                                    type: AlertType.success,
                                                    title:
                                                        "Đặt hàng thành công",
                                                    desc:
                                                        "Đơn hàng đang chờ được xác nhận",
                                                    buttons: [
                                                      DialogButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.of(context)
                                                              .pop(DialogsAction
                                                                  .cancel);
                                                        },
                                                        color: Color.fromRGBO(
                                                            0, 179, 134, 1.0),
                                                        radius: BorderRadius
                                                            .circular(0.0),
                                                        child: Text(
                                                          "Tiếp tục",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
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
                                                                  rootNavigator:
                                                                      true)
                                                              .pop();
                                                          Navigator.of(context)
                                                              .pop(DialogsAction
                                                                  .cancel);
                                                        },
                                                        width: 120,
                                                        child: Text(
                                                          "Tắt",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20),
                                                        ),
                                                      )
                                                    ],
                                                  ).show();
                                                }
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
                              },
                              text: "Đặt lại",
                            )
                          ]),
                    ),
                  );
                },
              ));
  }
}
