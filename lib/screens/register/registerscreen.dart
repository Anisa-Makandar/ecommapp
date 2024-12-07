import 'package:ecommapp/domain/custom_button.dart';
import 'package:ecommapp/domain/custome_textfield.dart';
import 'package:ecommapp/screens/login/loginscreen.dart';
import 'package:ecommapp/screens/register/bloc/register_user_bloc.dart';
import 'package:ecommapp/screens/register/bloc/register_user_event.dart';
import 'package:ecommapp/screens/register/bloc/register_user_state.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Registerscreen extends StatefulWidget {
  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  final TextEditingController firstnameController = TextEditingController();

  final TextEditingController lastnameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passController = TextEditingController();

  final TextEditingController confirmpassController = TextEditingController();

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
                    'assets/icons/register.png',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(8),
                height: 650,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(239, 255, 255, 255),
                    borderRadius: BorderRadius.circular(18)),
                child: Column(
                  children: [
                    const Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    CustomeTextfield(
                      controller: firstnameController,
                      label: 'First Name',
                      hintText: 'Enter first name here...',
                    ),
                    const SizedBox(height: 20),
                    CustomeTextfield(
                      controller: lastnameController,
                      label: 'Last Name',
                      hintText: 'Enter last name here...',
                    ),
                    const SizedBox(height: 20),
                    CustomeTextfield(
                      controller: phoneController,
                      label: 'Phone Number',
                      hintText: 'Enter phone number here...',
                    ),
                    const SizedBox(height: 20),
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
                    const SizedBox(height: 20),
                    CustomeTextfield(
                      controller: confirmpassController,
                      label: 'Confirm Password',
                      hintText: 'Enter confirm pssword here...',
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 30,
                    ),
                    BlocListener<RegisterUserBloc, RegisterUserState>(
                      listener: (context, state) {
                        if (state is RegisterUserLoadingState) {
                          isLoading = true;
                          setState(() {});
                        }
                        if (state is RegisterUserSuccessState) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("User Registerd Successfully...")));
                        }
                        if (state is RegisterUserFailureState) {
                          isLoading = false;
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("${state.errorMsg}")));
                          setState(() {});
                        }
                      },
                      child: CustomButton(
                        text: 'Sign Up',
                        isLoading: isLoading,
                        onPressed: () {
                          if (firstnameController.text.isNotEmpty &&
                              lastnameController.text.isNotEmpty &&
                              emailController.text.isNotEmpty &&
                              phoneController.text.isNotEmpty &&
                              passController.text.isNotEmpty &&
                              confirmpassController.text.isNotEmpty) {
                            if (passController.text ==
                                confirmpassController.text) {
                              context
                                  .read<RegisterUserBloc>()
                                  .add(CreateUserEvent(
                                    name:
                                        "${firstnameController.text} ${lastnameController.text}",
                                    email: emailController.text,
                                    mobNo: phoneController.text,
                                    pass: passController.text,
                                  ));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("Password doesn't match")));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "Please fill all the required blanks !!!")));
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text.rich(
                        TextSpan(
                            text: 'Already have an account? ',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Sign In',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFFFF660E),
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()),
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
