import 'package:ecommapp/domain/custom_button.dart';
import 'package:ecommapp/domain/custome_textfield.dart';
import 'package:ecommapp/screens/dashboard/bottomnavigation.dart';
import 'package:ecommapp/screens/login/bloc/login_user_bloc.dart';
import 'package:ecommapp/screens/login/bloc/login_user_event.dart';
import 'package:ecommapp/screens/login/bloc/login_user_state.dart';
import 'package:ecommapp/screens/register/registerscreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passController = TextEditingController();

  bool isLoading = false;

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
                    BlocListener<LoginUserBloc, LoginUserState>(
                      listener: (context, state) {
                        if (state is LoginUserLoadingState) {
                          isLoading = true;
                          setState(() {});
                        }
                        if (state is LoginUserFailureState) {
                          isLoading = false;
                          setState(() {});
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.errorMsg)));
                        }
                        if (state is LoginUserSuccessState) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NavifationPage(),
                              ));
                        }
                      },
                      child: CustomButton(
                        text: 'Sign In',
                        isLoading: isLoading,
                        onPressed: () async {
                          context.read<LoginUserBloc>().add(AuthenticateUser(
                              email: emailController.text,
                              pass: passController.text));
                        },
                      ),
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
