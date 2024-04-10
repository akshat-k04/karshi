import 'package:flutter/material.dart';
import 'package:karshi/User/Home_page.dart';
import 'package:karshi/auth%20files/forgotPassword.dart';
import 'package:karshi/auth%20files/signup.dart';
import 'package:karshi/backend/auth.dart';
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
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserAuth?>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Welcome To Krashi app',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
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
                onPressed: () {
                  // Add your sign in logic here
                  dynamic result = _auth.signIn(email.text, password.text);
                  // print(result.uid);
                  print("hello");
                  if (user != null) print(user.uid);
                  // Navigator.push(
                  //   context,
                  //   PageRouteBuilder(
                  //     transitionDuration: Duration(milliseconds: 500),
                  //     pageBuilder: (context, animation, secondaryAnimation) =>
                  //         HomePage(),
                  //     transitionsBuilder:
                  //         (context, animation, secondaryAnimation, child) {
                  //       return FadeTransition(
                  //         opacity: animation,
                  //         child: child,
                  //       );
                  //     },
                  //   ),
                  // );
                },
                child: const Text('Sign in'),
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 500),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  SignupPage(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    child: const Text('Sign Up'),
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
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          ForgotPasswordScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
                child: const Text('Forgot Password?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
