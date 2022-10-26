import 'package:app_food_mobile/constants.dart';
import 'package:flutter/material.dart';

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
    return SafeArea(
      child: SizedBox(
          child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Spacer(),
            Expanded(
                flex: 3,
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
                  SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Continue',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      )),
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
