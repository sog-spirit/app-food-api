import 'package:app_food_mobile/components/default_button.dart';
import 'package:app_food_mobile/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../components/custom_surfix_icon.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
        child: Text(
          "Cập nhật mật khẩu ",
          style: TextStyle(color: Colors.black),
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
                      "Vui lòng nhập mật khẩu mới",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: ksecondaryColor),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Mật khẩu mới",
                        hintText: "Nhập mật khẩu mới của bạn",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon:
                            CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Xác nhận mật khẩu",
                        hintText: "Xác nhận mật khẩu mới của bạn",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon:
                            CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
                      ),
                    ),
                  ]),
                ),
              ),
              DefaultButton(
                text: "Tiếp tục",
                press: () {
                  // Navigator.pushNamed(context, '/profile/change-password');
                  PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                    context,
                    settings: RouteSettings(name: '/profile/change-password'),
                    screen: ChangePasswordPage(),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
              )
            ],
          )),
    );
  }
}
