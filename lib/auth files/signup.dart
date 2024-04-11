import 'package:flutter/material.dart';
import 'package:karshi/User/Cart.dart';
import 'package:karshi/User/Home_page.dart';
import 'package:karshi/backend/models/models.dart';
import 'package:karshi/backend/services/auth.dart';
import 'package:karshi/backend/services/customer_services.dart';
import 'package:karshi/seller/dashboard.dart';
import 'package:provider/provider.dart';

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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 100.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      isUserSignup = true;
                    });
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: isUserSignup ? Colors.blue : Colors.grey,
                  ),
                  child: Text(
                    'Signup as User',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      isUserSignup = false;
                    });
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: !isUserSignup ? Colors.blue : Colors.grey,
                  ),
                  child: Text(
                    'Signup as Seller',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            if (!isUserSignup)
              TextField(
                decoration: InputDecoration(
                    labelText: 'Owner Name', errorText: _ownerNameError),
                onChanged: (val) {
                  setState(() => _owner_name = val);
                },
              ),
            if (!isUserSignup) SizedBox(height: 10.0),
            if (!isUserSignup)
              TextField(
                decoration: InputDecoration(
                    labelText: 'Shop Name', errorText: _shopNameError),
                onChanged: (val) {
                  setState(() => _shop_name = val);
                },
              ),
            if (isUserSignup) SizedBox(height: 10.0),
            if (isUserSignup)
              TextField(
                decoration:
                    InputDecoration(labelText: 'Name', errorText: _nameError),
                onChanged: (val) {
                  setState(() => _customer_name = val);
                },
              ),
            SizedBox(height: 10.0),
            TextField(
              decoration: InputDecoration(
                  labelText: 'Password', errorText: _passwordError),
              obscureText: true,
              onChanged: (val) {
                setState(() => _password = val);
              },
            ),
            SizedBox(height: 10.0),
            TextField(
              decoration:
                  InputDecoration(labelText: 'Email', errorText: _emailError),
              onChanged: (val) {
                setState(() => _email = val);
              },
            ),
            SizedBox(height: 10.0),
            TextField(
              decoration: InputDecoration(
                  labelText: 'Address', errorText: _addressError),
              onChanged: (val) {
                setState(() => _address = val);
              },
            ),
            SizedBox(height: 10.0),
            TextField(
              decoration: InputDecoration(
                  labelText: 'Mobile Number', errorText: _mobileNumberError),
              onChanged: (val) {
                setState(() => _mobile_number = int.tryParse(val) ?? 0);
              },
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
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
                      setState(()async {
                        product=
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
              child: Text('Sign Up'),
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Already have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Sign In'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
