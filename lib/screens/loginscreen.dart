import 'package:ecommapp/domain/custom_button.dart';
import 'package:ecommapp/domain/custome_textfield.dart';
import 'package:ecommapp/screens/bottomnavigation.dart';
import 'package:ecommapp/screens/registerscreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xEFFF8F0E),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.only(top: 20),
                  height: 200,
                  width: 400,
                  child: Image.asset(
                    'assets/icons/mobile-shopping-how-to-create-a-perfect-customer-experience-removebg-preview.png',
                  ),
                ),
              ),
              Text(
                'Hello,',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 25,
                  fontFamily: 'primaryFont',
                ),
              ),
              Text(
                'Welcome Back !',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(8),
                height: 450,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(239, 255, 255, 255),
                    borderRadius: BorderRadius.circular(18)),
                child: Column(
                  children: [
                    const Text(
                      "Enter to Your Account",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    CustomeTextfield(
                      controller: emailController,
                      label: 'Email',
                      hintText: 'Enter email here...',
                    ),
                    const SizedBox(height: 20),
                    CustomeTextfield(
                      controller: passController,
                      label: 'Password',
                      hintText: 'Enter password here...',
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Forgot password ?',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    CustomButton(
                      text: 'Sign In',
                      onPressed: () async {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NavifationPage()),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text.rich(
                        TextSpan(
                            text: 'Don\'t have an account? ',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Sign up',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFFFF660E),
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Registerscreen()),
                                    );
                                  },
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
