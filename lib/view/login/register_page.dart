import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetask/controller/authlogin_provider.dart';
import 'package:firebasetask/view/components/mytextfield.dart';
import 'package:firebasetask/view/homepage/homepage.dart';
import 'package:firebasetask/view/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(255, 221, 255, 245),
        body: Consumer<Authprovider>(
          builder: (context, authprovider, child) {
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      const Padding(
                        padding: EdgeInsets.only(left: 25),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Enter Your Email ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                      MyTextField(
                        controller: authprovider.emailController,
                        hintText: 'E-mail',
                        obscureText: false,
                        inputtype: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 20),
                      MyTextField(
                        controller: authprovider.passwordController,
                        hintText: 'Password',
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      MyTextField(
                        controller: authprovider.confirmPasswordController,
                        hintText: 'Confirm Password',
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width / 1.2,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                authprovider.registerUser(context);
                              },
                              child: const Text(
                                "Register",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ));
                        },
                        child: Text.rich(TextSpan(children: [
                          TextSpan(text: "Already Have an Account \b"),
                          TextSpan(
                              text: "Login now",
                              style: TextStyle(color: Colors.blue))
                        ])),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          // child:
        ),
      ),
    );
  }
}
