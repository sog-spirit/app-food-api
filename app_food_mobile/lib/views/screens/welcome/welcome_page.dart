import 'package:app_food_mobile/components/default_button.dart';
import 'package:app_food_mobile/views/auth/login_page.dart';
import 'package:app_food_mobile/views/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../constants.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int currentPage = 0;

  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to Tokoto. Let's shop!",
      "image": "assets/images/splash_1.png"
    },
    {
      "text":
          "We help people connect with store\n arround United State of America",
      "image": "assets/images/splash_2.png"
    },
    {
      "text": "We show the easy way to shop. \nJust stay at home with us",
      "image": "assets/images/splash_3.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Đăng nhập tài khoản"))),
      body: SafeArea(
        child: SizedBox(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Spacer(),
              Expanded(
                  flex: 6,
                  child: PageView.builder(
                    onPageChanged: (value) {
                      setState(() {
                        currentPage = value;
                      });
                    },
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return WelcomeContent(
                        text: splashData[index]["text"].toString(),
                        image: splashData[index]["image"].toString(),
                      );
                    },
                  )),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(splashData.length,
                            (index) => buildDot(index: index))),
                    SizedBox(height: 20),
                    DefaultButton(
                      press: () {
                        // Navigator.pushNamed(context, '/sign-in');

                        PersistentNavBarNavigator
                            .pushNewScreenWithRouteSettings(
                          context,
                          settings: RouteSettings(name: '/sign-in'),
                          screen: LoginScreen(),
                          withNavBar: false,
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                      text: "Đăng nhập",
                    )
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: kThemeAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
          color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
          borderRadius: BorderRadius.circular(3)),
    );
  }
}

class WelcomeContent extends StatelessWidget {
  const WelcomeContent({
    Key? key,
    required this.text,
    required this.image,
  }) : super(key: key);
  final String text, image;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        'TOKOTO',
        style: TextStyle(
            decoration: TextDecoration.none,
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: kPrimaryColor),
      ),
      Text(
        text,
        style: TextStyle(
            decoration: TextDecoration.none,
            fontSize: 12,
            color: ksecondaryColor),
      ),
      Spacer(flex: 2),
      Image.asset(
        image,
        height: 265,
        width: 235,
      )
    ]);
  }
}
