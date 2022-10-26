import 'package:app_food_mobile/views/pages/main_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

import '../../screens/home/home_page.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginScreen({super.key, required this.showRegisterPage});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernamelController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  void login(String username, String password) async {
    print("login");
    //xu ly login
    try {
      Response response = await post(
          Uri.parse("http://192.168.1.4:8000/api/user/login"),
          body: {"username": "admin", "password": "admin"});
      print('adduyen thanh cong');
      if (response.statusCode == 200) {
        print('adduyen thanh cong');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
        //chuyen qua man hinh main
      } else {
        print('failed');
      }
    } catch (e) {
      print('failedsdfds');
      print(e.toString());
    }
  }

  @override
  void dispose() {
    _usernamelController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //hello again
                    Text(
                      'Hello Again',
                      style: GoogleFonts.bebasNeue(fontSize: 52),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Welcome back, you've been missed",
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //usernamel textfield
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: TextFormField(
                          controller: _usernamelController,
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: 'usernamel'),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    //password textfield
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: TextFormField(
                          obscureText: true,
                          controller: _passwordController,
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: 'Password'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //forgot button

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: const Text(
                              "Forgot password ?",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 25, 88, 139),
                                  fontSize: 15),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //sign in button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: GestureDetector(
                        onTap: () {
                          login(_usernamelController.text.toString(),
                              _passwordController.text.toString());
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              "SIGN IN",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Not a member ?",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: widget.showRegisterPage,
                          child: const Text(
                            "Register Now",
                            style: TextStyle(color: Colors.blue),
                          ),
                        )
                      ],
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
