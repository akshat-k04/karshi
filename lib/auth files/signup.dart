import 'package:flutter/material.dart';
import 'package:karshi/User/Home_page.dart';
import 'package:karshi/backend/auth.dart';

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

  @override
  Widget build(BuildContext context) {
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
            TextField(
              decoration: InputDecoration(labelText: 'Name'),
              onChanged: (val){
                                setState(() => _customer_name = val);
                              },
            ),
            SizedBox(height: 10.0),
            if (!isUserSignup)
              TextField(
                decoration: InputDecoration(labelText: 'Owner Name'),
                onChanged: (val){
                                setState(() => _owner_name = val);
                              },
              ),
            SizedBox(height: 10.0),
            if (!isUserSignup)
              TextField(
                decoration: InputDecoration(labelText: 'Shop Name'),
                onChanged: (val){
                                setState(() => _shop_name = val);
                              },
              ),
            SizedBox(height: 10.0),
            TextField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              onChanged: (val){
                                setState(() => _password = val);
                              },
            ),
            SizedBox(height: 10.0),
            TextField(
              decoration: InputDecoration(labelText: 'Email'),
              onChanged: (val){
                                setState(() => _email = val);
                              },
            ),
            SizedBox(height: 10.0),
            TextField(
              decoration: InputDecoration(labelText: 'Address'),
              onChanged: (val){
                                setState(() => _address = val);
                              },
            ),
            SizedBox(height: 10.0),
            if (!isUserSignup)
              TextField(
                decoration: InputDecoration(labelText: 'Mobile Number'),
                onChanged: (val){
                                setState(() => _mobile_number = int.parse(val));
                              },
              ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                // Add signup logic
                dynamic result;
                if(!isUserSignup){
                  result = await _auth.register_shopkeeper(_email, _password, _shop_name, _owner_name, _mobile_number, _address, '0', '0');
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 500),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          HomePage(),
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
                else {
                  result = await _auth.register_customer(_email, _password, _customer_name, _mobile_number, _address);
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 500),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          HomePage(),
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
                if(result == null){
                  print("Not Signed in");
                }
                // dynamic result = await _auth.register_shopkeeper(email, password, shop_name, owner_name, mobile_number, shop_address, latitude, longitude)
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
                    // Navigate to Sign In page (implementation needed)
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
