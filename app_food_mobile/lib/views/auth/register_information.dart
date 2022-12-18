// ignore_for_file: use_build_context_synchronously

import 'package:app_food_mobile/components/register_detail_form.dart';
import 'package:app_food_mobile/repositories/auth_repository.dart';
import 'package:app_food_mobile/views/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../components/social_card.dart';
import '../../constants.dart';

class RegisterInformationScreen extends StatefulWidget {
  const RegisterInformationScreen(
      {super.key, required this.username, required this.password});
  final String username;
  final String password;

  @override
  State<RegisterInformationScreen> createState() =>
      _RegisterInformationScreenState();
}

class _RegisterInformationScreenState extends State<RegisterInformationScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final String _dateOfBith = DateFormat('yyyy-MM-dd').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: kWhiteColor, //change your color here
        ),
        title: Text(
          'Đăng ký',
          style: Theme.of(context)
              .appBarTheme
              .textTheme
              ?.headline6
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: defaultPadding),
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
                child: Column(
              children: [
                //title
                Column(
                  children: [
                    Text(
                      "Chào mừng đến với FoodApp",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Text(
                      "Nhập thông tin cá nhân để đăng ký tài khoản",
                      style: Theme.of(context).textTheme.headline3,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                RegisterDetailForm(
                  register: () async {
                    print('register now');
                    print('usenrmae: ${_usernameController.text}');
                    print('password: ${widget.password}');
                    print('phone: ${_phoneController.text}');
                    print('name: ${_nameController.text}');
                    print('address: ${_addressController.text}');
                    print('date of birth: $_dateOfBith');
                    print('imageffffffff: chua co');

                    var result = await AuthRepo().registerRepo(
                        _usernameController.text,
                        widget.password,
                        _phoneController.text,
                        widget.username,
                        _addressController.text,
                        "2012-12-12",
                        "https://scontent-hkt1-2.xx.fbcdn.net/v/t39.30808-6/318559222_3418524198416379_8228542129927971455_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=730e14&_nc_ohc=Y2CIWBRUUDYAX-hm2s0&tn=dnua9bGbAzzhQBgf&_nc_ht=scontent-hkt1-2.xx&oh=00_AfD7M0Mws3dABKrxvjV_nZhyVNGZ2Cz_x-qPkdgJ7FAkrw&oe=63991621");
                    if (result) {
                      // ignore: use_build_context_synchronously
                      // Navigator.pushNamed(context, '/sign-in');
                      PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                        context,
                        settings: RouteSettings(name: '/sign-in'),
                        screen: LoginScreen(),
                        withNavBar: false,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
                    } else {
                      print('đăng ký không thành công');
                    }
                  },
                  addressController: _addressController,
                  phoneController: _phoneController,
                  usernameController: _usernameController,
                  nameController: _nameController,
                  dateOfBith: _dateOfBith,
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.08),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialCard(
                      icon: "assets/icons/google-icon.svg",
                      press: () {},
                    ),
                    SocialCard(
                      icon: "assets/icons/facebook-2.svg",
                      press: () {},
                    ),
                    SocialCard(
                      icon: "assets/icons/twitter.svg",
                      press: () {},
                    )
                  ],
                ),
                //no - account - text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Bạn đã có tài khoản?",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () async {
                        print('duyennnn');
                        //xu ly login
                      },
                      child: Text(
                        "Đăng nhập",
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            ?.apply(color: kPrimaryColor),
                      ),
                    ),
                  ],
                )
              ],
            )),
          ),
        ),
      ),
    );
  }
}
