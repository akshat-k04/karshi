import 'package:flutter/material.dart';
import 'package:karshi/User/Cart.dart';
import 'package:karshi/User/Home_page.dart';
import 'package:karshi/backend/models/models.dart';
import 'package:karshi/backend/services/auth.dart';
import 'package:karshi/backend/services/customer_services.dart';
import 'package:karshi/seller/dashboard.dart';
import 'package:provider/provider.dart';
import 'app_colors.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final AuthService _auth = AuthService();
  bool isUserSignup = true;
  String _owner_name = '';
  String _customer_name = '';
  String _shop_name = '';
  String _password = '';
  String _address = '';
  int _mobile_number = 0;
  String _email = '';

  String? _nameError;
  String? _ownerNameError;
  String? _shopNameError;
  String? _passwordError;
  String? _addressError;
  String? _mobileNumberError;
  String? _emailError;
  List<Item> product = [];
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserAuth?>(context);

    return Scaffold(
      backgroundColor: MyAppColors.backgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30.0),
        child: Column(
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
              'Create your account',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: MyAppColors.textColor),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  isUserSignup = true;
                });
              },
              style: TextButton.styleFrom(
                backgroundColor:
                    isUserSignup ? Colors.white : MyAppColors.bgGreen,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(5.0), // Set the corner radius here
                ),
              ),
              child: Text(
                'Signup as Buyer',
                style: TextStyle(color: MyAppColors.textColor),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  isUserSignup = false;
                });
              },
              style: TextButton.styleFrom(
                backgroundColor:
                    !isUserSignup ? Colors.white : MyAppColors.bgGreen,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(5.0), // Set the corner radius here
                ),
              ),
              child: Text(
                'Signup as Seller',
                style: TextStyle(color: MyAppColors.textColor),
              ),
            ),
            const SizedBox(height: 100.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [],
            ),
            SizedBox(height: 20.0),
            if (!isUserSignup)
              TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    labelText: 'Owner Name', errorText: _ownerNameError),
                onChanged: (val) {
                  setState(() => _owner_name = val);
                },
              ),
            if (!isUserSignup) SizedBox(height: 10.0),
            if (!isUserSignup)
              TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    labelText: 'Shop Name', errorText: _shopNameError),
                onChanged: (val) {
                  setState(() => _shop_name = val);
                },
              ),
            if (isUserSignup) SizedBox(height: 10.0),
            if (isUserSignup)
              TextField(
                style: TextStyle(color: Colors.white),
                decoration:
                    InputDecoration(labelText: 'Name', errorText: _nameError),
                onChanged: (val) {
                  setState(() => _customer_name = val);
                },
              ),
            SizedBox(height: 10.0),
            TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  labelText: 'Password', errorText: _passwordError),
              obscureText: true,
              onChanged: (val) {
                setState(() => _password = val);
              },
            ),
            SizedBox(height: 10.0),
            TextField(
              style: TextStyle(color: Colors.white),
              decoration:
                  InputDecoration(labelText: 'Email', errorText: _emailError),
              onChanged: (val) {
                setState(() => _email = val);
              },
            ),
            SizedBox(height: 10.0),
            TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  labelText: 'Address', errorText: _addressError),
              onChanged: (val) {
                setState(() => _address = val);
              },
            ),
            SizedBox(height: 10.0),
            TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  labelText: 'Mobile Number', errorText: _mobileNumberError),
              onChanged: (val) {
                setState(() => _mobile_number = int.tryParse(val) ?? 0);
              },
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(MyAppColors.bgGreen),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Corner radius
                    ),
                  )),
              onPressed: () async {
                setState(() {
                  _ownerNameError = isUserSignup
                      ? null
                      : (_owner_name.isEmpty
                          ? 'Owner Name cannot be empty'
                          : null);
                  _shopNameError = isUserSignup
                      ? null
                      : (_shop_name.isEmpty
                          ? 'Shop Name cannot be empty'
                          : null);
                  _nameError = isUserSignup
                      ? (_customer_name.isEmpty ? 'Name cannot be empty' : null)
                      : null;
                  _passwordError =
                      _password.isEmpty ? 'Password cannot be empty' : null;
                  _emailError = _email.isEmpty ? 'Email cannot be empty' : null;
                  _addressError =
                      _address.isEmpty ? 'Address cannot be empty' : null;
                  _mobileNumberError = _mobile_number == 0
                      ? 'Mobile Number cannot be empty'
                      : null;
                });

                if (_nameError == null &&
                    _ownerNameError == null &&
                    _shopNameError == null &&
                    _passwordError == null &&
                    _emailError == null &&
                    _addressError == null &&
                    _mobileNumberError == null) {
                  dynamic result;
                  if (!isUserSignup) {
                    result = await _auth.register_shopkeeper(
                        _email,
                        _password,
                        _shop_name,
                        _owner_name,
                        _mobile_number,
                        _address,
                        '0',
                        '0');
                  } else {
                    result = await _auth.register_customer(_email, _password,
                        _customer_name, _mobile_number, _address);
                  }

                  if (result == null) {
                    print("Not Signed in");
                  } else {
                    if (isUserSignup) {
                      setState(() async {
                        product =
                            await CustomerService(uid: user!.uid).getAllItems();
                      });
                    }
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 500),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            isUserSignup
                                ? HomePage(
                                    products: product,
                                  )
                                : Dashboard(products: []),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ),
                    );
                  }
                }
              },
              child: Text(
                'Sign Up',
                style: TextStyle(color: MyAppColors.textColor),
              ),
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Already have an account?',
                  style: TextStyle(color: MyAppColors.textColor),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Sign In',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
