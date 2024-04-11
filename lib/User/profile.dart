import 'package:flutter/material.dart';
import 'package:karshi/auth%20files/signin.dart';
import 'package:karshi/backend/models/models.dart';
import 'package:karshi/backend/services/auth.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserAuth?>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          _buildTextField("Name", _nameController, true),
          SizedBox(height: 16.0),
          _buildTextField("Address", _addressController, true),
          SizedBox(height: 16.0),
          _buildTextField("Mobile Number", _mobileController, true),
          SizedBox(height: 16.0),
          _buildTextField("Email",
              TextEditingController(text: "example@example.com"), false),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Handle update profile logic
              print('Profile updated');
            },
            child: Text('Update Profile'),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: ()async {
              // Handle update profile logic
              await _auth.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      SigninScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ),
                (route) => false,
              );

              print('Profile updated');
            },
            child: Text('Sign out'),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, bool editable) {
    return TextField(
      controller: controller,
      enabled: editable,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed
    _nameController.dispose();
    _addressController.dispose();
    _mobileController.dispose();
    super.dispose();
  }
}
