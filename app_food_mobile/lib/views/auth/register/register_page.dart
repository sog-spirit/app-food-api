import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterScreen({super.key, required this.showLoginPage});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  
  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
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
              child: SingleChildScrollView(
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
                        "Register Now",
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //first name
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: TextFormField(
                            controller: _firstNameController,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'First Name'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //last name
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: TextFormField(
                            controller: _lastNameController,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Last Name'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //age
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: TextFormField(
                            controller: _ageController,
                            decoration: const InputDecoration(
                                border: InputBorder.none, hintText: 'Age'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //email textfield
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                                border: InputBorder.none, hintText: 'Email'),
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
                          padding: const EdgeInsets.only(left: 12),
                          child: TextField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                                border: InputBorder.none, hintText: 'Password'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //confirm passwordsdsd
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: TextFormField(
                            obscureText: true,
                            controller: _confirmPasswordController,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Password Again'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //connform password

                      //sign in button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(top: 20, bottom: 20),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                "SIGN UP",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
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
                            onTap: widget.showLoginPage,
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
      ),
    );
  }
}
