// ignore_for_file: use_build_context_synchronously

import 'package:app_food_mobile/views/screens/users/pass_word.dart';
import 'package:app_food_mobile/views/screens/users/phone_number_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../viewmodels/Users/user_view_model.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool _isLoading = true;
  final TextEditingController currenController =
      TextEditingController(text: '');
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  @override
  void initState() {
    super.initState();
    Provider.of<UserViewModel>(context, listen: false).getInfoUser().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
                title: Center(
              child: Text(
                "Thông tin tài khoản",
                style: TextStyle(color: kWhiteColor),
              ),
            )),
            body: Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Consumer<UserViewModel>(
                    builder: ((context, provider, child) {
                      nameController.text = provider.currentUserModel!.name;
                      phoneController.text = provider.currentUserModel!.phone;
                      emailController.text = provider.currentUserModel!.email;
                      addressController.text =
                          provider.currentUserModel!.address;
                      dateOfBirthController.text = '27/04/2002';
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //avatar
                            Stack(
                              children: [
                                Container(
                                  width: 130,
                                  height: 130,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 4, color: Colors.white),
                                      boxShadow: [
                                        BoxShadow(
                                            spreadRadius: 2,
                                            blurRadius: 10,
                                            color:
                                                Colors.black.withOpacity(0.1))
                                      ],
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              'https://udaceba.cat/wp-content/uploads/2018/06/no-avatar.jpg'))),
                                ),
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          side: BorderSide(color: Colors.white),
                                        ),
                                        primary: Colors.white,
                                        backgroundColor: Color(0xFFF5F6F9),
                                      ),
                                      onPressed: () {},
                                      child: SvgPicture.asset(
                                          "assets/icons/Camera Icon.svg"),
                                    ),
                                  ),
                                )
                              ],
                            ),

                            Text(provider.currentUserModel!.username),
                            //truong my duyen dang fix bug
                            //name input
                            SizedBox(height: 15),
                            BuildTextField(
                              labelText: "Tên",
                              controller: nameController,
                              iconText: "person.svg",
                              editTex: () {
                                currenController.text =
                                    provider.currentUserModel!.name;
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  builder: (context) => FractionallySizedBox(
                                    heightFactor: 0.85,
                                    child: Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 30),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10))),
                                      child: BoxModelChangeInfo(
                                        textController: currenController,
                                        labelInfo: "tên",
                                        funcUpdateInfo: () async {
                                          print(currenController.text);
                                        },
                                        textInfo:
                                            provider.currentUserModel!.name,
                                      ),
                                    ),
                                  ),
                                  context: context,
                                );
                              },
                            ),

                            //numberphone
                            SizedBox(height: 15),
                            BuildTextField(
                              controller: phoneController,
                              labelText: "Số điện thoại",
                              iconText: "phone-solid.svg",
                              editTex: () {
                                PersistentNavBarNavigator
                                    .pushNewScreenWithRouteSettings(
                                  context,
                                  settings:
                                      RouteSettings(name: '/food-category'),
                                  screen: PhoneNumberPage(),
                                  withNavBar: false,
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.cupertino,
                                );
                              },
                            ),
                            SizedBox(height: 15),
                            //email
                            BuildTextField(
                              controller: emailController,
                              labelText: "Địa chỉ Email",
                              iconText: "Mail.svg",
                              editTex: () {
                                print('kong the thay dodoi');
                                Alert(
                                  context: context,
                                  type: AlertType.error,
                                  title: "LỖI",
                                  desc: "Không thể thay đổi email người dùng!",
                                  buttons: [
                                    DialogButton(
                                      onPressed: () => Navigator.pop(context),
                                      color: kPrimaryColor,
                                      width: 120,
                                      child: Text(
                                        "Quay lại",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4
                                            ?.apply(color: kWhiteColor),
                                      ),
                                    )
                                  ],
                                ).show();
                              },
                            ),

                            SizedBox(height: 15),
                            //male/female
                            BuildTextField(
                              controller: addressController,
                              labelText: "Địa chỉ",
                              iconText: "Location point.svg",
                              editTex: () {
                                currenController.text =
                                    provider.currentUserModel!.address;
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  builder: (context) => FractionallySizedBox(
                                    heightFactor: 0.85,
                                    child: Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 30),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10))),
                                      child: BoxModelChangeInfo(
                                        textController: currenController,
                                        funcUpdateInfo: () {},
                                        textInfo:
                                            provider.currentUserModel!.address,
                                        labelInfo: 'địa chỉ',
                                      ),
                                    ),
                                  ),
                                  context: context,
                                );
                              },
                            ),

                            SizedBox(height: 15),
                            // //number input
                            // BuildTextField(
                            //   controller: TextEditingController(),
                            //   labelText: "Ngày sinh",
                            //   iconText: 'date-of-birth.svg',
                            //   editTex: () {
                            //     showModalBottomSheet(
                            //       isScrollControlled: true,
                            //       builder: (context) => FractionallySizedBox(
                            //         heightFactor: 0.85,
                            //         child: Container(
                            //           width: double.infinity,
                            //           height: double.infinity,
                            //           padding:
                            //               EdgeInsets.symmetric(vertical: 30),
                            //           decoration: BoxDecoration(
                            //               borderRadius: BorderRadius.only(
                            //                   topLeft: Radius.circular(10),
                            //                   topRight: Radius.circular(10))),
                            //           child: BoxModalDateOfBirth(),
                            //         ),
                            //       ),
                            //       context: context,
                            //     );
                            //   },
                            // ),

                            // SizedBox(height: 15),
                            DefaultButton(
                              press: () {
                                // Navigator.pushNamed(
                                //     context, '/profile/password');
                                PersistentNavBarNavigator
                                    .pushNewScreenWithRouteSettings(
                                  context,
                                  settings:
                                      RouteSettings(name: '/profile/password'),
                                  screen: PasswordPage(),
                                  withNavBar: true,
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.cupertino,
                                );
                              },
                              text: "Đổi mật khẩu",
                            ),
                          ]);
                    }),
                  ),
                )));
  }
}

class BoxModalDateOfBirth extends StatefulWidget {
  const BoxModalDateOfBirth({
    Key? key,
  }) : super(key: key);

  @override
  State<BoxModalDateOfBirth> createState() => _BoxModalDateOfBirthState();
}

class _BoxModalDateOfBirthState extends State<BoxModalDateOfBirth> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: kWhiteColor,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          child: SvgPicture.asset(
                            "assets/icons/Error.svg",
                            height: 14,
                            width: 14,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                            child: Text(
                          "Thay đổi ngày sinh nhật",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        )),
                      ),
                      //input - edit
                    ],
                  ),
                ),
                Divider(
                  color: Colors.black,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: TextFormField(
                    initialValue: "Duyen",
                    decoration: const InputDecoration(
                      hintText: 'Ten',
                      labelText: 'Tên',
                    ),
                    onSaved: (String? value) {},
                  ),
                ),
                SizedBox(
                  height: 250,
                  child: ScrollDatePicker(
                    selectedDate: _selectedDate,
                    locale: Locale('en'),
                    onDateTimeChanged: (DateTime value) {
                      setState(() {
                        _selectedDate = value;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: defaultPadding,
          ),
          child: DefaultButton(
            press: () {},
            text: "Lưu",
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class BoxModelChangeInfo extends StatelessWidget {
  const BoxModelChangeInfo({
    Key? key,
    required this.funcUpdateInfo,
    required this.textInfo,
    required this.labelInfo,
    required this.textController,
  }) : super(key: key);
  final VoidCallback funcUpdateInfo;
  final String textInfo, labelInfo;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        child: SvgPicture.asset(
                          "assets/icons/Error.svg",
                          height: 14,
                          width: 14,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                          child: Text(
                        "Thay đổi $labelInfo",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: kBlackColor),
                      )),
                    ),
                    //input - edit
                  ],
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: TextFormField(
                  controller: textController,
                  style: TextStyle(color: kBlackColor),
                  decoration: const InputDecoration(
                    labelText: 'Tên',
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: DefaultButton(
            press: () async {
              print('update ${textController.text}');
              bool result = false;
              print('label $labelInfo');
              if (labelInfo == 'địa chỉ') {
                result =
                    await Provider.of<UserViewModel>(context, listen: false)
                        .updateUser(textController.text, 'address');
              } else if (labelInfo == 'tên') {
                result =
                    await Provider.of<UserViewModel>(context, listen: false)
                        .updateUser(textController.text, 'name');
              }
              if (result) {
                print('lay thanh cong');
                Navigator.pop(context);
              }
            },
            text: "Lưu",
          ),
        )
      ],
    );
  }
}

class BuildTextField extends StatelessWidget {
  const BuildTextField({
    super.key,
    required this.labelText,
    required this.iconText,
    required this.editTex,
    required this.controller,
  });
  final String labelText, iconText;
  final Function editTex;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        // enabled: false,
        readOnly: true,
        controller: controller,
        decoration: InputDecoration(
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/$iconText"),
            suffixIcon: IconButton(
              icon: SvgPicture.asset(
                "assets/icons/$iconText",
                height: 19,
              ),
              onPressed: () {
                editTex();

                //phone number
                // Navigator.pushNamed(context, '/profile/phone-number');

                //girl/boy
              },
            )));
  }
}
