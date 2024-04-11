import 'dart:async';

import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'package:karshi/User/Home_page.dart';
import 'package:karshi/auth%20files/forgotPassword.dart';
import 'package:karshi/auth%20files/signup.dart';
import 'package:karshi/backend/models/models.dart';
import 'package:karshi/backend/services/auth.dart';
import 'package:karshi/backend/services/customer_services.dart';
import 'package:karshi/backend/services/shopkeeper_services.dart';
import 'package:karshi/custom%20widgets/loading_page.dart';
import 'package:karshi/seller/dashboard.dart';
import 'package:provider/provider.dart';

class SigninScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignupScreenState();
  }
}

class SignupScreenState extends State<SigninScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;
  bool isCustomer = false;
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserAuth?>(context);

    return Scaffold(
      backgroundColor: MyAppColors.backgroundColor,
      body: SafeArea(
        child: isLoading
            ? LoadingPage()
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image(
                        image: AssetImage('assets/images/loginbg.png'),
                      ),
                      const Text(
                        'Welcome To Krashi app',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const Text(
                        'Login to your account',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: MyAppColors.textColor),
                      ),
                      const SizedBox(height: 20.0),
                      TextField(
                        controller: email,
                        decoration: InputDecoration(
                            labelText: 'E-mail',
                            labelStyle: TextStyle(color: Colors.white)),
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 10.0),
                      TextField(
                        controller: password,
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.white)),
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 20.0),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                MyAppColors
                                    .bgGreen)), // Custom background color

                        onPressed: () async {
                          // Add your sign in logic here
                          setState(() {
                            isLoading = true;
                          });

                          UserAuth result =
                              await _auth.signIn(email.text, password.text);
                          print('hello hii1245');
                          // setState(() {});
                          if (result != null) {
                            // signin successful
                            print('hello hii');
                            // fetch data code here

                            RoleModel? user_role =
                                await Role(uid: result.uid).getRole();
                            print("bye");
                            print(user_role!.role);
                            isCustomer = (user_role.role == 'Customer');
                            // setState(() {});

                            // List<Item> productlist;
                            // if (isCustomer) {
                            //   productlist = await CustomerService(uid: result.uid)
                            //       .getAllItems();
                            // } else {
                            //   productlist =
                            //       await ShopKeeperService(uid: result.uid)
                            //           .getItems();
                            // }
                            // if (productlist.isEmpty == true) productlist = [];
                            setState(() {
                              isLoading = false;
                            });

                            Navigator.pushAndRemoveUntil(
                              context,
                              PageRouteBuilder(
                                transitionDuration: Duration(milliseconds: 500),
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        isCustomer
                                            ? HomePage(
                                                uid: result.uid,
                                              )
                                            : Dashboard(uid: result.uid),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                              ),
                              (route) => false,
                            );
                          }
                          setState(() {
                            isLoading = false;
                          });
                        },
                        child: const Text(
                          'Sign in',
                          style: TextStyle(color: MyAppColors.textColor),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(color: MyAppColors.textColor),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 500),
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      SignupPage(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      // const SizedBox(height: 0.0),
                      TextButton(
                        onPressed: () {
                          // Add your forgot password logic here
                          Navigator.pushAndRemoveUntil(
                            context,
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 500),
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      ForgotPasswordScreen(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                            ),
                            (route) => false,
                          );
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(color: MyAppColors.textColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
