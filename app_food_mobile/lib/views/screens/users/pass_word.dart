import 'package:app_food_mobile/components/default_button.dart';
import 'package:app_food_mobile/constants.dart';
import 'package:app_food_mobile/viewmodels/Users/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../components/alert_dialog.dart';
import '../../../components/custom_surfix_icon.dart';
import '../../pages/main_page.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final TextEditingController currentPWControll = new TextEditingController();
  final TextEditingController newPWControll = new TextEditingController();
  final TextEditingController confirmPWControll = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
        child: Text(
          "Xác nhận mật khẩu",
        ),
      )),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(children: [
                      Text(
                        "Nhập mật khẩu",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Vui lòng nhập mật khẩu xác nhận thông tin tài khoản",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: ksecondaryColor),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      //mat khau hien tai
                      TextFormField(
                        obscureText: true,
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            ?.apply(color: kBlackColor),
                        controller: currentPWControll,
                        decoration: InputDecoration(
                          labelText: "Mật khẩu",
                          hintText: "Nhập mật khẩu  hiện tại",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: CustomSurffixIcon(
                              svgIcon: "assets/icons/Lock.svg"),
                        ),
                      ),

                      SizedBox(
                        height: defaulMargin,
                      ),
                      //mat khau moi
                      TextFormField(
                        obscureText: true,
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            ?.apply(color: kBlackColor),
                        controller: newPWControll,
                        decoration: InputDecoration(
                          labelText: "Mật khẩu mới",
                          hintText: "Nhập mật khẩu mới ",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: CustomSurffixIcon(
                              svgIcon: "assets/icons/Lock.svg"),
                        ),
                      ),
                      SizedBox(
                        height: defaulMargin,
                      ),
                      //xac nhan mat khau moi
                      TextFormField(
                        obscureText: true,
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            ?.apply(color: kBlackColor),
                        controller: confirmPWControll,
                        decoration: InputDecoration(
                          labelText: "Xác nhận mật khẩu mới",
                          hintText: "Xác nhận mật khẩu mới",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: CustomSurffixIcon(
                              svgIcon: "assets/icons/Lock.svg"),
                        ),
                      )
                    ]),
                  ),
                ),
              ),
              DefaultButton(
                text: "Tiếp tục",
                press: () async {
                  if (newPWControll.text.isEmpty |
                      confirmPWControll.text.isEmpty |
                      currentPWControll.text.isEmpty) {
                    Alert(
                      context: context,
                      type: AlertType.error,
                      title: "LỖI",
                      desc: "Thông tin không hợp lệ",
                      buttons: [
                        DialogButton(
                          onPressed: () => Navigator.pop(context),
                          width: 120,
                          child: Text(
                            "Quay lại",
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                ?.apply(color: kWhiteColor),
                          ),
                        )
                      ],
                    ).show();
                  } else if (newPWControll.text != confirmPWControll.text) {
                    Alert(
                      context: context,
                      type: AlertType.error,
                      title: "LỖI",
                      desc: "Mật khẩu mới không khớp nhau",
                      buttons: [
                        DialogButton(
                          onPressed: () => Navigator.pop(context),
                          width: 120,
                          child: Text(
                            "Quay lại",
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                ?.apply(color: kWhiteColor),
                          ),
                        )
                      ],
                    ).show();
                  } else {
                    print('thuc hien thay doi mat khau');
                    bool statusUpdate =
                        await Provider.of<UserViewModel>(context, listen: false)
                            .updatePassword(
                                currentPWControll.text, newPWControll.text);
                    print('tinh trang update: $statusUpdate');
                    if (statusUpdate) {
                      print('thanh cong');
                      Alert(
                        context: context,
                        type: AlertType.success,
                        title: "THÀNH CÔNG",
                        desc: "Bạn đã đổi mật khẩu thành công",
                        buttons: [
                          DialogButton(
                            onPressed: () {
                              Navigator.pop(context);
                              currentPWControll.text = '';
                              newPWControll.text = '';
                              confirmPWControll.text = '';
                            },
                            color: Color.fromRGBO(0, 179, 134, 1.0),
                            radius: BorderRadius.circular(0.0),
                            child: Text(
                              "Tiếp tục",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ],
                      ).show();
                    } else {
                      Alert(
                        context: context,
                        type: AlertType.error,
                        title: "CẬP NHẬT KHÔNG THÀNH CÔNG",
                        desc: "Thử lại bằng cách đăng nhập",
                        buttons: [
                          DialogButton(
                            onPressed: () => Navigator.pop(context),
                            width: 120,
                            child: Text(
                              "Quay lại",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3
                                  ?.apply(color: kWhiteColor),
                            ),
                          )
                        ],
                      ).show();
                    }
                  }
                },
              )
            ],
          )),
    );
  }
}
