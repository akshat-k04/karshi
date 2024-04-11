import 'dart:async';

import 'package:flutter/material.dart';
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

class MyAppColors {
  static const Color textColor =
      Color.fromRGBO(14, 197, 93, 100); // Custom green color
  static const Color backgroundColor =
      Color.fromRGBO(0, 27, 21, 100); // Custom green color
  // Custom green color
  static const Color bgGreen =
      Color.fromRGBO(0, 37, 28, 100); // Custom green color
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
            : Padding(
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
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    TextField(
                      controller: password,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              MyAppColors.bgGreen)), // Custom background color

                      onPressed: () async {
                        // Add your sign in logic here
                        setState(() {
                          isLoading = true;
                        });
                        dynamic result =
                            await _auth.signIn(email.text, password.text);

                        if (user != null) {
                          // signin successful
                          // fetch data code here
                          RoleModel? user_role =
                              await Role(uid: user.uid).getRole();

                          print(user_role!.role);
                          isCustomer = user_role.role == 'Customer';
                          List<Item> productlist;
                          if (isCustomer) {
                            productlist = await CustomerService(uid: user.uid)
                                .getAllItems();
                          } else {
                            productlist = await ShopKeeperService(uid: user.uid)
                                .getItems();
                          }
                          setState(() {
                            isLoading = false;
                          });
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 500),
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      isCustomer
                                          ? HomePage()
                                          : Dashboard(products: productlist),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                            ),
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
                                transitionDuration: Duration(milliseconds: 500),
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
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
                        Navigator.push(
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
    );
  }
}
