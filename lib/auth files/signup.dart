import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isUserSignup = true;

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
            ),
            SizedBox(height: 10.0),
            if (!isUserSignup)
              TextField(
                decoration: InputDecoration(labelText: 'Owner Name'),
              ),
            SizedBox(height: 10.0),
            if (!isUserSignup)
              TextField(
                decoration: InputDecoration(labelText: 'Shop Name'),
              ),
            SizedBox(height: 10.0),
            TextField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 10.0),
            TextField(
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 10.0),
            TextField(
              decoration: InputDecoration(labelText: 'Address'),
            ),
            SizedBox(height: 10.0),
            if (!isUserSignup)
              TextField(
                decoration: InputDecoration(labelText: 'Mobile Number'),
              ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Add signup logic
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
